package com.ese.controller.servicecenter;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
@Controller
public class ServiceCenterController {
	
	@RequestMapping(value= {"/index.do", "/", "/home.do"})
	public String index() {
		
		return "servicecenter/home";
	}
}
