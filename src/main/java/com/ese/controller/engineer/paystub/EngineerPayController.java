package com.ese.controller.engineer.paystub;

import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ese.service.engineer.EngineerService;
import com.ese.service.manage.pay.PayChangeService;
import com.ese.vo.common.PayChangeCriteria;
import com.ese.vo.hr.Employee;
import com.ese.vo.pay.MonthlyPay;

import oracle.sql.DATE;

@Controller
public class EngineerPayController {
	
	@Autowired
	EngineerService engineerService;
	@Autowired
	PayChangeService payService;
	
	@RequestMapping("/engineer/paystub.do")
	public String paystub (Model model, HttpSession session) {
		return "engineer/mypage/paystub";
	}
	
	@RequestMapping(value= {"/engineer/excelExport.do"}, method=RequestMethod.GET)
	public ModelAndView excelExport(Locale locale, @RequestParam(name="exportMon", required=false)String exportMon, HttpSession session) {
		System.out.println(exportMon);
		Employee employee = (Employee) session.getAttribute("loginEngineer");
		ModelAndView mv = new ModelAndView();
		
		if(exportMon != null) {
		PayChangeCriteria changeCriteria = new PayChangeCriteria();
		
		changeCriteria.setEmpNo(employee.getNo());
		changeCriteria.setMonth(exportMon);
		MonthlyPay pay = payService.getMonthlyPayByCriteria(changeCriteria);
		
		System.out.println(pay);
		long salary = pay.getEmployee().getSalary();
		long total = (salary/12) - (salary/12/10);
		
		Map<String, Object> engineer = new HashMap<String, Object>();
		engineer.put("deptName", pay.getEmployee().getDepartment().getName());
		engineer.put("centerName", pay.getEmployee().getCenter().getName());
		engineer.put("name", pay.getEmployee().getName());
		engineer.put("position", pay.getEmployee().getPosition().getName());
		engineer.put("phone", pay.getEmployee().getPhone());
		engineer.put("hiredate", pay.getEmployee().getHiredate());
		engineer.put("salary", salary/12);
		engineer.put("tax", salary/12/10);
		engineer.put("total", total);
		engineer.put("month", exportMon);
		
		mv.addObject("engineer", engineer);
		
		} else {
			long salary = employee.getSalary();
			long total = (salary/12) - (salary/12/10);
			
			Map<String, Object> engineer = new HashMap<String, Object>();
			engineer.put("deptName", employee.getDepartment().getName());
			engineer.put("centerName", employee.getCenter().getName());
			engineer.put("name", employee.getName());
			engineer.put("position", employee.getPosition().getName());
			engineer.put("phone", employee.getPhone());
			engineer.put("hiredate", employee.getHiredate());
			engineer.put("salary", salary/12);
			engineer.put("tax", salary/12/10);
			engineer.put("total", total);
			engineer.put("month", "이번 달");
			
			mv.addObject("engineer", engineer);
		} 
		
		mv.setViewName("/engineer/mypage/excelexport");
		return mv;
	}
	
	@RequestMapping("/engineer/monthlyPay.do")
	@ResponseBody
	public MonthlyPay monthlyPay (String yyyyMM, HttpSession session) {
		PayChangeCriteria changeCriteria = new PayChangeCriteria();
		
		Employee employee = (Employee) session.getAttribute("loginEngineer");
		changeCriteria.setEmpNo(employee.getNo());
		changeCriteria.setMonth(yyyyMM);
		MonthlyPay pay = payService.getMonthlyPayByCriteria(changeCriteria);
		return pay;
	}
}
