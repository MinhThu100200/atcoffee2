package com.hcmute.api.response;

import java.util.List;

import com.hcmute.dto.CartDTO;

public class CartResponse {
	private int page;
	private int size;
	private int totalPage;
	private List<CartDTO> carts;
	public CartResponse(int page, int size, int totalPage, List<CartDTO> carts) {
		super();
		this.page = page;
		this.size = size;
		this.totalPage = totalPage;
		this.carts = carts;
	}
	public CartResponse() {
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
	public List<CartDTO> getCarts() {
		return carts;
	}
	public void setCarts(List<CartDTO> carts) {
		this.carts = carts;
	}
}
