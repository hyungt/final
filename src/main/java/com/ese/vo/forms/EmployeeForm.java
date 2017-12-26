package com.ese.vo.forms;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;
import org.springframework.web.multipart.MultipartFile;

import com.ese.vo.afterservice.Center;
import com.ese.vo.hr.Department;
import com.ese.vo.hr.Position;

public class EmployeeForm {

	
	@NotEmpty(message="비밀번호는 필수 입력값입니다.")
	@Length(min=6 , max=20)
	private String password;
	
	@NotEmpty
	private String email;
	
	private Integer no;
	
	
	private Long salary;
	
	@NotEmpty
	@Length(min=2, message="이름은 2글자 이상 입력해야 합니다.")
	private String name;
	
	@NotEmpty
	@Pattern(regexp="^\\d{3}-\\d{3,4}-\\d{4}$")
	private String phone;
	
	private String center;
	
	private String department;
	
	private String position;
	
	private MultipartFile pic;

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

	public String getCenter() {
		return center;
	}

	public void setCenter(String center) {
		this.center = center;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public MultipartFile getPic() {
		return pic;
	}

	public void setPic(MultipartFile pic) {
		this.pic = pic;
	}

	public Integer getNo() {
		return no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	@Override
	public String toString() {
		return "EmployeeForm [password=" + password + ", email=" + email + ", no=" + no + ", salary=" + salary
				+ ", name=" + name + ", phone=" + phone + ", center=" + center + ", department=" + department
				+ ", position=" + position + ", pic=" + pic + "]";
	}

	
	
	
}