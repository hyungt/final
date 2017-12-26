package com.ese.mappers.servicecenter;

import java.util.List;

import com.ese.vo.User;
import com.ese.vo.afterservice.AfterService;
import com.ese.vo.afterservice.ServiceResult;
import com.ese.vo.afterservice.UsingPart;
import com.ese.vo.common.UseServiceCriteria;
import com.ese.vo.common.UserOrderCriteria;
import com.ese.vo.order.Order;

public interface ServicecenterMapper {
	
	int getUserSeq();
	
	void addUser(User user);
	
	User getUserById(String id);
	
	User getUserByNo(Integer no);
	
	void updateInfo(User user);
	
	List<Order> getOrderByUserNo(UserOrderCriteria orderCriteria);
	List<ServiceResult> getServiceVitaeByServiceNo(UseServiceCriteria criteria);
	int getTotalRowsServiceVitae(UseServiceCriteria criteria);
	List<UsingPart> usingPart(int serviceNo);
}
