package com.ese.controller.engineer.mypage;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ese.service.engineer.EngineerService;
import com.ese.vo.hr.Break;
import com.ese.vo.hr.BreakSign;
import com.ese.vo.hr.Employee;

@Controller
public class EngineerPageAjaxController {
	
	@Autowired
	private EngineerService engineerService;
	
	@InitBinder
	public void stringToDateBinding(WebDataBinder binder) {
		SimpleDateFormat dataFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dataFormat, true));
	}
	
	@RequestMapping("/engineer/all-plan.do")
	@ResponseBody
	public List<Break> getAllBreak (Date start, Date end, HttpSession session) {
		Employee engineer = (Employee) session.getAttribute("loginEngineer");
		if(engineer == null) {
			throw new RuntimeException("로그인이 필요합니다");
		}
		Break break1 = new Break();
		break1.setStartdate(start);
		break1.setEnddate(end);
		break1.setEmployee(engineer);
		
		List<Break> breaks = engineerService.getAllEngineerBreak(break1);	
		
		return breaks;
	}
	
	@RequestMapping("/engineer/other-plan.do")
	@ResponseBody
	public List<Break> getOtherEvent(int breakNo, Date start, Date end) {
		
		Break break1 = new Break();
		Employee employee = new Employee();
		
		employee.setNo(breakNo);
		break1.setEmployee(employee);
		break1.setStartdate(start);
		break1.setEnddate(end);
		
		List<Break> breaks = engineerService.getBreakForEmpDetail(break1);
		
		return breaks;
	}
	
	@RequestMapping("/engineer/detail-plan.do")
	@ResponseBody
	public Break getBreakForEngineer (int breakNo, HttpSession session) {
		Break break1 = engineerService.getEngiBreakDetail(breakNo); 
		if(break1.getCompleted().equals("D")) {
			List<BreakSign> breakSign = engineerService.getOneBreakSign(breakNo);
			BreakSign exitReason = new BreakSign();
			for(BreakSign exit : breakSign) {
				if(exit.getReason() != null) {
					if(exit.getRank() == 2) {
						String reason = exit.getReason() + " - 인사부장";
						exitReason.setReason(reason);
					} else if (exit.getRank() == 1) {
						String reason = exit.getReason() + " - 센터장";
						exitReason.setReason(reason);
					}
				}
			}
			break1.setReason(exitReason.getReason());
		}
		return break1;
	}
}
