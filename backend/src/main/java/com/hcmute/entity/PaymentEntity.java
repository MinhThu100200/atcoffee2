package com.hcmute.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "payment")
public class PaymentEntity extends BaseEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String name;
	
	@OneToMany(mappedBy = "payment")
	private List<BillEntity> bills = new ArrayList<>();
	
	public PaymentEntity() {
		super();
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public List<BillEntity> getBills() {
		return bills;
	}

	public void setBills(List<BillEntity> bills) {
		this.bills = bills;
	}
	
	
}
