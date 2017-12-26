package com.ese.vo.notice;

import java.util.Date;

import com.ese.vo.hr.Employee;
import com.ese.vo.web.serializer.DateSerializer;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

public class Suggest {

	private Integer no;
	private String title;
	private String contents;
	private Integer parentNo;
	@JsonSerialize(using=DateSerializer.class)
	private Date createdate;
	private Employee employee;
	private String conf;
	
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
	public Integer getParentNo() {
		return parentNo;
	}
	public void setParentNo(Integer parentNo) {
		this.parentNo = parentNo;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public String getConf() {
		return conf;
	}
	public void setConf(String conf) {
		this.conf = conf;
	}
	@Override
	public String toString() {
		return "Suggest [no=" + no + ", title=" + title + ", contents=" + contents + ", parentNo=" + parentNo
				+ ", createdate=" + createdate + ", employee=" + employee + ", conf=" + conf + "]";
	}
	
}
