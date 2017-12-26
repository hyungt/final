package com.ese.controller.engineer;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ese.common.encrypt.Sha256;
import com.ese.service.engineer.EngineerService;
import com.ese.vo.hr.Employee;

@Controller
public class EngineerController {
	
	@Autowired
	EngineerService engineerService;
	
	
	@RequestMapping(value="/engineer/main.do", method=RequestMethod.GET)
	public String login (Model model, HttpSession session) {
		
		model.addAttribute("alert", engineerService.getBoardMainLimit());
		
		session.invalidate();
		
		return "engineer/main";
	}
	
	@RequestMapping(value="/engineer/main.do", method=RequestMethod.POST)
	public String loginProcess (@RequestParam("email") String email,
								@RequestParam("pwd") String pwd,
								HttpSession session) {
		
		System.out.println(email);
		System.out.println(pwd);
		
 		Employee engineer = engineerService.getEmployeeDetailById(email);
 		System.out.println(engineer);
 		String pass = Sha256.encrypt(pwd);
 		
 		if(engineer == null) {
 			return "redirect:/engineer/main.do?error=fail";
 		}
 		if(!engineer.getPassword().equals(pass)) {
			return "redirect:/engineer/main.do?error=fail";
		}
 		
 		session.setAttribute("loginEngineer", engineer);
 		
 		if(engineer.getDepartment().getId().equals("DEPT-HR")) {
 			return "redirect:/manage/login.do?error=otheremp";
 		}
 		
 		if(engineer.getPosition().getId().equals("POS-CM")) {
 			return "redirect:/engineer/emplist.do";
 		}
		
		return "redirect:/engineer/alert.do";
	}
	
}
