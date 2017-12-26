package com.ese.mappers.servicecenter.order;

import java.util.List;

import com.ese.vo.User;
import com.ese.vo.common.OrderCriteria;
import com.ese.vo.order.Order;

public interface OrderMapper {
	void addOrder(Order order);
	List<Order> getAllOrders();
	List<Order> getPagingOrders(OrderCriteria criteria);
	Order getOrderByNo(int orderNo);
	void updateOrder(Order order);
	Order getOrderByUser(User user);
	int getOrderSeq();
	int getTotalRowsByOrderStatusId(String orderStatusId);
	int getTotalRows();
}
