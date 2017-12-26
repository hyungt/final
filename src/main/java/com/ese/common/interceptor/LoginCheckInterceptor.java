package com.ese.common.interceptor;

import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ese.vo.User;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	
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
			res.sendRedirect("/user/login.do?error=deny");
			return false;
		}
		
		User user = (User) session.getAttribute("loginUser");
		if(user == null) {
			res.sendRedirect("/user/login.do?error=deny");
			return false;
		} else {
			return true;
		}
	}
}
