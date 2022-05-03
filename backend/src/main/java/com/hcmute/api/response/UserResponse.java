package com.hcmute.api.response;

import java.util.List;

import com.hcmute.dto.UserDTO;

public class UserResponse {
	private int page;
	private int size;
	private int totalPage;
	private List<UserDTO> users;
	public UserResponse() {
		super();
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public List<UserDTO> getUsers() {
		return users;
	}
	public void setUsers(List<UserDTO> users) {
		this.users = users;
	}
	
}
