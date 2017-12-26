package com.ese.controller.manage.finance;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.time.temporal.Temporal;
import java.time.temporal.TemporalAdjuster;
import java.time.temporal.TemporalAdjusters;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ese.service.manage.EmployeeService;
import com.ese.service.manage.pay.PayChangeService;
import com.ese.service.notice.EmployeeNoticeService;
import com.ese.vo.common.PayChangeChartResult;
import com.ese.vo.common.PayChangeCriteria;
import com.ese.vo.hr.Department;
import com.ese.vo.hr.Employee;
import com.ese.vo.pagination.notice.Pagination;
import com.ese.vo.pay.MonthlyPay;
import com.ese.vo.pay.OtherPay;
import com.ese.vo.pay.PayChange;
import com.ese.vo.pay.PayChangeType;

@Controller
@RequestMapping("/manage/finance")
public class FinanceController {
	
	@Autowired
	PayChangeService changeService;
	@Autowired
	EmployeeService empService;
	@Autowired
	EmployeeNoticeService employeeNoticeService;

	@RequestMapping("/main.do")
	public String financePage(Model model, Pagination pagination) {
		pagination.setRows(10);
		int totalRows  = employeeNoticeService.getTotalRows(pagination);
		pagination.setTotalRows(totalRows);
		model.addAttribute("navi", pagination);
		model.addAttribute("notis", employeeNoticeService.getAllBoards(pagination));
		
		return "manage/finance/main";
	}
	
	@RequestMapping("/payAnalysis.do")
	public String payChange(Model model) {
		model.addAttribute("CTList", changeService.getAllPayChangeType());
		
		return "manage/finance/payChange";
	}
	
	@RequestMapping("/payChange/getAnalysis.do")
	@ResponseBody
	public List<PayChange> getChange(String startDate, String endDate, String type, String changeType) {
		
		PayChangeCriteria criteria = new PayChangeCriteria();
		
		criteria.setStartDate(startDate);
		criteria.setEndDate(endDate);
		criteria.setType(type);
		criteria.setChangeType(changeType);
		
		System.out.println(startDate + " " + endDate + " " + type + " " + changeType);
		
		return changeService.getChangeByCriteria(criteria);
	}
	
	@RequestMapping("/inputPay.do")
	public String inputPage() {
		return "manage/finance/inputOtherPay";
	}
	
	@RequestMapping("/salary/getAllSalary.do")
	@ResponseBody
	public Map<String, Object> getAllSalary(String month) {
		Map<String, Object> type = new HashMap<String, Object>();
		List<MonthlyPay> monthlyPayList = changeService.getMonthlyPayByMonth(month);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		Date now = new Date();
		
		type.put("payments", "N");
		if(monthlyPayList.isEmpty()) {
			if(sdf.format(now).equals(month)) {
				type.put("payments", "Y");
				type.put("monthlyEmpList", empService.getAllEmp());
			}
		} else {
			type.put("monthlyList", monthlyPayList);
		}
		
		return type;
	}
	
	@RequestMapping("/salary/paymentsSalary.do")
	@ResponseBody
	public String payments() {
		
		List<Employee> empList = empService.getAllEmp();
		long totalPay = 0;
		for(Employee emp : empList) {
			MonthlyPay pay = new MonthlyPay();
			pay.setEmployee(emp);
			long payments = emp.getSalary()/12;
			pay.setPay(payments);
			totalPay += payments;
			changeService.addMonthlyPay(pay);
		}
		PayChange change = new PayChange();
		change.setMoney(totalPay);
		change.setType("지출");
		PayChangeType changeType = new PayChangeType();
		changeType.setId("PC-MONTH-PAY");
		change.setChangeType(changeType);
		changeService.addPayChange(change);
		
		return "ok";
	}
	
