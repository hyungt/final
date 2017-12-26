package com.ese.common.interceptor;

import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ese.vo.User;
import com.ese.vo.hr.Employee;

public class EngineerLoginCheckInterceptor extends HandlerInterceptorAdapter {
	
	private Set<String> urlSet;
	public void setUrlSet(Set<String> urlSet) {
		this.urlSet = urlSet;
	}
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler)
			throws Exception {
		String requestURI = req.getRequestURI();
		
		if(urlSet.contains(requestURI)) {
			return true;
		}
		
		HttpSession session = req.getSession(false);
		
		if(session == null) {
			res.sendRedirect("/engineer/main.do?error=deny");
			return false;
		}
		
		Employee employee = (Employee) session.getAttribute("loginEngineer");
		if(employee == null) {
			res.sendRedirect("/engineer/main.do?error=deny");
			return false;
		} else {
			return true;
		}
	}
}
