package com.ese.vo.common;

public class PayChangeChartResult {
	
	private String day;
	private String type;
	private Long income;
	private Long expenditure;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public Long getIncome() {
		return income;
	}
	public void setIncome(Long income) {
		this.income = income;
	}
	public Long getExpenditure() {
		return expenditure;
	}
	public void setExpenditure(Long expenditure) {
		this.expenditure = expenditure;
	}
	@Override
	public String toString() {
		return "PayChangeChartResult [day=" + day + ", type=" + type + ", income=" + income + ", expenditure="
				+ expenditure + "]";
	}
	
}
