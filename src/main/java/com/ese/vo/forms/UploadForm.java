package com.ese.vo.forms;

import org.springframework.web.multipart.MultipartFile;


public class UploadForm {

	private Integer no;
	private String title;
	private String contents;
	private String category;
	private Long fileSize;
	private MultipartFile upfile;
	
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

	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
	public Long getFileSize() {
		return fileSize;
	}
	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}
	
	public MultipartFile getUpfile() {
		return upfile;
	}
	public void setUpfile(MultipartFile upfile) {
		this.upfile = upfile;
	}
	@Override
	public String toString() {
		return "UploadForm [no=" + no + ", title=" + title + ", contents=" + contents + ", category=" + category
				+ ", fileSize=" + fileSize + ", upfile=" + upfile + "]";
	}
	
	

}
