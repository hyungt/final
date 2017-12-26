package com.ese.controller.manage;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ese.common.encrypt.Sha256;
import com.ese.service.manage.BreakApplyService;
import com.ese.service.manage.EmployeeService;
import com.ese.service.notice.EmployeeNoticeService;
import com.ese.vo.afterservice.Center;
import com.ese.vo.forms.EmployeeForm;
import com.ese.vo.hr.Department;
import com.ese.vo.hr.Employee;
import com.ese.vo.hr.Position;
import com.ese.vo.notice.EmployeeNotice;
import com.ese.vo.pagination.notice.Pagination;

@Controller
public class EmployeeController {

	
	@Autowired
	private ServletContext servletContext;
	
	
	@Autowired
	EmployeeService employeeService;
	
	@Autowired
	BreakApplyService breakApplyService;
	
	@Autowired
	EmployeeNoticeService employeeNoticeService;
	
	
	@RequestMapping("/manage/personnel/emplist.do")
	public String getAllEmp(Model model, HttpSession session) {
		model.addAttribute("employees", employeeService.getAllEmp());
		model.addAttribute("loginEmployee", session.getAttribute("loginedHR"));
		return "manage/personnel/personnelList";
	}
	
	@RequestMapping("/manage/personnel/form.do")
	public String form(Model model, HttpSession session) {
		model.addAttribute("employeeForm", new EmployeeForm());
		model.addAttribute("centerList", employeeService.getAllCenter());
		model.addAttribute("loginEmployee", session.getAttribute("loginedHR"));
		return "manage/personnel/personnelAdd";
	}
	
	
	@RequestMapping("/manage/personnel/addemp.do")
	public String register(@Valid EmployeeForm employeeForm, BindingResult errors) throws IOException {
			
			String email = employeeForm.getEmail();
			if(employeeService.getEmpById(email) != null) {
				return "redirect:/manage/personnel/form.do?err=otherEmail";
			}else if(employeeForm.getPassword().length() < 6){
				return "redirect:/manage/personnel/form.do?err=shortPassword";
			} else {
				Center center = new Center(); 
				center.setId(employeeForm.getCenter());
				Department department = new Department();
				department.setId(employeeForm.getDepartment());
				Position position = new Position();
				position.setId(employeeForm.getPosition());
			
				System.out.println(employeeForm);
				Employee employee = new Employee();
				BeanUtils.copyProperties(employeeForm, employee);
				employee.setPassword(Sha256.encrypt(employeeForm.getPassword()));
				employee.setCenter(center);
				employee.setDepartment(department);
				employee.setPosition(position);
				
				// 첨부파일을 특정 폴더에 저장하는 처리
				MultipartFile pic = employeeForm.getPic();
				String uploadDirectory = servletContext.getRealPath("/resources/images/emp");
				if(!pic.isEmpty()){
					String filename = System.currentTimeMillis() + pic.getOriginalFilename();
					employee.setPic(filename);
					
					FileCopyUtils.copy(pic.getBytes(), new File(uploadDirectory, filename));
				};

				employeeService.addEmp(employee);
		
				return "redirect:/manage/personnel/form.do";
			}
	}
	
	@RequestMapping("/manage/personnel/hoildayPer.do")
	public String getAllDeptHoilday(Model model, HttpSession session) {
		model.addAttribute("employees", employeeService.getAllDeptHoilday() );
		model.addAttribute("loginEmployee", session.getAttribute("loginedHR"));
		return "/manage/personnel/holidayPersonnel";
	}
		
	@RequestMapping("/manage/personnel/apply.do")
	public String holidayApplyList(Model model, HttpSession session) {
		model.addAttribute("applylist", breakApplyService.getAllBreak());
		model.addAttribute("loginEmployee", session.getAttribute("loginedHR"));
		return "/manage/personnel/holidayApplyList";
	}
	
	@RequestMapping("/manage/login.do")
	public String login(Model model, HttpSession session) {
		model.addAttribute("notis" ,employeeNoticeService.getTwoRows());
		Employee employee  = (Employee) session.getAttribute("loginedHR");
		
		if(employee != null) {
			if(employee.getDepartment().getId().equals("DEPT-HR")) {
	 			return "redirect:/manage/personnel/main.do";
	 		}
	 		if(employee.getDepartment().getId().equals("DEPT-INVEN")) {
	 			return "redirect:/manage/part/main.do";
	 		}
	 		if(employee.getDepartment().getId().equals("DEPT-ADMIN")) {
	 			return "redirect:/manage/dayResult.do";
	 		}
	 		if(employee.getDepartment().getId().equals("DEPT-FIN")) {
	 			return "redirect:/manage/finance/main.do";
	 		}
	 		if(employee.getDepartment().getId().equals("DEPT-SC")) {
	 			session.removeAttribute("loginedHR");
	 			return "redirect:/engineer/main.do?error=otheremp";
	 		}
			
			
		}
		return "/manage/login";
	}
	
