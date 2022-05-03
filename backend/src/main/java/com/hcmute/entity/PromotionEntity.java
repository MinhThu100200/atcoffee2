package com.hcmute.entity;

import static javax.persistence.TemporalType.TIMESTAMP;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;

@Entity
@Table(name = "promotion")
public class PromotionEntity extends BaseEntity implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private String code;
	@Column(name = "name")
	private String name;
	private String image;
	@Column(columnDefinition = "TEXT")
	private String description;
	private int discount;
	private String object;
	private int proviso;
	@Temporal(TIMESTAMP)
	private Date startDate;
	@Temporal(TIMESTAMP)
	private Date endDate;
	
	@OneToMany(mappedBy = "promotion")
	private List<BillEntity> bills = new ArrayList<>();
	
	public PromotionEntity() {
		super();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
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

	public List<BillEntity> getBills() {
		return bills;
	}

	public void setBills(List<BillEntity> bills) {
		this.bills = bills;
	}
	
	
	
}
