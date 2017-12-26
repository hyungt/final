package com.ese.vo.common;

import java.util.Date;

public class ServiceCriteria {
	private Date reservation;
	private Integer engineerNo;
	private Integer rows = 8;
	private Integer pages = 5;
	private Integer pageNo = 1;
	private String divisionId;
	
	private Integer totalRows;
	
	public int getTotalPages() {
		return (int) Math.ceil((double) totalRows/rows);
	}
	public int getTotalBlocks() {
		return (int) Math.ceil((double) getTotalPages()/pages);
	}
	public int getCurrentBlock() {
		return (int) Math.ceil((double) pageNo/pages);
	}
	public int getBeginPage() {
		return (getCurrentBlock()-1) * pages + 1;
	}
	public int getEndPage() {
		if (getCurrentBlock() == getTotalBlocks()) {
			return getTotalPages();
		}
		return getCurrentBlock() * pages;
	}
	public int getBeginIndex() {
		return (pageNo - 1) * rows + 1;
	}
	public int getEndIndex() {
		return pageNo * rows;
	}
	
	public Integer getRows() {
		return rows;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	public Integer getPages() {
		return pages;
	}
	public void setPages(Integer pages) {
		this.pages = pages;
	}
	public Integer getPageNo() {
		return pageNo;
	}
	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}
	public Integer getTotalRows() {
		return totalRows;
	}
	public void setTotalRows(Integer totalRows) {
		this.totalRows = totalRows;
	}
	
	public Date getReservation() {
		return reservation;
	}
	public void setReservation(Date reservation) {
		this.reservation = reservation;
	}
	public Integer getEngineerNo() {
		return engineerNo;
	}
	public void setEngineerNo(Integer engineerNo) {
		this.engineerNo = engineerNo;
	}
	public String getDivisionId() {
		return divisionId;
	}
	public void setDivisionId(String divisionId) {
		this.divisionId = divisionId;
	}
	
}
