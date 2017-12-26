package com.ese.mappers.engineer.service;

import java.util.List;

import com.ese.vo.afterservice.RepairInfo;

public interface RepairInfoMapper {
	List<RepairInfo> getAllRepairInfo();
	RepairInfo  getRepairInfoById(String repairId);
}
