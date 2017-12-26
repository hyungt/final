package com.ese.service.servicecenter;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.servicecenter.ServicecenterMapper;
import com.ese.vo.User;
import com.ese.vo.afterservice.AfterService;
import com.ese.vo.afterservice.ServiceResult;
import com.ese.vo.afterservice.UsingPart;
import com.ese.vo.common.UseServiceCriteria;
import com.ese.vo.common.UserOrderCriteria;
import com.ese.vo.order.Order;
@Service
public class ServicecenterServiceImpl implements ServicecenterService {
	
	@Autowired
	ServicecenterMapper serviceMapper;
	
	@Override
	public void addNewUser(User user) {
		int no = serviceMapper.getUserSeq();
		user.setNo(no);
		
		serviceMapper.addUser(user);
	}
	
	@Override
	public User getUserDetail(String id) {
		return serviceMapper.getUserById(id);
	}

	@Override
	public void updateInfo(User user) {
		serviceMapper.updateInfo(user);
	}

	@Override
	public User getUserById(String id) {
		return serviceMapper.getUserById(id);
	}
	
	@Override
	public List<Order> getOrderForUserNo(UserOrderCriteria orderCriteria) {
		return serviceMapper.getOrderByUserNo(orderCriteria);
	}
	
	@Override
	public int getTotalRowsVitae(UseServiceCriteria criteria) {
		return serviceMapper.getTotalRowsServiceVitae(criteria);
	}
	
	@Override
	public List<ServiceResult> getServiceVitaeForUserNo(UseServiceCriteria criteria) {
		return serviceMapper.getServiceVitaeByServiceNo(criteria);
	}
	
	@Override
	public List<UsingPart> usingPartForServiceNo(int serviceNo) {
		return serviceMapper.usingPart(serviceNo);
	}
}
