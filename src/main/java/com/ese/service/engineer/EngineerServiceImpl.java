package com.ese.service.engineer;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.engineer.EngineerMapper;
import com.ese.mappers.manage.pay.PayChangeMapper;
import com.ese.vo.afterservice.AfterService;
import com.ese.vo.hr.Break;
import com.ese.vo.hr.BreakSign;
import com.ese.vo.hr.Employee;
import com.ese.vo.notice.EmployeeNotice;

@Service
public class EngineerServiceImpl implements EngineerService {
	
	@Autowired
	EngineerMapper engineerMapper;
	
	@Override
	public List<EmployeeNotice> getBoardMainLimit() {
		return engineerMapper.getBoardMain();
	}
	
	@Override
	public Employee getEmployeeDetailById(String email) {
		return engineerMapper.getEmployeeById(email);
	}
	
	@Override
	public List<Break> getBreakForEmpDetail(Break break1) {
		return engineerMapper.getEngiBreakByEmpNoDetail(break1);
	}
	@Override
	public List<BreakSign> getOneBreakSign(int no) {
		return engineerMapper.getBreakSign(no);
	}
	
	@Override
	public void updateForEngineer(Employee employee) {
		engineerMapper.updateEngineer(employee);
	}
	
	@Override
	public List<Break> getAllEngineerBreak(Break break1) {
		List<Break> breaks = engineerMapper.getAllEngiBreak(break1);
		
		return breaks;
	}
	
	@Override
	public List<Break> getEngiBreakExit(int no) {
		return engineerMapper.getEngiBreakForExit(no);
	}
	
	@Override
	public int standByCheck(int breakNo) {
		return engineerMapper.standByCheck(breakNo);
	}
	
	
	@Override
	public Break modifyBreak(Break break1) {
		engineerMapper.modifyBreakByNo(break1);
		return engineerMapper.getEngiBreakByNoDetail(break1.getNo());
	}
	
	@Override
	public Break NewEngBreak(Break break1) {
		int seq = engineerMapper.getBreakSeq();
		break1.setNo(seq);
		engineerMapper.addEngiBreak(break1);
		Break break2 = engineerMapper.getEngiBreakByNoDetail(seq);
		System.out.println(break2);
		
		BreakSign sign = new BreakSign();
		sign.setBreaks(break2);
		sign.setEmployee(break2.getEmployee());
		sign.setStatus("대기");
		
		for(int i=0; i<=2; i++) {
			System.out.println(i);
			sign.setRank(i);
			engineerMapper.newBreakSign(sign);
		}
		return break2;
	}
	@Override
	public Break getEngiBreakDetail(int no) {
		return engineerMapper.getEngiBreakByNoDetail(no);
	}
	
	@Override
	public List<Employee> getEngineers() {
		return engineerMapper.getAllEngineers();
	}
	
	@Override
	public List<Break> getBreakByDate(Map<String, Object> map){
		return engineerMapper.getBreakByDate(map);
	}
	
	@Override
	public List<Employee> getEmployeeToCenterId(String centerId) {
		return engineerMapper.getEmployeeForCenterId(centerId);
	}
	
	@Override
	public List<Employee> getToDetpIdAndCenterId(Employee employee) {
		return engineerMapper.getForDetpIdAndCenterId(employee);
	}
	
	@Override
	public List<Break> toEmpStandByPlan(String centerId) {
		return engineerMapper.getEmpStandByPlan(centerId);
	}
	
	@Override
	public void acceptCenterAccept(int breakNo) {
		engineerMapper.updateCenterAccept(breakNo);
	}
	
	@Override
	public void noCenterAccept(int breakNo) {
		engineerMapper.rejectCenterAccept(breakNo);
	}
	
	@Override
	public List<AfterService> ForReserveList() {
		return engineerMapper.getReserveList();
	}
	
	
}
