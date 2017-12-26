package com.ese.service.engineer;


import java.util.List;
import java.util.Map;

import com.ese.vo.afterservice.AfterService;
import com.ese.vo.hr.Break;
import com.ese.vo.hr.BreakSign;
import com.ese.vo.hr.Employee;
import com.ese.vo.notice.EmployeeNotice;

public interface EngineerService {
	
	Employee getEmployeeDetailById(String email);
	List<EmployeeNotice> getBoardMainLimit();
	
	//달력
	List<Break> getAllEngineerBreak(Break break1);
	List<Break> getBreakForEmpDetail(Break break1);
	Break NewEngBreak(Break break1);
	Break modifyBreak(Break break1);
	List<Employee> getEngineers();
	Break getEngiBreakDetail(int no);
	List<Break> getEngiBreakExit(int no);
	void updateForEngineer(Employee employee);
	
	//휴가 
	int standByCheck(int breakNo);
	List<BreakSign> getOneBreakSign(int no);

	List<Break> getBreakByDate(Map<String, Object> map);
	
	//센터장 
	List<Employee> getEmployeeToCenterId(String centerId);
	List<Employee> getToDetpIdAndCenterId(Employee employee);
	List<Break> toEmpStandByPlan(String centerId);
	void acceptCenterAccept (int breakNo);
	void noCenterAccept (int breakNo);
	List<AfterService> ForReserveList();
}
