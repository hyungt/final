package com.ese.service.servicecenter.order;

import java.util.List;

import com.ese.vo.common.OrderCriteria;
import com.ese.vo.order.Order;

public interface OrderService {
	void addOrder(Order order);
	List<Order> getAllOrders();
	List<Order> getPagingOrders(OrderCriteria criteria);
	void updateOrder(Order order);
	Order getOrderByNo(int orderNo);
	int getOrderSeq();
	int getTotalRowsByOrderStatusId(String orderStatusId);
	int getTotalRows();
	void completeDelivery(Order order);
}
