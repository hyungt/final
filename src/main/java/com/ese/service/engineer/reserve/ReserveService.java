package com.ese.service.engineer.reserve;

import java.util.List;

import com.ese.vo.afterservice.AfterService;
import com.ese.vo.common.ServiceCriteria;

public interface ReserveService {

	List<AfterService> getMyService(ServiceCriteria criteria);
	AfterService getDetailService(Integer reserveNo);
}
