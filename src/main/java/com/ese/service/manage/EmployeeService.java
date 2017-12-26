package com.ese.service.manage;

import java.util.List;

import com.ese.vo.afterservice.Center;
import com.ese.vo.hr.Department;
import com.ese.vo.hr.Employee;

public interface EmployeeService {

	List<Employee> getAllEmp();
	void addEmp(Employee employee);
	List<Employee> getByDetpId(String deptId);
	List<Employee> getByKeyword(String keyword);
	List<Center> getAllCenter();
	List<Employee> getByDeptHoilday(String deptId);
	List<Employee> getAllDeptHoilday();
	List<Employee> findKeyword(String keyword);
	Employee getEmpById(String email);
	void changeEmp(Employee employee);
}
