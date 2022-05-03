package com.hcmute.dto;

public class PaymentDTO extends BaseDTO<PaymentDTO>{
	private String name;

	public PaymentDTO() {
		super();
	}
	

	public PaymentDTO(String code, String name) {
		super();
		setCode(code);
		this.name = name;
		setState(true);
	}


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
