package com.ese.service.manage;

import java.util.List;

import com.ese.vo.hr.BreakSign;

public interface BreakApplyService {

	List<BreakSign> getAllBreak();
	List<BreakSign> getBreakByDept(String deptId);
	void applyCompleted(int employeeNo);
	void applyNotCompleted(BreakSign breakSign);
	void notBreak(int breakNo);
	List<BreakSign> applyKeyword(String keyword);
	BreakSign applyDetail(int breakNo);
	void applyComScBreak(int employeeNo);
}
