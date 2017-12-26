package com.ese.controller.manage;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ese.service.manage.BreakApplyService;
import com.ese.service.manage.EmployeeService;
import com.ese.service.notice.EmployeeNoticeService;
import com.ese.vo.hr.Break;
import com.ese.vo.hr.BreakSign;
import com.ese.vo.hr.Employee;
import com.ese.vo.notice.EmployeeNotice;

@Controller
public class EmployeeAjaxController {

	@Autowired
	EmployeeService employeeService;
	
	@Autowired
	BreakApplyService breakApplyService;
	
	@Autowired
	EmployeeNoticeService employeeNoticeService;
	
	@RequestMapping("/manage/personnel/getByDetpId.do")
	@ResponseBody
	public List<Employee> getByDetpId(String deptId) {
		List<Employee> emps = employeeService.getByDetpId(deptId);
		return emps;
	}
	
	@RequestMapping("/manage/personnel/getByKeyword.do")
	@ResponseBody
	public List<Employee> getByKeyword(String keyword){
		List<Employee> empNs = employeeService.getByKeyword(keyword);
		return empNs;
	}
	
	@RequestMapping("/manage/personnel/HolidayPerList.do")
	@ResponseBody
	public List<Employee> getByDeptHoilday(String deptId){
		List<Employee> holiPer = employeeService.getByDeptHoilday(deptId);
		return holiPer;
	}
	
	@RequestMapping("/manage/personnel/findKeyword.do")
	@ResponseBody
	public List<Employee> findKeyword(String keyword){
		List<Employee> empName = employeeService.findKeyword(keyword);
		return empName;
	}
	
	@RequestMapping("/manage/personnel/applyList.do")
	@ResponseBody
	public List<BreakSign> holidayApplyListByDeptId(String deptId) {
		List<BreakSign> bSign = breakApplyService.getBreakByDept(deptId);
		return bSign;
	}
	
	@RequestMapping("/manage/personnel/completed.do")
	@ResponseBody
	public String applyCompleted(int employeeNo) {
		breakApplyService.applyCompleted(employeeNo);
		breakApplyService.applyComScBreak(employeeNo);
		String text = "success";
		return text;
	}
	
	@RequestMapping("/manage/personnel/cencle.do")
	@ResponseBody
	public String applyNotCompleted(int breakNo, String reason) {
		breakApplyService.notBreak(breakNo);
		Break breaks = new Break();
		breaks.setNo(breakNo);
		BreakSign breakSign = new BreakSign();
		breakSign.setReason(reason);
		breakSign.setBreaks(breaks);
		breakApplyService.applyNotCompleted(breakSign);
		String text = "success";
		return text;
	}
	
	@RequestMapping("/manage/personnel/applyKeyword.do")
	@ResponseBody
	public List<BreakSign> applyKeyword(String keyword){
		List<BreakSign> keywordList = breakApplyService.applyKeyword(keyword);
		return keywordList;
	}
	
	@RequestMapping("/manage/personnel/applyDetail.do")
	@ResponseBody
	public BreakSign applyDetail(int breakNo) throws ParseException {
		BreakSign breakS = breakApplyService.applyDetail(breakNo);
		return breakS;
	}
	
	@RequestMapping("manage/personnel/viewNoti.do")
	@ResponseBody
	public EmployeeNotice viewNoti(int notiNo) {
		EmployeeNotice noti = employeeNoticeService.getBoardByNo(notiNo);
		return noti;
	}
}
