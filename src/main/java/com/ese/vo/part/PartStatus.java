package com.ese.vo.part;

public class PartStatus {
	
	private String id;
	private String status;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "PartStatus [id=" + id + ", status=" + status + "]";
	}
}
