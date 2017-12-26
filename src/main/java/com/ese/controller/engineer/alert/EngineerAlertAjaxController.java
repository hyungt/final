package com.ese.controller.engineer.alert;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ese.service.notice.EmployeeNoticeService;
import com.ese.vo.notice.EmployeeNotice;

@Controller
public class EngineerAlertAjaxController {
	
	@Autowired
	EmployeeNoticeService employeeNoticeService;
	
	@RequestMapping("/alert/getalert.do")
	@ResponseBody
	public EmployeeNotice getNotice (int noticeNo) {
		System.out.println("hey");
		
		EmployeeNotice notice = employeeNoticeService.getBoardByNo(noticeNo);
		System.out.println(notice);
		
		return notice;
	}
}
