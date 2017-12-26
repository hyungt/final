package com.ese.service.engineer.serviceresult;

import java.util.List;

import com.ese.vo.Division;
import com.ese.vo.afterservice.RepairInfo;
import com.ese.vo.common.ServiceCriteria;
import com.ese.vo.part.Part;

public interface ServiceResultService {

	String serviceComplete(Integer serviceNo, String repairId, Long totalPrice, List<Integer> usingParts);
	List<RepairInfo> getAllRepairInfo();
	List<Part> getPartsByDivision(Division division);
	List<Part> getPartsByCriteria(ServiceCriteria criteria);
}
