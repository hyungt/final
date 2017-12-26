package com.ese.vo.forms;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ese.vo.product.Product;

public class PartForm {

	private Integer partnum;
	private String name;
	private String modelName;
	private String divId;
	private String statusId;
	private List<String> products;
	private MultipartFile image;
	private MultipartFile infoimg;
	private Integer qty;
	private Long price;
	private Long cost;
	public Integer getPartnum() {
		return partnum;
	}
	public void setPartnum(Integer partnum) {
		this.partnum = partnum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getModelName() {
		return modelName;
	}
	public void setModelName(String modelName) {
		this.modelName = modelName;
	}
	public String getDivId() {
		return divId;
	}
	public void setDivId(String divId) {
		this.divId = divId;
	}
	public String getStatusId() {
		return statusId;
	}
	public void setStatusId(String statusId) {
		this.statusId = statusId;
	}
	public List<String> getProducts() {
		return products;
	}
	public void setProducts(List<String> products) {
		this.products = products;
	}
	public MultipartFile getImage() {
		return image;
	}
	public void setImage(MultipartFile image) {
		this.image = image;
	}
	public MultipartFile getInfoimg() {
		return infoimg;
	}
	public void setInfoimg(MultipartFile infoimg) {
		this.infoimg = infoimg;
	}
	public Integer getQty() {
		return qty;
	}
	public void setQty(Integer qty) {
		this.qty = qty;
	}
	public Long getPrice() {
		return price;
	}
	public void setPrice(Long price) {
		this.price = price;
	}
	public Long getCost() {
		return cost;
	}
	public void setCost(Long cost) {
		this.cost = cost;
	}
	@Override
	public String toString() {
		return "PartForm [partnum=" + partnum + ", name=" + name + ", modelName=" + modelName + ", divId=" + divId
				+ ", statusId=" + statusId + ", products=" + products + ", image=" + image + ", infoimg=" + infoimg
				+ ", qty=" + qty + ", price=" + price + ", cost=" + cost + "]";
	}
}
