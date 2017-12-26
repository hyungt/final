package com.ese.vo.hr;

public class BreakSign {
	private Integer rank;
	private String status;
	private Break breaks;
	private Employee employee;
	private String reason;
	
	public Integer getRank() {
		return rank;
	}
	public void setRank(Integer rank) {
		this.rank = rank;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Break getBreaks() {
		return breaks;
	}
	public void setBreaks(Break breaks) {
		this.breaks = breaks;
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
	@Override
	public String toString() {
		return "BreakSign [rank=" + rank + ", status=" + status + ", breaks=" + breaks + ", employee=" + employee
				+ ", reason=" + reason + "]";
	}
	
	
}
