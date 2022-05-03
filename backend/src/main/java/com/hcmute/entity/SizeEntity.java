package com.hcmute.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "size")
public class SizeEntity extends BaseEntity implements Serializable{ 

	private static final long serialVersionUID = 1L;
	
	private String size;
	private float price;
	@ManyToOne
	@JoinColumn(name = "product_id")
	private ProductEntity product;
	public SizeEntity(String size, float price, ProductEntity product) {
		super();
		this.size = size;
		this.price = price;
		this.product = product;
	}
	public SizeEntity() {
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
	public ProductEntity getProduct() {
		return product;
	}
	public void setProduct(ProductEntity product) {
		this.product = product;
	}
	
}
