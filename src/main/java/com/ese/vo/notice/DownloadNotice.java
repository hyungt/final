package com.ese.vo.notice;

import java.util.Date;

public class DownloadNotice {
	
	private Integer no;
	private String title;
	private String contents;
	private Date createdate;
	private Integer count;
	private FileAttach attachFile;
	private String category;
	
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
	public FileAttach getAttachFile() {
		return attachFile;
	}
	public void setAttachFile(FileAttach attachFile) {
		this.attachFile = attachFile;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	@Override
	public String toString() {
		return "DownloadNotice [no=" + no + ", title=" + title + ", contents=" + contents + ", createdate=" + createdate
				+ ", count=" + count + ", attachFile=" + attachFile + ", category=" + category + "]";
	}
	
	
}
