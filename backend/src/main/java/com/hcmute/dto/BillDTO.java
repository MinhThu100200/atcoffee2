package com.hcmute.dto;

import java.util.ArrayList;
import java.util.List;

public class BillDTO extends BaseDTO<BillDTO>{
	private float amount;
	private float price;
	private int discount;
	private int point;
	private String address; 
	private String status;
	private Long rewardId;
	private Long promotionId;
	private Long paymentId;
	private Long staffId;
	private Long customerId;
	private Long storeId;
	private List<BillDetailDTO> billDetails = new ArrayList<BillDetailDTO>();
	
	public BillDTO() {
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
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public Long getRewardId() {
		return rewardId;
	}
	public void setRewardId(Long rewardId) {
		this.rewardId = rewardId;
	}
	public Long getPromotionId() {
		return promotionId;
	}
	public void setPromotionId(Long promotionId) {
		this.promotionId = promotionId;
	}
	public Long getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(Long paymentId) {
		this.paymentId = paymentId;
	}
	public Long getStaffId() {
		return staffId;
	}
	public void setStaffId(Long staffId) {
		this.staffId = staffId;
	}
	public Long getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}
	public Long getStoreId() {
		return storeId;
	}
	public void setStoreId(Long storeId) {
		this.storeId = storeId;
	}
	public List<BillDetailDTO> getBillDetails() {
		return billDetails;
	}
	public void setBillDetails(List<BillDetailDTO> billDetails) {
		this.billDetails = billDetails;
	}
	
	
}
