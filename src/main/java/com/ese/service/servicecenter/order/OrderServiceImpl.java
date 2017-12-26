package com.ese.service.servicecenter.order;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.manage.part.InventoryChangeMapper;
import com.ese.mappers.manage.part.PartMapper;
import com.ese.mappers.manage.pay.PayChangeMapper;
import com.ese.mappers.servicecenter.order.OrderMapper;
import com.ese.vo.common.OrderCriteria;
import com.ese.vo.order.Order;
import com.ese.vo.part.InventoryChange;
import com.ese.vo.part.Part;
import com.ese.vo.pay.PayChange;
import com.ese.vo.pay.PayChangeType;

@Service
public class OrderServiceImpl implements OrderService{

	@Autowired
	OrderMapper orderMapper;
	
	@Autowired
	PartMapper partmapper;
	
	@Autowired
	PayChangeMapper payChangeMapper;
	
	@Autowired
	InventoryChangeMapper inventoryChangeMapper;
	
	@Override
	public void addOrder(Order order) {
		Part part = partmapper.getPartByNo(order.getPart().getNo());
		InventoryChange inventoryChange = new InventoryChange();
		int changedQty = part.getQty()-order.getCount();
		
		part.setQty(changedQty);
		
		partmapper.updatePart(part);
		
		int changeQty = -order.getCount();
		
		inventoryChange.setPart(part);
		inventoryChange.setQty(changeQty);
		inventoryChangeMapper.changeInventory(inventoryChange);
		
		orderMapper.addOrder(order);
	}
	
	@Override
	public void completeDelivery(Order order) {
		Part part = partmapper.getPartByNo(order.getPart().getNo());
		PayChange payChange = new PayChange(); 
		PayChangeType payChangeType = new PayChangeType();
		
		
		partmapper.updatePart(part);
		
		int totalPrice = (order.getCount() * order.getPurchase());
		
		String changeTypeId = "PC-INVEN-SAL";
		String payType = "수입";
		
		payChangeType.setId(changeTypeId);
		
		payChange.setMoney((long) totalPrice);
		payChange.setChangeType(payChangeType);;
		payChange.setType(payType);
		
		payChangeMapper.addPayChange(payChange);
	}
	
	@Override
	public List<Order> getAllOrders() {
		return orderMapper.getAllOrders();
	}
	
	@Override
	public void updateOrder(Order order) {
		orderMapper.updateOrder(order);
	}
	
	@Override
	public Order getOrderByNo(int orderNo) {
		return orderMapper.getOrderByNo(orderNo);
	}
	
	@Override
	public int getOrderSeq() {
		return orderMapper.getOrderSeq();
	}
	
	@Override
	public List<Order> getPagingOrders(OrderCriteria criteria) {
		return orderMapper.getPagingOrders(criteria);
	}
	
	@Override
	public int getTotalRows() {
		return orderMapper.getTotalRows();
	}
	
	@Override
	public int getTotalRowsByOrderStatusId(String orderStatusId) {
		return orderMapper.getTotalRowsByOrderStatusId(orderStatusId);
	}
}
