package com.hcmute.api.response;

import com.hcmute.dto.TypeDTO;
import com.hcmute.dto.UserDTO;

public class TypeResponse {
	private TypeDTO type;
	private UserDTO user;
	
	public TypeResponse(TypeDTO type, UserDTO user) {
		super();
		this.type = type;
		this.user = user;
	}
	
	public TypeDTO getType() {
		return type;
	}
	public void setType(TypeDTO type) {
		this.type = type;
	}
	public UserDTO getUser() {
		return user;
	}
	public void setUser(UserDTO user) {
		this.user = user;
	}
	
	
}
