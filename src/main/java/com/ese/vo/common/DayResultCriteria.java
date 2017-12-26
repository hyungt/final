package com.ese.vo.common;

public class DayResultCriteria {
	
	private String startdate;
	private String enddate;
	
	

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
		return "DayResultCriteria [startdate=" + startdate + ", enddate=" + enddate + "]";
	}


	
}
