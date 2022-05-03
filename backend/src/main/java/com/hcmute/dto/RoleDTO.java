package com.hcmute.dto;

public class RoleDTO extends BaseDTO<RoleDTO>{
	
	private String name;
	
	public RoleDTO() {
		super();
	}
	
	public RoleDTO(String code, String name) {
		super();
		this.name = name;
		setCode(code);
		setState(true);
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
