package com.hcmute.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "reward")
public class RewardEntity extends BaseEntity implements Serializable{

	private static final long serialVersionUID = -3898916842853162269L;

	@Column(name = "name")
	private String name;
	private int proviso;
	private int redution;
	
	@OneToMany(mappedBy = "reward")
	private List<BillEntity> bills = new ArrayList<>();
	
	public RewardEntity() {
		super();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getProviso() {
		return proviso;
	}

	public void setProviso(int proviso) {
		this.proviso = proviso;
	}

	public int getRedution() {
		return redution;
	}

	public void setRedution(int redution) {
		this.redution = redution;
	}

	public List<BillEntity> getBills() {
		return bills;
	}

	public void setBills(List<BillEntity> bills) {
		this.bills = bills;
	}
	
	
}
