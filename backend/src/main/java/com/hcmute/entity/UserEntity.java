package com.hcmute.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "user")
public class UserEntity extends BaseEntity implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Column(unique = true, nullable = false)
	private String username; 
	@Column(nullable = false)
	private String password;
	private String image;
	@Column(nullable = false)
	private String name;
	@Column(unique = true)
	private String phone;
	private String gender;
	@Column(unique = true)
	private String email;
	private String address;
	//Staff 
	@Temporal(TemporalType.TIMESTAMP)
	private Date dob;
	private String identityCard;
	@ManyToOne
	@JoinColumn(name = "store_id")
	private StoreEntity store;
//	Customer
	private int accumulatedPoints;
	private int currentPoints;
	@ManyToOne
	@JoinColumn(name = "type_id")
	private TypeEntity type;
	
	@ManyToOne
	@JoinColumn(name = "role_id")
	private RoleEntity role;
	
	@OneToMany(mappedBy = "user")
	private List<RateEntity> rates = new ArrayList<>();
	
	@OneToMany(mappedBy = "staff")
	private List<BillEntity> bills = new ArrayList<>();

	@OneToMany(mappedBy = "customer")
	private List<BillEntity> customerBills = new ArrayList<>();
	
	@OneToMany(mappedBy = "customer")
	private List<CartEntity> customerCarts = new ArrayList<>();
	
	
	@ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE} , fetch = FetchType.LAZY)
	@JoinTable(name = "user_product",
			joinColumns = @JoinColumn(name = "user_id"),
			inverseJoinColumns = @JoinColumn(name = "product_id"))
	private List<ProductEntity> favourites = new ArrayList<>();
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public RoleEntity getRole() {
		return role;
	}

	public void setRole(RoleEntity role) {
		this.role = role;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public String getIdentityCard() {
		return identityCard;
	}

	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}

	public int getAccumulatedPoints() {
		return accumulatedPoints;
	}

	public void setAccumulatedPoints(int accumulatedPoints) {
		this.accumulatedPoints = accumulatedPoints;
	}

	public int getCurrentPoints() {
		return currentPoints;
	}

	public void setCurrentPoints(int currentPoints) {
		this.currentPoints = currentPoints;
	}

	public StoreEntity getStore() {
		return store;
	}

	public void setStore(StoreEntity store) {
		this.store = store;
	}

	public TypeEntity getType() {
		return type;
	}

	public void setType(TypeEntity type) {
		this.type = type;
	}

	public List<RateEntity> getRates() {
		return rates;
	}

	public void setRates(List<RateEntity> rates) {
		this.rates = rates;
	}

	public List<BillEntity> getBills() {
		return bills;
	}

	public void setBills(List<BillEntity> bills) {
		this.bills = bills;
	}

	public List<BillEntity> getCustomerBills() {
		return customerBills;
	}
	
	public void setCustomerBills(List<BillEntity> customerBills) {
		this.customerBills = customerBills;
	}

	public List<CartEntity> getCustomerCarts() {
		return customerCarts;
	}

	public void setCustomerCarts(List<CartEntity> customerCarts) {
		this.customerCarts = customerCarts;
	}

	public List<ProductEntity> getFavourites() {
		return favourites;
	}

	public void setFavourites(List<ProductEntity> favourites) {
		this.favourites = favourites;
	}
}
