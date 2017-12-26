package com.ese.vo.common;

public class UserOrderCriteria {
	
	private int userNo;
	private String startdate;
	private String enddate;
	
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	@Override
	public String toString() {
		return "UserOrderCriteria [userNo=" + userNo + ", startdate=" + startdate + ", enddate=" + enddate + "]";
	}
	
	
}
