package com.ese.service.engineer.serviceresult;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.engineer.service.RepairInfoMapper;
import com.ese.mappers.engineer.service.ServiceResultMapper;
import com.ese.mappers.engineer.service.UsingPartMapper;
import com.ese.mappers.manage.part.InventoryChangeMapper;
import com.ese.mappers.manage.part.PartMapper;
import com.ese.mappers.manage.pay.PayChangeMapper;
import com.ese.mappers.servicecenter.ServiceReserveMapper;
import com.ese.vo.Division;
import com.ese.vo.afterservice.AfterService;
import com.ese.vo.afterservice.RepairInfo;
import com.ese.vo.afterservice.ServiceResult;
import com.ese.vo.afterservice.ServiceStatus;
import com.ese.vo.afterservice.UsingPart;
import com.ese.vo.common.ServiceCriteria;
import com.ese.vo.part.InventoryChange;
import com.ese.vo.part.Part;
import com.ese.vo.pay.PayChange;
import com.ese.vo.pay.PayChangeType;

@Service
public class ServiceResultServiceImpl implements ServiceResultService {

	@Autowired
	RepairInfoMapper repairMapper;
	@Autowired
	ServiceResultMapper resultMapper;
	@Autowired
	ServiceReserveMapper reserveMapper;
	@Autowired
	UsingPartMapper usingPartMapper;
	@Autowired
	PartMapper partMapper;
	@Autowired
	PayChangeMapper payChangeMapper;
	@Autowired
	InventoryChangeMapper inventoryChangeMapper;
	

	@Override
	public String serviceComplete(Integer serviceNo, String repairId, Long totalPrice, List<Integer> usingParts) {
		
		int no = resultMapper.getSeqResult();
		
		ServiceResult result = new ServiceResult();
		result.setNo(no);
		
		AfterService as = reserveMapper.getServiceByNo(serviceNo);
		result.setService(as);
		
		RepairInfo repair = repairMapper.getRepairInfoById(repairId);
		result.setRepairInfo(repair);
		resultMapper.addServiceResult(result);
		PayChange pay = new PayChange();
		PayChangeType pcType = new PayChangeType();
		pcType.setId("PC-REPAIR-PRICE");
		pay.setChangeType(pcType);
		pay.setType("수입");
		pay.setMoney(repair.getPrice().longValue());
		
		payChangeMapper.addPayChange(pay);
		
		for(Integer partNo : usingParts) {
			UsingPart usingPart = new UsingPart();
			usingPart.setServiceResult(result);
			Part part = partMapper.getPartByNo(partNo);
			usingPart.setPart(part);
			
			usingPartMapper.addUsingParts(usingPart);
			part.setQty(part.getQty() - 1);
			partMapper.updatePart(part);
			
			
			pcType.setId("PC-INVEN-REPAIR");
			pay.setChangeType(pcType);
			pay.setType("수입");
			pay.setMoney(part.getPrice());
			
			payChangeMapper.addPayChange(pay);
			
			InventoryChange change = new InventoryChange();
			change.setQty(-1);
			change.setPart(part);
			inventoryChangeMapper.changeInventory(change);
		}
		as.getServiceStatus().setId("STA_COMPLETE");
		reserveMapper.updateAfterServiceComplete(as);
		
		return "ok";
	}
	
	@Override
	public List<RepairInfo> getAllRepairInfo() {
		return repairMapper.getAllRepairInfo();
	}

	@Override
	public List<Part> getPartsByDivision(Division division) {
		return partMapper.getParts(division);
	}

	@Override
	public List<Part> getPartsByCriteria(ServiceCriteria criteria) {
		criteria.setTotalRows(partMapper.getTotalRowsByDivisionId(criteria.getDivisionId()));
		
		return partMapper.getPartsByCriteria(criteria);
	}

	
}