	@RequestMapping("/manage/logincheck.do")
	public String loginProcess (@RequestParam("email") String email,
								@RequestParam("pwd") String pwd,
								HttpSession session) {
		
 		Employee users = employeeService.getEmpById(email);
 		
 		String pass = Sha256.encrypt(pwd);
 		
 		if(users == null) {
 			return "redirect:/manage/login.do?error=fail1";
 		}
 		if(!users.getPassword().equals(pass)) {
			return "redirect:/manage/login.do?error=fail1";
		}
 		
 		session.setAttribute("loginedHR", users);
 		
 		if(users.getDepartment().getId().equals("DEPT-SC")) {
 			return "redirect:/engineer/main.do";
 		}
 		if(users.getDepartment().getId().equals("DEPT-HR")) {
 			return "redirect:/manage/personnel/main.do";
 		}
 		if(users.getDepartment().getId().equals("DEPT-INVEN")) {
 			return "redirect:/manage/part/main.do";
 		}
 		if(users.getDepartment().getId().equals("DEPT-ADMIN")) {
 			return "redirect:/manage/dayResult.do";
 		}
 		if(users.getDepartment().getId().equals("DEPT-FIN")) {
 			return "redirect:/manage/finance/main.do";
 		}
 		
		
		return "redirect:/manage/personnel/login.do";
	}
	
	@RequestMapping(value= {"/manage/personnel/main.do", "/manage/personnel/newMain.do"})
	public String noti(Model model, Pagination pagination, HttpSession session) {
		int totalRows  = employeeNoticeService.getTotalRows(pagination);
		pagination.setTotalRows(totalRows);
		
		model.addAttribute("loginEmployee", session.getAttribute("loginedHR"));
		model.addAttribute("navi", pagination);
		model.addAttribute("notis", employeeNoticeService.getAllBoards(pagination));
		return "manage/personnel/main";
	}
	
	@RequestMapping("/manage/logout.do")
	public String logout(HttpSession session) {
		session.removeAttribute("loginedHR");
		return "redirect:/manage/login.do";
	}
	
	@RequestMapping("manage/personnel/changeInfoEmp.do")
	public String changeInfoEmp(Model model, HttpSession session) {
		Employee emp = (Employee) session.getAttribute("loginedHR");
		model.addAttribute("changeInfo", emp);
		return "manage/personnel/changeInfoEmp";
	}
	
	@RequestMapping("manage/personnel/changeEmp.do")
	public String updateEmp(@Valid EmployeeForm employeeForm, BindingResult errors)throws IOException {
			System.out.println(employeeForm.getPassword());
		
			if(employeeForm.getPassword().length() <6 || employeeForm.getPassword() == null) {
				System.out.println(employeeForm.getPassword().length());
				return "redirect:/manage/personnel/changeInfoEmp.do?err=shortPassword";
			} else if(employeeForm.getPassword().length() >12) {
				return "redirect:/manage/personnel/changeInfoEmp.do?err=longPassword";
			} else {
				Employee employee = new Employee();
				employee.setNo(employeeForm.getNo());
				BeanUtils.copyProperties(employeeForm, employee);
				employee.setPassword(Sha256.encrypt(employeeForm.getPassword()));
				
				MultipartFile pic = employeeForm.getPic();
				System.out.println(pic);
				System.out.println(employee);
				String uploadDirectory = servletContext.getRealPath("/resources/images/emp");
				if(!pic.isEmpty()){
					String filename = System.currentTimeMillis() + pic.getOriginalFilename();
					employee.setPic(filename);
					
					FileCopyUtils.copy(pic.getBytes(), new File(uploadDirectory, filename));
				
				} else {
					String empEmail = employee.getEmail();
					String empPic = employeeService.getEmpById(empEmail).getPic();
					employee.setPic(empPic);	
				}
					employeeService.changeEmp(employee);
					return "redirect:/manage/personnel/changeInfoEmp.do?success=good";
			}
	}
}


