package com.ese.vo.product;

import com.ese.vo.part.Part;

public class PartUsingModel {

	private Part part;
	private Product product;
	
	public Part getPart() {
		return part;
	}
	public void setPart(Part part) {
		this.part = part;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	@Override
	public String toString() {
		return "PartUsingModel [part=" + part + ", product=" + product + "]";
	}
	
}
