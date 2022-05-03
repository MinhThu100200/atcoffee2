package com.hcmute.dto;

public class RewardDTO extends BaseDTO<RewardDTO>{
	private String name;
	private int proviso;
	private int redution;
	public RewardDTO() {
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
	
	
}
