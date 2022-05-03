package com.hcmute.dto;

public class CategoryDTO extends BaseDTO<CategoryDTO>{
	private String name;
	public CategoryDTO() {
		super();
	}
	
	public CategoryDTO(String code, String name) {
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
