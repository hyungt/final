package com.ese.vo;

public class User {

	private Integer no;
	private String id;
	private String pw;
	private String zipcode;
	private String address;
	private String email;
	private String phone;
	private String name;
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "User [no=" + no + ", id=" + id + ", pw=" + pw + ", zipcode=" + zipcode + ", address=" + address
				+ ", email=" + email + ", phone=" + phone + ", name=" + name + ", getNo()=" + getNo() + ", getId()="
				+ getId() + ", getPw()=" + getPw() + ", getZipcode()=" + getZipcode() + ", getAddress()=" + getAddress()
				+ ", getEmail()=" + getEmail() + ", getPhone()=" + getPhone() + ", getName()=" + getName()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}
	
}
