package com.ese.vo.pay;

import java.util.Date;

import com.ese.vo.hr.Employee;

public class MonthlyPay {
	
	private Integer no;
	private Employee employee;
	private Date payMonth;
	private Long pay;
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public Date getPayMonth() {
		return payMonth;
	}
	public void setPayMonth(Date payMonth) {
		this.payMonth = payMonth;
	}
	public Long getPay() {
		return pay;
	}
	public void setPay(Long pay) {
		this.pay = pay;
	}
}