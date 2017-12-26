package com.ese.vo.hr;

import java.util.Date;



public class Break {
	private Integer no;
	private Date apply;
	private Date startdate;
	private Date enddate;
	private Employee employee;
	private String reason;
	private String fetchFile;
	private String completed;
	
	public String getCompleted() {
		return completed;
	}
	public void setCompleted(String completed) {
		this.completed = completed;
	}
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public Date getApply() {
		return apply;
	}
	public void setApply(Date apply) {
		this.apply = apply;
	}
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public Date getEnddate() {
		return enddate;
	}
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getFetchFile() {
		return fetchFile;
	}
	public void setFetchFile(String fetchFile) {
		this.fetchFile = fetchFile;
	}
	@Override
	public String toString() {
		return "Break [no=" + no + ", apply=" + apply + ", startdate=" + startdate + ", enddate=" + enddate
				+ ", employee=" + employee + ", reason=" + reason + ", fetchFile=" + fetchFile + "]";
	}
	
}
