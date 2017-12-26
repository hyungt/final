package com.ese.controller.servicecenter.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ese.service.servicecenter.ServicecenterService;
import com.ese.service.servicecenter.appraisal.AppraisalService;
import com.ese.vo.User;
import com.ese.vo.afterservice.AfterService;
import com.ese.vo.common.UseServiceCriteria;
import com.ese.vo.common.UserOrderCriteria;
import com.ese.vo.order.Apparaisal;
import com.ese.vo.order.Order;
import com.ese.vo.part.Part;

@Controller
public class SCUserajaxController {
	
	@Autowired
	ServicecenterService centerService;
	
	@Autowired
	AppraisalService appraisalService;
	
	@RequestMapping("/user/ordercheck.do")
	@ResponseBody
	public Map<String, Object> ordercheck (int userNo) {
		Map<String, Object> map = new HashedMap<String, Object>();
		UserOrderCriteria orderCriteria = new UserOrderCriteria();
		orderCriteria.setUserNo(userNo);
		
		
		List<Order> orders = centerService.getOrderForUserNo(orderCriteria);
		List<Apparaisal> apparaisals = appraisalService.getAppraisalsByUserNo(userNo);
		
		
		map.put("orders", orders);
		map.put("apparaisals", apparaisals);
		map.put("apprRows", apparaisals.size());
		
		return map;
	}
	
	@RequestMapping("/user/checkclick.do")
	@ResponseBody
	public List<Order> checkclick (int userNo, String startdate, String enddate) {
		UserOrderCriteria orderCriteria = new UserOrderCriteria();
		orderCriteria.setUserNo(userNo);
		orderCriteria.setStartdate(startdate);
		orderCriteria.setEnddate(enddate);
		
		List<Order> order = centerService.getOrderForUserNo(orderCriteria);
		
		return order;
	}
	
	@RequestMapping("/user/addappraisal.do")
	@ResponseBody
	public void addappraisal(int partNo, int orderNo, String contents, HttpSession session) {
		User user =  (User)session.getAttribute("loginUser");
		Part part = new Part();
		Order order = new Order();
		Apparaisal apparaisal = new Apparaisal();
		
		part.setNo(partNo);
		order.setNo(orderNo);
		apparaisal.setUser(user);
		apparaisal.setPart(part);
		apparaisal.setOrder(order);
		apparaisal.setContents(contents);
		
		appraisalService.addAppraisal(apparaisal);
	}
	
	/*@RequestMapping("/user/serviceCheck.do")
	@ResponseBody
	public List<AfterService> serviceCheck (int userNo, HttpSession session) {
		UseServiceCriteria criteria = new UseServiceCriteria();
		
		criteria.setUserNo(userNo);
		int totalrows = centerService.getTotalRowsVitae(criteria);
		System.out.println(totalrows);
		criteria.setTotalRows(totalrows);
		List<AfterService> services = centerService.getServiceVitaeForUserNo(criteria);
		System.out.println(services);
		
		return services;
	}*/
}
