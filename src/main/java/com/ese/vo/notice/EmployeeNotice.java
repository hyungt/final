package com.ese.vo.notice;

import java.util.Date;

import com.ese.common.serializer.YYYYMMDDDataSerializer;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

public class EmployeeNotice {

	private Integer no;
	private String title;
	private String contents;
	@JsonSerialize(using=YYYYMMDDDataSerializer.class)
	private Date createdate;
	private Integer count;
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
}
