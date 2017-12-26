package com.ese.mappers.engineer.service;

import com.ese.vo.afterservice.ServiceResult;

public interface ServiceResultMapper {
	ServiceResult getServiceResultByServiceNo(Integer no);
	void addServiceResult(ServiceResult result);
	int getSeqResult();
}
