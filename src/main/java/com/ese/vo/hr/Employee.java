package com.ese.vo.hr;

import java.util.Date;

import com.ese.vo.afterservice.Center;
import com.fasterxml.jackson.annotation.JsonIgnore;

public class Employee {
	
	private Integer no;
	@JsonIgnore
	private String password;
	private String email;
	private Long salary;
	private String name;
	private String phone;
	private Date hiredate;
	private String work;
	private Center center;
	private Department department;
	private Position position;
	private String pic;
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Long getSalary() {
		return salary;
	}
	public void setSalary(Long salary) {
		this.salary = salary;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getHiredate() {
		return hiredate;
	}
	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}
	public String getWork() {
		return work;
	}
	public void setWork(String work) {
		this.work = work;
	}
	public Center getCenter() {
		return center;
	}
	public void setCenter(Center center) {
		this.center = center;
	}
	public Department getDepartment() {
		return department;
	}
	public void setDepartment(Department department) {
		this.department = department;
	}
	public Position getPosition() {
		return position;
	}
	public void setPosition(Position position) {
		this.position = position;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	@Override
	public String toString() {
		return "Employee [no=" + no + ", password=" + password + ", email=" + email + ", salary=" + salary + ", name="
				+ name + ", phone=" + phone + ", hiredate=" + hiredate + ", work=" + work + ", center=" + center
				+ ", department=" + department + ", position=" + position + ", pic=" + pic + "]";
	}
	
	
}
