package com.ese.vo.forms;

public class SuggestBoardForm {
	private String title;
	private String contents;
	
	SuggestBoardForm() {}

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

	public String toString() {
		return "SuggestBoardForm [title=" + title + ", contents=" + contents + "]";
	}
	
}
