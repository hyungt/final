package com.ese.service.servicecenter;

import java.util.List;

import com.ese.vo.User;
import com.ese.vo.afterservice.ServiceResult;
import com.ese.vo.afterservice.UsingPart;
import com.ese.vo.common.UseServiceCriteria;
import com.ese.vo.common.UserOrderCriteria;
import com.ese.vo.order.Order;

public interface ServicecenterService {
	
	void addNewUser(User user);
	
	User getUserDetail(String id);
	
	User getUserById(String id);
	void updateInfo(User user);
	
	List<Order> getOrderForUserNo(UserOrderCriteria orderCriteria);
	List<ServiceResult> getServiceVitaeForUserNo(UseServiceCriteria criteria);
	int getTotalRowsVitae(UseServiceCriteria criteria);
	List<UsingPart> usingPartForServiceNo(int serviceNo);
}
