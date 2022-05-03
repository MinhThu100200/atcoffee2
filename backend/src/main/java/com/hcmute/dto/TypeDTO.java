package com.hcmute.dto;

public class TypeDTO extends BaseDTO<TypeDTO>{
	
	private String name;
	private int point;
	public TypeDTO() {
		super();
	}
	public TypeDTO(String code, String name, int point) {
		super();
		this.name = name;
		this.point = point;
		setCode(code);
		setState(true);
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	
}
