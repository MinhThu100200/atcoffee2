package com.hcmute.api.response;

import com.hcmute.dto.UserDTO;

public class AuthenticationResponse {
	private final String jwt;
	private final UserDTO user;

	public AuthenticationResponse(String jwt, UserDTO user) {
		this.jwt = jwt;
		this.user = user;
	}

	public String getJwt() {
		return jwt;
	}

	public UserDTO getUser() {
		return user;
	}
}
