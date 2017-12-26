package com.ese.controller.engineer.cm;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ese.service.engineer.EngineerService;
import com.ese.vo.hr.Break;
import com.ese.vo.hr.Employee;

@Controller
public class CenterMasterController {
	
	@Autowired
	EngineerService engineerService;
	
	@RequestMapping("/engineer/emplist.do")
	public String emplist (Model model, HttpSession session) {
		
		Employee chief = (Employee)session.getAttribute("loginEngineer");
		List<Employee> emplist = engineerService.getEmployeeToCenterId(chief.getCenter().getId());
		model.addAttribute("AllEmployees", emplist);
		
		return "engineer/chief/emplist";
	}
	
	@RequestMapping("/engineer/accept.do")
	public String vacation (Model model, HttpSession session) {
		
		Employee employee = (Employee)session.getAttribute("loginEngineer");
		
		model.addAttribute("centerId", employee.getCenter().getId());
		
		return "engineer/chief/accept";
	}
	
	@RequestMapping("/engineer/reservestatus.do")
	public String reserve (Model model) {
		
		model.addAttribute("Reserve", engineerService.ForReserveList());
		
		return "engineer/chief/reservestatus";
	}
}
