package com.hcmute.dto;

public class SizeDTO extends BaseDTO<SizeDTO>{
	private String size;
	private float price;
	private Long productId;
	public SizeDTO(String size, float price, Long productId) {
		super();
		this.size = size;
		this.price = price;
		this.productId = productId;
		this.setState(true);
	}
	public SizeDTO() {
		super();
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public Long getProductId() {
		return productId;
	}
	public void setProductId(Long productId) {
		this.productId = productId;
	}
	
	
}
