package com.ese.vo.notice;

import java.util.Date;

public class FileAttach {
	
	private Integer no;
	private String name;
	private Long size;
	private Date createdate;
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Long getSize() {
		return size;
	}
	public void setSize(Long size) {
		this.size = size;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	@Override
	public String toString() {
		return "FileAttach [no=" + no + ", name=" + name + ", size=" + size + ", createdate=" + createdate + "]";
	}
	
}
