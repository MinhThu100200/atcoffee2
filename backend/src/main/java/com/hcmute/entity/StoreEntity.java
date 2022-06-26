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

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Entity
@Table(name = "store")
public class StoreEntity extends BaseEntity implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String name;
	private String address;
	private String timeOpen;
	private String timeClose;
	private String image;
	private double latitude;
	private double longitude;
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@JoinTable(name = "store_product",
			joinColumns = {@JoinColumn(name = "store_id")},
			inverseJoinColumns = {@JoinColumn(name = "product_id")})
	private List<ProductEntity> products = new ArrayList<>();
	
	@ManyToMany(mappedBy = "favouriteStores", fetch = FetchType.LAZY)
	@Fetch(value = FetchMode.SUBSELECT)
	private List<UserEntity> customers = new ArrayList<>();

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
	
	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
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
	
	public List<UserEntity> getCustomers() {
		return customers;
	}

	public void setCustomers(List<UserEntity> customers) {
		this.customers = customers;
	}
	
	@Override
	public boolean equals(Object obj) {
		// If the object is compared with itself then return true 
        if (obj == this) {
            return true;
        }
 
        /* Check if o is an instance of Complex or not
          "null instanceof [type]" also returns false */
        if (!(obj instanceof StoreEntity)) {
            return false;
        }
         
        // typecast o to Complex so that we can compare data members
        StoreEntity storeCompare = (StoreEntity) obj;
         
        // Compare the data members and return accordingly
        return Long.compare(getId(), storeCompare.getId()) == 0;
	}
}
