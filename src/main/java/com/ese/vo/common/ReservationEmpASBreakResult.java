package com.ese.vo.common;

import java.util.List;

import com.ese.vo.afterservice.AfterService;
import com.ese.vo.hr.Break;

public class ReservationEmpASBreakResult {
	private List<AfterService> asList;
	private List<Break> breakList;
	
	public List<AfterService> getAsList() {
		return asList;
	}
	public void setAsList(List<AfterService> asList) {
		this.asList = asList;
	}
	public List<Break> getBreakList() {
		return breakList;
	}
	public void setBreakList(List<Break> breakList) {
		this.breakList = breakList;
	}
}
