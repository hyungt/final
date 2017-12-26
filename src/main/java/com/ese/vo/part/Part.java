package com.ese.vo.part;

import com.ese.vo.Division;

public class Part {
	
	private Integer no;
	private String name;
	private String modelName;
	private Long price;
	private Long cost;
	private Integer qty;
	private PartStatus partStatus;
	private Division division;
	private String info;
	private String imagepath;
	
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
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
	public Integer getQty() {
		return qty;
	}
	public void setQty(Integer qty) {
		this.qty = qty;
	}
	public PartStatus getPartStatus() {
		return partStatus;
	}
	public void setPartStatus(PartStatus partStatus) {
		this.partStatus = partStatus;
	}
	public Division getDivision() {
		return division;
	}
	public void setDivision(Division division) {
		this.division = division;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getImagepath() {
		return imagepath;
	}
	public void setImagepath(String imagepath) {
		this.imagepath = imagepath;
	}
	@Override
	public String toString() {
		return "Part [no=" + no + ", name=" + name + ", price=" + price + ", cost=" + cost + ", qty=" + qty
				+ ", partStatus=" + partStatus + ", division=" + division + ", info=" + info + ", imagepath="
				+ imagepath + "]";
	}
}
