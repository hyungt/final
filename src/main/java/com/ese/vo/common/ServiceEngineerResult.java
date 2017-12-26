package com.ese.vo.common;

import java.util.List;

import com.ese.vo.afterservice.AfterService;

public class ServiceEngineerResult {

	private List<AfterService> serviceList;
	private ServiceCriteria criteria;
	
	public List<AfterService> getServiceList() {
		return serviceList;
	}
	public void setServiceList(List<AfterService> serviceList) {
		this.serviceList = serviceList;
	}
	public ServiceCriteria getCriteria() {
		return criteria;
	}
	public void setCriteria(ServiceCriteria criteria) {
		this.criteria = criteria;
	}
	
}
