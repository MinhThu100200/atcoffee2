package com.hcmute.dto;

import static javax.persistence.TemporalType.TIMESTAMP;

import java.util.Date;

import javax.persistence.Temporal;

public class PromotionDTO extends BaseDTO<PromotionDTO>{
	private String code;
	private String name;
	private String image;
	private String description;
	private int discount;
	private String object;
	private int proviso;
	@Temporal(TIMESTAMP)
	private Date startDate;
	@Temporal(TIMESTAMP)
	private Date endDate;
	public PromotionDTO() {
		super();
	}
	@Override
	public String getCode() {
		return code;
	}
	@Override
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public String getObject() {
		return object;
	}
	public void setObject(String object) {
		this.object = object;
	}
	public int getProviso() {
		return proviso;
	}
	public void setProviso(int proviso) {
		this.proviso = proviso;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	
}