	@RequestMapping("/other/addOtherPay.do")
	@ResponseBody
	public String otherPayAdd(String deptArr, String moneyArr, String reasonArr) {
		
		String[] depts = deptArr.split(",");
		String[] moneys = moneyArr.split(",");
		String[] reasons = reasonArr.split(",");
		
		int size = depts.length;
		
		for(int i = 0; i < size; ++i) {
			OtherPay other = new OtherPay();
			Department dept = new Department();
			
			System.out.println(depts[i]);
			System.out.println(moneys[i]);
			System.out.println(reasons[i]);
			
			dept.setId(depts[i]);
			
			other.setDepartment(dept);
			other.setCost(Long.parseLong(moneys[i]));
			other.setReason(reasons[i]);
			
			changeService.addOtherPay(other);
			
			PayChange change = new PayChange();
			change.setMoney(Long.parseLong(moneys[i]));
			change.setType("지출");
			change.setReason(reasons[i]);
			PayChangeType changeType = new PayChangeType();
			changeType.setId("PC-OTHER-PAY");
			change.setChangeType(changeType);
			changeService.addPayChange(change);
		}
		
		return "ok";
	}
	
	@RequestMapping("/analysis/getData.do")
	@ResponseBody
	public Map<String, Object> getChart(String chartType, String date) {
		System.out.println(chartType);
		System.out.println(date);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("type", chartType);
		System.out.println();
		LocalDate endDate = null;
		Map<String, Object> criteria = new HashMap<String, Object>();
		
		criteria.put("type", chartType);
		
		String startDateString = null;
		String endDateString = null;
		
		if("week".equals(chartType)) {
			String[] startendDate = date.split("~");
			String[] startday = startendDate[0].split("-");
			String[] endday = startendDate[1].split("-");
			endDateString = endday[0] + "-" + endday[1] + "-" + endday[2];
			startDateString = startday[0] + "-" + startday[1] + "-" + startday[2];
			
			endDate = LocalDate.of(Integer.parseInt(startday[0]), Integer.parseInt(startday[1]), Integer.parseInt(startday[2]));
			LocalDate startDate = LocalDate.of(Integer.parseInt(endday[0]), Integer.parseInt(endday[1]), Integer.parseInt(endday[2]));
			Period period = endDate.until(startDate);
			
			System.out.println(startDateString);
			System.out.println(endDateString);
			
			criteria.put("startDate", startDateString);
			criteria.put("endDate", endDateString);
			criteria.put("dayGap", period.getDays()+1);
		} else if("month".equals(chartType)) {
			String[] ym = date.split("-");
			LocalDate startDate = LocalDate.of(Integer.parseInt(ym[0]), Integer.parseInt(ym[1]), 1);
			endDate = startDate.with(TemporalAdjusters.lastDayOfMonth());
			
			endDateString = endDate.getYear() + "-" + 
					(endDate.getMonthValue() < 10 ? "0"+endDate.getMonthValue() : endDate.getMonthValue() ) + "-" + 
					(endDate.getDayOfMonth()<10 ? "0" + endDate.getDayOfMonth() : endDate.getDayOfMonth());
			startDateString = startDate.getYear() + "-" + 
					(startDate.getMonthValue() < 10 ? "0"+startDate.getMonthValue() : startDate.getMonthValue() ) + "-" + 
					(startDate.getDayOfMonth()<10 ? "0" + startDate.getDayOfMonth() : startDate.getDayOfMonth());
			
			System.out.println(startDateString);
			System.out.println(endDateString);
			
			criteria.put("startDate", startDateString);
			criteria.put("endDate", endDateString);
			criteria.put("dayGap", endDate.getDayOfMonth());
		} else if("year".equals(chartType)) {
			startDateString = date + "-01-01";
			endDateString = date + "-12-31";
			System.out.println(startDateString + "~" + endDateString);
			
			criteria.put("startMonth", date+"-01");
			criteria.put("startDate", startDateString);
			criteria.put("endDate", endDateString);
			criteria.put("dayGap", 12);
		}
		
		
		List<PayChangeChartResult> data = changeService.getDayChart(criteria);
		List<PayChangeChartResult> typeData = changeService.getTypeChartData(criteria);
		
		result.put("data", data);
		result.put("typeData", typeData);
		result.put("startDate", startDateString);
		result.put("endDate", endDateString);
		
		return result;
	}
}
