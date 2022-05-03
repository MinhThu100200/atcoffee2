package com.hcmute.api.request;

import com.hcmute.dto.UserDTO;

public class PasswordRequest {
	private UserDTO user;
	private String oldPassword;
	private String newPassword;
	
	
	public PasswordRequest() {
		super();
	}
	public PasswordRequest(UserDTO user, String oldPassword, String newPassword) {
		super();
		this.user = user;
		this.oldPassword = oldPassword;
		this.newPassword = newPassword;
	}
	public UserDTO getUser() {
		return user;
	}
	public void setUser(UserDTO user) {
		this.user = user;
	}
	public String getOldPassword() {
		return oldPassword;
	}
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
	public String getNewPassword() {
		return newPassword;
	}
	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((user == null) ? 0 : user.hashCode());
		return result;
	}

}
