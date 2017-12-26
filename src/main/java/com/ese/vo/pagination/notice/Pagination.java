package com.ese.vo.pagination.notice;

public class Pagination {
	private Integer rows = 5;
	private Integer pages = 5;
	private Integer pageNo = 1;
	
	private String opt;
	private String keyword;
	private String comp;
	private String incomp;
	private String oppt = "all";
	
	private int totalRows;
	
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
		if(rows == null) {
			this.rows = 5;
		}
		return rows;
	}
	public void setRows(Integer rows) {
		if (rows == null) {
			rows = 5;
		}
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
	public String getOpt() {
		return opt;
	}
	public void setOpt(String opt) {
		this.opt = opt;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getTotalRows() {
		return totalRows;
	}
	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}
	public String getComp() {
		return comp;
	}
	public void setComp(String comp) {
		this.comp = comp;
	}
	public String getIncomp() {
		return incomp;
	}
	public void setIncomp(String incomp) {
		this.incomp = incomp;
	}
	public String getOppt() {
		return oppt;
	}
	public void setOppt(String oppt) {
		this.oppt = oppt;
	}
	@Override
	public String toString() {
		return "Pagination [rows=" + rows + ", pages=" + pages + ", pageNo=" + pageNo + ", opt=" + opt + ", keyword="
				+ keyword + ", comp=" + comp + ", incomp=" + incomp + ", oppt=" + oppt + ", totalRows=" + totalRows
				+ "]";
	}
	
	
	
}
