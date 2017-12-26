package com.ese.vo.common;

public class UseServiceCriteria {
	
	private Integer rows = 4;
	private Integer pages = 5;
	private Integer pageNo = 1;
	private int userNo;
	
	private int totalRows;
	
	public int getBeginIndex() {
		return (pageNo - 1) * rows + 1;
	}
	public int getEndIndex() {
		return pageNo * rows;
	}
	public int getTotalPages() {
		return (int) Math.ceil((double) totalRows/rows);
	}
	// 전체 블록
	public int getTotalBlocks() {
		return (int) Math.ceil((double) getTotalPages()/pages);
	}
	// 현재 블록
	public int getCurrentBlock() {
		return (int) Math.ceil((double) pageNo/pages);
	}
	public int getBeginPage() {
		return (getCurrentBlock() -1) * pages + 1;
	}
	public int getEndPage() {
		if(getCurrentBlock() == getTotalBlocks()) {
			return getTotalPages();
		}
		return getCurrentBlock() * pages;
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

	public Integer getUserNo() {
		return userNo;
	}

	public void setUserNo(Integer userNo) {
		this.userNo = userNo;
	}

	public int getTotalRows() {
		return totalRows;
	}

	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}

	@Override
	public String toString() {
		return "UseServiceCriteria [rows=" + rows + ", pages=" + pages + ", pageNo=" + pageNo + ", userNo=" + userNo
				+ ", totalRows=" + totalRows + "]";
	}
	
	
}
