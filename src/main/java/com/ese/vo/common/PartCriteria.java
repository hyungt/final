package com.ese.vo.common;


public class PartCriteria {

	private Integer rows = 5;
	private Integer pages = 5;
	private Integer pageNo = 1;
	private String categoryId;
	private String divisionId;
	
	private int totalRows;
	
	public int getBeginIndex() {
		return (pageNo -1) * rows+1;
	}
	
	public int getEndIndex() {
		return pageNo*rows;
	}
	
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
		if(totalRows == 0) {
			return 0;
		}
		return(getCurrentBlock()-1)*pages+1;
	}
	
	public int getEndPage() {
		if(totalRows == 0) {
			return 0;
		}
		if(getCurrentBlock() == getTotalBlocks()) {
			return getTotalPages();
		}
		return getCurrentBlock()*pages;
	}
	
	public Integer getPageNo() {
		return pageNo;
	}
	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}
	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getDivisionId() {
		return divisionId;
	}

	public void setDivisionId(String divisionId) {
		this.divisionId = divisionId;
	}

	public Integer getRows() {
		return rows;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	public int getTotalRows() {
		return totalRows;
	}

	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}

	@Override
	public String toString() {
		return "Criteria [PageNo=" + pageNo + ", categoryId=" + categoryId + ", divisionId=" + divisionId + "]";
	}
}
