package com.hcmute.api.response;

import java.util.List;

import com.hcmute.dto.CategoryDTO;

public class CategoryResponse {
	private int page;
	private int size;
	private int totalPage;
	private List<CategoryDTO> categories;
	public CategoryResponse(int page, int size, int totalPage, List<CategoryDTO> categories) {
		super();
		this.page = page;
		this.size = size;
		this.totalPage = totalPage;
		this.categories = categories;
	}
	public CategoryResponse() {
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
	public List<CategoryDTO> getCategories() {
		return categories;
	}
	public void setCategories(List<CategoryDTO> categories) {
		this.categories = categories;
	}
	
	
	
}
