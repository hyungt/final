package com.ese.rest.web.servicecenter.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ese.service.servicecenter.order.OrderService;
import com.ese.vo.common.OrderCriteria;
import com.ese.vo.order.Order;
import com.ese.vo.order.OrderStatus;

@RestController
public class OrderRestController {

	@Autowired
	OrderService orderService;
	
	@GetMapping("/order/changeDelistatus")
	public Map<String, Object> changeDelistatus(OrderCriteria orderCriteria){
		
		Order order = orderService.getOrderByNo(orderCriteria.getOrderNo());
		OrderStatus statusId = new OrderStatus();
		statusId.setId(orderCriteria.getOrderStatusId());
		order.setStatusId(statusId);
		
		orderService.updateOrder(order);
		
		int totalRows = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(orderCriteria.getChoice() == 0) {
			totalRows = orderService.getTotalRows();
		}else if(orderCriteria.getChoice() == 1){
			totalRows = orderService.getTotalRowsByOrderStatusId(orderCriteria.getOrderStatusId());
		}
		orderCriteria.setTotalRows(totalRows);
		List<Order> orders = orderService.getPagingOrders(orderCriteria);
		System.out.println(statusId.getId());
		if(statusId.getId().equals("ORDER-COMPLETE")) {
			orderService.completeDelivery(order);
		}
		
		map.put("navi", orderCriteria);
		map.put("orders", orders);
		
		return map;
	}
	
	@GetMapping("/order/loadpage")
	public Map<String, Object> loadpage(OrderCriteria orderCriteria){
		
		int totalRows = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(orderCriteria.getChoice() == 0) {
			totalRows = orderService.getTotalRows();
		}else if(orderCriteria.getChoice() == 1){
			totalRows = orderService.getTotalRowsByOrderStatusId(orderCriteria.getOrderStatusId());
		}
		orderCriteria.setTotalRows(totalRows);
		List<Order> orders = orderService.getPagingOrders(orderCriteria);
		
		map.put("navi", orderCriteria);
		map.put("orders", orders);
		
		return map;
	}
}
