package com.ese.service.engineer.reserve;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.servicecenter.ServiceReserveMapper;
import com.ese.vo.afterservice.AfterService;
import com.ese.vo.common.ServiceCriteria;

@Service
public class ReserveServiceImpl implements ReserveService {

	@Autowired
	ServiceReserveMapper serviceReserveMapper;
	
	@Override
	public List<AfterService> getMyService(ServiceCriteria criteria) {
		
		criteria.setTotalRows(serviceReserveMapper.getTotalServiceRows());
		
		return serviceReserveMapper.getServiceByEngineerId(criteria);
	}

	@Override
	public AfterService getDetailService(Integer reserveNo) {
		return serviceReserveMapper.getServiceByNo(reserveNo);
	}
	
}
