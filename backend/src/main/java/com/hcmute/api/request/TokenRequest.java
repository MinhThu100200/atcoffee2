package com.hcmute.api.request;

public class TokenRequest {
	private String token;

	public TokenRequest() {
		super();
	}

	public TokenRequest(String token) {
		super();
		this.token = token;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}
	
}
