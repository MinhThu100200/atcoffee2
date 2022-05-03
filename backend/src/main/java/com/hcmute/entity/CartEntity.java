package com.hcmute.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "cart")
public class CartEntity extends BaseEntity implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int quantity;
	private String description;
	private String size;
	@ManyToOne
	@JoinColumn(name = "product_id")
	private ProductEntity product;
	@ManyToOne
	@JoinColumn(name = "customer_id")
	private UserEntity customer;
	@ManyToOne
	@JoinColumn(name = "store_id")
	private StoreEntity store;
	
	public CartEntity(int quantity, String description, ProductEntity product, UserEntity customer, StoreEntity store) {
		super();
		this.quantity = quantity;
		this.description = description;
		this.product = product;
		this.customer = customer;
		this.store = store;
	}
	public CartEntity() {
		super();
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public ProductEntity getProduct() {
		return product;
	}
	public void setProduct(ProductEntity product) {
		this.product = product;
	}
	public UserEntity getCustomer() {
		return customer;
	}
	public void setCustomer(UserEntity customer) {
		this.customer = customer;
	}
	public StoreEntity getStore() {
		return store;
	}
	public void setStore(StoreEntity store) {
		this.store = store;
	}	
}	
