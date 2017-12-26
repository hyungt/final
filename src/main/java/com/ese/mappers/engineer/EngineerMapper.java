package com.ese.mappers.engineer;

import java.util.List;
import java.util.Map;

import com.ese.vo.afterservice.AfterService;
import com.ese.vo.hr.Break;
import com.ese.vo.hr.BreakSign;
import com.ese.vo.hr.Employee;
import com.ese.vo.notice.EmployeeNotice;

public interface EngineerMapper {
	
	Employee getEmployeeById(String email);
	List<EmployeeNotice> getBoardMain();
	
	//달력
	int getBreakSeq();
	List<Break> getAllEngiBreak(Break break1);
	List<Break> getEngiBreakByEmpNoDetail(Break break1);
	void addEngiBreak(Break break1);
	void modifyBreakByNo(Break break1);
	List<Employee> getAllEngineers();
	Break getEngiBreakByNoDetail(int no);
	List<Break> getEngiBreakForExit(int no);
	void updateEngineer(Employee employee);
	
	//휴가 신청 결재 대기
	void newBreakSign(BreakSign breakSign);
	int standByCheck(int breakNo);
	List<BreakSign> getBreakSign(int no);
	List<Break> getBreakByDate(Map<String, Object> map);
	
	// 센터장 
	List<Employee> getEmployeeForCenterId(String centerId);
	List<Employee> getForDetpIdAndCenterId(Employee employee);
	List<Break> getEmpStandByPlan(String centerId);
	void updateCenterAccept (int breakNo);
	void rejectCenterAccept (int breakNo);
	List<AfterService> getReserveList();
}
