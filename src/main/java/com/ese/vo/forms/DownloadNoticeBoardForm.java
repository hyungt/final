package com.ese.vo.forms;

import org.springframework.web.multipart.MultipartFile;


public class DownloadNoticeBoardForm {
	private String title;
	private String contents;
	private MultipartFile attachfile;
	private String division;
	
	
	DownloadNoticeBoardForm() {}
	
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
	public MultipartFile getAttachFile() {
		return attachfile;
	}
	public void setAttachFile(MultipartFile attachFile) {
		this.attachfile = attachFile;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}	
}
