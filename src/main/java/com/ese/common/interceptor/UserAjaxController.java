package com.ese.common.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ese.service.servicecenter.ServicecenterService;
import com.ese.vo.CheckResult;
import com.ese.vo.User;

@Controller
public class UserAjaxController {
	
	@Autowired
	ServicecenterService service;
	
	@RequestMapping("/servicecenter/user/idcheck.do")
	public @ResponseBody CheckResult idCheck(@RequestParam("id") String userid) {
		CheckResult result = new CheckResult();
		
		System.out.println(result);
		
		User user = service.getUserDetail(userid);
		result.setUserid(userid);
		System.out.println(user);
		if(user !=null) {
			result.setUsed(true);
		}
		return result;
	}
}
