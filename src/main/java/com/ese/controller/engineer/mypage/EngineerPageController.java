package com.ese.controller.engineer.mypage;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ese.common.encrypt.Sha256;
import com.ese.service.engineer.EngineerService;
import com.ese.vo.afterservice.Center;
import com.ese.vo.forms.BreakForm;
import com.ese.vo.forms.EmployeeForm;
import com.ese.vo.hr.Break;
import com.ese.vo.hr.Department;
import com.ese.vo.hr.Employee;
@Controller
public class EngineerPageController {
	
	@Autowired
	EngineerService engineerService;
	
	@Autowired
	private ServletContext servletContext;
	
	@RequestMapping("/engineer/mypage.do")
	public String mypage (Model model, HttpSession session) {
		
		Employee engineer = (Employee) session.getAttribute("loginEngineer");
		if(engineer == null) {
			throw new RuntimeException("로그인이 필요합니다");
		}
		
		model.addAttribute("engiNo", engineer.getNo());
		
		return "engineer/mypage/mypage";
	}
	
	@RequestMapping("/engineer/add-plan.do")
	public String addNewBreak(BreakForm breakForm, HttpSession session) throws IOException {
		Employee engineer = (Employee) session.getAttribute("loginEngineer");
		if(engineer == null) {
			throw new RuntimeException("로그인이 필요합니다");	
		}
		Break break1 = new Break();
		break1.setStartdate(breakForm.getStart());
		break1.setEnddate(breakForm.getEnd());
		break1.setReason(breakForm.getReason());
		break1.setEmployee(engineer);
		System.out.println(break1);
		
		MultipartFile img = breakForm.getFetchFile();
		System.out.println(img);
		if(!img.isEmpty()) {
			String imgepath = img.getOriginalFilename().substring(img.getOriginalFilename().indexOf("."), img.getOriginalFilename().length());
			String breakpath = System.currentTimeMillis() + engineer.getName() + "_휴가 신청서" + imgepath;
			String realpath = servletContext.getRealPath("/resources/images/vacation");
			break1.setFetchFile(breakpath);
			System.out.println(breakpath);
			File file = new File(realpath + "/" + breakpath);
																																																																									img.transferTo(file);
		}
		engineerService.NewEngBreak(break1);
		
		return "redirect:/engineer/mypage.do";
	}
	
	
	@RequestMapping("/engineer/myinfo.do")
	public String myinfo (Model model, HttpSession session) {
		
		Employee employee = (Employee)session.getAttribute("loginEngineer");
		
		EmployeeForm employeeForm = new EmployeeForm();
		
		employeeForm.setEmail(employee.getEmail());
		employeeForm.setName(employee.getName());
		employeeForm.setPhone(employee.getPhone());
		employeeForm.setDepartment(employee.getDepartment().getId());
		employeeForm.setCenter(employee.getCenter().getId());
		employeeForm.setPosition(employee.getPosition().getId());
		
		model.addAttribute("employeeForm", employeeForm);
		
		return "engineer/mypage/myinfo";
	}
	
	@RequestMapping("/engineer/update.do")
	public String modifyEmp (EmployeeForm employeeForm, HttpSession session) {
		Employee employee = (Employee)session.getAttribute("loginEngineer");
		Employee employee2 = new Employee();
		
		String pass = Sha256.encrypt(employeeForm.getPassword());
		
		employee2.setNo(employee.getNo());
		employee2.setEmail(employeeForm.getEmail());
		employee2.setPassword(pass);
		employee2.setPhone(employeeForm.getPhone());
		
		engineerService.updateForEngineer(employee2);
		
		return "redirect:/engineer/myinfocheck.do";
	}
	
	@RequestMapping("/engineer/myinfocheck.do")
	public String myinfoCheck (Model model, HttpSession session) {
		
		Employee employee = (Employee)session.getAttribute("loginEngineer");
		System.out.println(employee);
		model.addAttribute("employee", employee);
		
		return "engineer/mypage/myinfocheck";
	}
	
	
	
	

}
