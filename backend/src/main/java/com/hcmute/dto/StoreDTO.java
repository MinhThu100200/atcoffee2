package com.hcmute.dto;

public class StoreDTO extends BaseDTO<StoreDTO>{
	private String name;
	private String address;
	private String timeOpen;
	private  String timeClose;
	
	public StoreDTO() {
		super();
	}
	
	public StoreDTO(String code, String name, String address, String timeOpen, String timeClose) {
		super();
		setCode(code);
		this.name = name;
		this.address = address;
		this.timeOpen = timeOpen;
		this.timeClose = timeClose;
		setState(true);
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
	
}
