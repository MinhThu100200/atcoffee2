package com.hcmute.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "bill")
public class BillEntity extends BaseEntity implements Serializable {

	private static final long serialVersionUID = 1L;
	private float amount;
	private float price;
	private int discount;
	private int point;
	private String address;
	private String status;
	@OneToMany(mappedBy = "bill")
	List<BillDetailEntity> billDetails = new ArrayList<>();
	
	@ManyToOne
	@JoinColumn(name = "reward_id")
	private RewardEntity reward;
	
	@ManyToOne
	@JoinColumn(name = "promotion_id")
	private PromotionEntity promotion;
	
	@ManyToOne
	@JoinColumn(name = "payment_id")
	private PaymentEntity payment;
	
	@ManyToOne
	@JoinColumn(name = "staff_id")
	private UserEntity staff;
	
	@ManyToOne
	@JoinColumn(name = "customer_id")
	private UserEntity customer;
	
	@ManyToOne
	@JoinColumn(name = "store_id")
	private StoreEntity store;
	
	public BillEntity() {
		super();
	}
	public float getAmount() {
		return amount;
	}
	public void setAmount(float amount) {
		this.amount = amount;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public List<BillDetailEntity> getBillDetails() {
		return billDetails;
	}
	public void setBillDetails(List<BillDetailEntity> billDetails) {
		this.billDetails = billDetails;
	}
	public RewardEntity getReward() {
		return reward;
	}
	public void setReward(RewardEntity reward) {
		this.reward = reward;
	}
	public PromotionEntity getPromotion() {
		return promotion;
	}
	public void setPromotion(PromotionEntity promotion) {
		this.promotion = promotion;
	}
	public PaymentEntity getPayment() {
		return payment;
	}
	public void setPayment(PaymentEntity payment) {
		this.payment = payment;
	}
	public UserEntity getStaff() {
		return staff;
	}
	public void setStaff(UserEntity staff) {
		this.staff = staff;
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
