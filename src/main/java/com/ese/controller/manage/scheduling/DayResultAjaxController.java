package com.ese.controller.manage.scheduling;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ese.service.manage.result.DayResultService;
import com.ese.vo.common.DayResultCriteria;
import com.ese.vo.pay.BalanceAccount;

@Controller
public class DayResultAjaxController {
	
	@Autowired
	private DayResultService serivce;
	
	@RequestMapping("/manage/weekResult.do")
	@ResponseBody
	public List<BalanceAccount> weekResult (String startdate, String enddate) {
		DayResultCriteria dayResultCriteria = new DayResultCriteria();
		dayResultCriteria.setStartdate(startdate);
		dayResultCriteria.setEnddate(enddate);
		
		System.out.println(dayResultCriteria);
		
		return serivce.ForweekResult(dayResultCriteria);
	}
}
