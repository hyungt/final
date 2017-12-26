package com.ese.vo.product;

import com.ese.vo.Division;

public class Product {

	private String id;
	private String name;
	private Division division;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Division getDivision() {
		return division;
	}
	public void setDivision(Division division) {
		this.division = division;
	}
	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", division=" + division + "]";
	}
}
