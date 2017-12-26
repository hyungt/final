package com.ese.mappers.servicecenter;

import java.util.List;

import com.ese.vo.afterservice.AfterService;
import com.ese.vo.common.ServiceCriteria;
import com.ese.vo.common.UseServiceCriteria;

public interface ServiceReserveMapper {

	List<AfterService> getServiceByEngineerId(ServiceCriteria criteria);
	void addAfterService(AfterService as);
	int getTotalServiceRows();
	AfterService getServiceByNo(Integer reserveNo);
	void updateAfterServiceComplete(AfterService as);
	Integer getAfterServiceSeq();
	
	List<AfterService> getServiceByUserNo(UseServiceCriteria criteria);
	int getTotalRowsServiceUser(UseServiceCriteria criteria);
}
