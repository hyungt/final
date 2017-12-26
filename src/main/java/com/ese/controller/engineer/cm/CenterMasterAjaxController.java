package com.ese.controller.engineer.cm;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ese.service.engineer.EngineerService;
import com.ese.vo.hr.Break;
import com.ese.vo.hr.Employee;

@Controller
public class CenterMasterAjaxController {
	
	@Autowired
	private EngineerService engineerService;
	
	@RequestMapping("/engineer/empdetail.do")
	@ResponseBody
	public Employee getEmpDetail (String empemail, HttpSession session) {
		return engineerService.getEmployeeDetailById(empemail);
	}
	
	@RequestMapping("/engineer/acceptbreak.do")
	@ResponseBody
	public Break acceptBreak (int breakNo) {
		Break break1 = engineerService.getEngiBreakDetail(breakNo);
		engineerService.acceptCenterAccept(breakNo);
		return break1;
	}
	
	@RequestMapping("/engineer/rejectbreak.do")
	@ResponseBody
	public Break rejectBreak(int breakNo) {
		Break break1 = engineerService.getEngiBreakDetail(breakNo);
		engineerService.noCenterAccept(breakNo);
		break1.setCompleted("D");
		engineerService.modifyBreak(break1);
		
		return break1;
	}
	
	
	@RequestMapping("/engineer/vacation.do")
	@ResponseBody
	public List<Break> vacationPage (String centerId, HttpSession session) {
		System.out.println(centerId);
		List<Break> breaks = engineerService.toEmpStandByPlan(centerId);
		System.out.println(breaks);
		return breaks;
	}
	
	
}
