package com.hcmute.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "store")
public class StoreEntity extends BaseEntity implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String name;
	private String address;
	private String timeOpen;
	private String timeClose;
	private double latitude;
	private double longitude;
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@JoinTable(name = "store_product",
			joinColumns = {@JoinColumn(name = "store_id")},
			inverseJoinColumns = {@JoinColumn(name = "product_id")})
	private List<ProductEntity> products = new ArrayList<>();
	
	@OneToMany(mappedBy = "store")
	private List<UserEntity> users = new ArrayList<>();
	
	@OneToMany(mappedBy = "store")
	private List<BillEntity> bills = new ArrayList<>();
	
	@OneToMany(mappedBy = "store")
	private List<CartEntity> carts = new ArrayList<>();
	
	public StoreEntity() {
		super();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTimeOpen() {
		return timeOpen;
	}

	public void setTimeOpen(String timeOpen) {
		this.timeOpen = timeOpen;
	}

	public String getTimeClose() {
		return timeClose;
	}

	public void setTimeClose(String timeClose) {
		this.timeClose = timeClose;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public List<ProductEntity> getProducts() {
		return products;
	}

	public void setProducts(List<ProductEntity> products) {
		for(ProductEntity product : products) {
			this.products.add(product);
			product.getStores().add(this);
		}
	}

	public List<UserEntity> getUsers() {
		return users;
	}

	public void setUsers(List<UserEntity> users) {
		this.users = users;
	}

	public List<BillEntity> getBills() {
		return bills;
	}

	public void setBills(List<BillEntity> bills) {
		this.bills = bills;
	}

	public List<CartEntity> getCarts() {
		return carts;
	}

	public void setCarts(List<CartEntity> carts) {
		this.carts = carts;
	}
	
}
