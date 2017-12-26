package com.ese.vo.afterservice;

import java.util.Date;

import com.ese.vo.Division;
import com.ese.vo.User;
import com.ese.vo.hr.Employee;
import com.ese.vo.product.Product;

public class AfterService {
	private Integer no;
	private String symptom;
	private Date reservation;
	private User user;
	private Employee employee;
	private Center center;
	private Division division;
	private ServiceStatus serviceStatus;
	private ServiceType serviceType;
	private String address;
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public String getSymptom() {
		return symptom;
	}
	public void setSymptom(String symptom) {
		this.symptom = symptom;
	}
	public Date getReservation() {
		return reservation;
	}
	public void setReservation(Date reservation) {
		this.reservation = reservation;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public Center getCenter() {
		return center;
	}
	public void setCenter(Center center) {
		this.center = center;
	}
	public Division getDivision() {
		return division;
	}
	public void setDivision(Division division) {
		this.division = division;
	}
	public ServiceStatus getServiceStatus() {
		return serviceStatus;
	}
	public void setServiceStatus(ServiceStatus serviceStatus) {
		this.serviceStatus = serviceStatus;
	}
	public ServiceType getServiceType() {
		return serviceType;
	}
	public void setServiceType(ServiceType serviceType) {
		this.serviceType = serviceType;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Override
	public String toString() {
		return "AfterService [no=" + no + ", symptom=" + symptom + ", reservation=" + reservation + ", user=" + user
				+ ", employee=" + employee + ", center=" + center + ", division=" + division + ", serviceStatus="
				+ serviceStatus + ", serviceType=" + serviceType + ", address=" + address + "]";
	}
	
}
