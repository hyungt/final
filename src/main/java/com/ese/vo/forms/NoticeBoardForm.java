package com.ese.vo.forms;

public class NoticeBoardForm {
	private String title;
	private String contents;
	
	NoticeBoardForm() {}

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

	@Override
	public String toString() {
		return "BoardForm [title=" + title + ", contents=" + contents + "]";
	}
}
