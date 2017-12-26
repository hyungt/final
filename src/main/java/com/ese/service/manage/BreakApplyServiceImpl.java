package com.ese.service.manage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.manage.BreakApplyMapper;
import com.ese.vo.hr.BreakSign;

@Service
public class BreakApplyServiceImpl implements BreakApplyService {


	@Autowired
	BreakApplyMapper breakApplyMapper;
	
	
	@Override
	public List<BreakSign> getAllBreak() {
		return breakApplyMapper.getAllBreak();
	}
	
	@Override
	public List<BreakSign> getBreakByDept(String deptId) {
		return breakApplyMapper.getBreakByDept(deptId);
	}
	
	@Override
	public void applyCompleted(int employeeNo) {
		breakApplyMapper.applyCompleted(employeeNo);
	}
	
	@Override
	public void applyNotCompleted(BreakSign breakSign) {
		breakApplyMapper.applyNotCompleted(breakSign);
	}
	
	@Override
	public void notBreak(int breakNo) {
		breakApplyMapper.notBreak(breakNo);
	}
	
	@Override
	public List<BreakSign> applyKeyword(String keyword) {
		return breakApplyMapper.applyKeyword(keyword);
	}
	
	@Override
	public BreakSign applyDetail(int breakNo) {
		return breakApplyMapper.applyDetail(breakNo);
	}
	
	@Override
	public void applyComScBreak(int employeeNo) {
		breakApplyMapper.applyComScBreak(employeeNo);
	}
}
