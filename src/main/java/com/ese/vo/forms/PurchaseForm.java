package com.ese.vo.forms;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;

public class PurchaseForm {
	
	private Integer partNo;
	private Integer count;
	private Integer purchase;
	private Integer buyerNo;
	
	@NotEmpty(message="이름은 필수입력")
	@Length(min=2, message="이름은 2글자 이상 입력해야 합니다.")
	private String recipient;
	
	@NotEmpty(message="이메일은 필수입력")
	private String email;
	
	@NotEmpty(message="전화번호는 필수입력")
	@Pattern(regexp="^\\d{3}-\\d{3,4}-\\d{4}$")
	private String phone;
	
	@NotEmpty(message="우편번호 필수입력")
	private String zipcode;
	
	@NotEmpty(message="주소는 필수입력")
	private String address1;
	private String address2;
	private String message;

	public Integer getPartNo() {
		return partNo;
	}
	public void setPartNo(Integer partNo) {
		this.partNo = partNo;
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
	public Integer getBuyerNo() {
		return buyerNo;
	}
	public void setBuyerNo(Integer buyerNo) {
		this.buyerNo = buyerNo;
	}
	public String getRecipient() {
		return recipient;
	}
	public void setRecipient(String recipient) {
		this.recipient = recipient;
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
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	@Override
	public String toString() {
		return "PurchaseForm [partNo=" + partNo + ", count=" + count + ", purchase=" + purchase + ", buyerNo=" + buyerNo
				+ ", recipient=" + recipient + ", email=" + email + ", phone=" + phone + ", zipcode=" + zipcode
				+ ", address1=" + address1 + ", address2=" + address2 + ", message=" + message +" ]";
	}
}
