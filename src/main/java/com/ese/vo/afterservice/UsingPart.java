package com.ese.vo.afterservice;

import com.ese.vo.part.Part;

public class UsingPart {
	private ServiceResult serviceResult;
	private Part part;
	
	public ServiceResult getServiceResult() {
		return serviceResult;
	}
	public void setServiceResult(ServiceResult serviceResult) {
		this.serviceResult = serviceResult;
	}
	public Part getPart() {
		return part;
	}
	public void setPart(Part part) {
		this.part = part;
	}
	@Override
	public String toString() {
		return "UsingPart [serviceResult=" + serviceResult + ", part=" + part + "]";
	}
	
}
