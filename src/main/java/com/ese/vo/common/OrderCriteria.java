package com.ese.vo.common;

public class OrderCriteria {
	
	private Integer rows = 5;
	private Integer pages = 5;
	private Integer pageNo = 1;
	private String orderStatusId;
	private Integer orderNo;
	private Integer choice;
	
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

	public String getOrderStatusId() {
		return orderStatusId;
	}

	public void setOrderStatusId(String orderStatusId) {
		this.orderStatusId = orderStatusId;
	}

	public int getTotalRows() {
		return totalRows;
	}

	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}

	public Integer getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}

	public Integer getChoice() {
		return choice;
	}

	public void setChoice(Integer choice) {
		this.choice = choice;
	}
	
	@Override
	public String toString() {
		return "OrderCriteria [rows=" + rows + ", pages=" + pages + ", pageNo=" + pageNo + ", orderStatusId="
				+ orderStatusId + ", orderNo=" + orderNo + ", choice=" + choice + ", totalRows=" + totalRows + "]";
	}
}
