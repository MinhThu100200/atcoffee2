package com.hcmute.api.response;

import java.util.List;

import com.hcmute.dto.ProductDTO;

public class ProductResponse {
	private int page;
	private int size;
	private int totalPage;
	private List<ProductDTO> products;
	public ProductResponse() {
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
	public List<ProductDTO> getProducts() {
		return products;
	}
	public void setProducts(List<ProductDTO> products) {
		this.products = products;
	}
	
}
