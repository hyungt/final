package com.ese.mappers.manage;

import java.util.List;
import java.util.Map;

import com.ese.vo.afterservice.Center;
import com.ese.vo.hr.Break;
import com.ese.vo.hr.Department;
import com.ese.vo.hr.Employee;

public interface EmployeeMapper {

	List<Employee> getAllEmp();
	void addEmp(Employee employee);
	int getEmpSeq();
	List<Employee> getByDetpId(String deptId);
	List<Employee> getByKeyword(String keyword);
	List<Center> getAllCenter();
	List<Employee> getEmployeeByCenterId(String centerId);
	List<Employee> getByDeptHoilday(String deptId);
	List<Employee> getAllDeptHoilday();
	List<Employee> findKeyword(String keyword);
	Employee getEmpById(String email);
	void changeEmp(Employee employee);

}