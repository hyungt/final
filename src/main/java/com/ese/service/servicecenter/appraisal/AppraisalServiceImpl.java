package com.ese.service.servicecenter.appraisal;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.servicecenter.appraisal.AppraisalMapper;
import com.ese.vo.order.Apparaisal;

@Service
public class AppraisalServiceImpl implements AppraisalService{

	@Autowired
	AppraisalMapper appraisalMapper;
	
	@Override
	public void addAppraisal(Apparaisal apparaisal) {
		appraisalMapper.addAppraisal(apparaisal);
	}
	
	@Override
	public List<Apparaisal> getAppraisals(int partNo) {
		return appraisalMapper.getAppraisals(partNo);
	}
	
	@Override
	public List<Apparaisal> getAppraisalsByUserNo(int userNo) {
		return appraisalMapper.getAppraisalsByUserNo(userNo);
	}
	
	@Override
	public int getRowsByUserNo(int userNo) {
		return appraisalMapper.getRowsByUserNo(userNo);
	}
}
