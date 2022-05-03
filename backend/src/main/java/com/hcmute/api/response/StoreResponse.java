package com.hcmute.api.response;

import java.util.List;

import com.hcmute.dto.StoreDTO;

public class StoreResponse {
	private int page;
	private int size;
	private int totalPage;
	private List<StoreDTO> stores;
	
	
	public StoreResponse() {
		super();
	}
	public StoreResponse(int page, int size, int totalPage, List<StoreDTO> stores) {
		super();
		this.page = page;
		this.size = size;
		this.totalPage = totalPage;
		this.stores = stores;
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
	public List<StoreDTO> getStores() {
		return stores;
	}
	public void setStores(List<StoreDTO> stores) {
		this.stores = stores;
	}
	
	
}
