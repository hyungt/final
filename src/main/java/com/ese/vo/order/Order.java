package com.ese.vo.order;

import java.util.Date;

import com.ese.vo.User;
import com.ese.vo.part.Part;

public class Order {
	
	private Integer no;
	private Integer count;
	private Integer purchase;
	private String address;
	private String zipcode;
	private String email;
	private String phone;
	private String recipient;
	private String message;
	private User user;
	private Part part;
	private OrderStatus statusId;
	private Date dates;
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public Integer getPurchase() {
		return purchase;
	}
	public void setPurchase(Integer purchase) {
		this.purchase = purchase;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
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
	public String getRecipient() {
		return recipient;
	}
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Part getPart() {
		return part;
	}
	public void setPart(Part part) {
		this.part = part;
	}
	public OrderStatus getStatusId() {
		return statusId;
	}
	public void setStatusId(OrderStatus statusId) {
		this.statusId = statusId;
	}
	public Date getDates() {
		return dates;
	}
	public void setDate(Date dates) {
		this.dates = dates;
	}
	@Override
	public String toString() {
		return "Order [no=" + no + ", count=" + count + ", purchase=" + purchase + ", address=" + address + ", zipcode="
				+ zipcode + ", email=" + email + ", phone=" + phone + ", recipient=" + recipient + ", message="
				+ message + ", user=" + user + ", part=" + part + ", statusId=" + statusId + "]";
	}
}
