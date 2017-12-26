package com.ese.vo.pay;

import java.util.Date;

public class PayChange {
	private Integer no;
	private Long money;
	private String type;
	private Date changedate;
	private String reason;
	private PayChangeType changeType;
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public Long getMoney() {
		return money;
	}
	public void setMoney(Long money) {
		this.money = money;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Date getChangedate() {
		return changedate;
	}
	public void setChangedate(Date changedate) {
		this.changedate = changedate;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public PayChangeType getChangeType() {
		return changeType;
	}
	public void setChangeType(PayChangeType changeType) {
		this.changeType = changeType;
	}
	@Override
	public String toString() {
		return "PayChange [no=" + no + ", money=" + money + ", type=" + type + ", changedate=" + changedate
				+ ", reason=" + reason + ", changeType=" + changeType + "]";
	}
}
