package com.ese.controller.manage.scheduling;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ese.service.manage.pay.PayChangeService;

@Controller
public class DayResultController {
	
	@Autowired
	private PayChangeService changeService;
	
	@RequestMapping("/manage/dayResult.do")
	public String DayResultMain () {
		
		return "/manage/dayresult/dayresult";
	}
}
