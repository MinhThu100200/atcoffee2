package com.hcmute.api.response;

import java.util.List;

public class UtilResponse {
	private int page;
	private int size;
	private int totalPage;
	private List<?> utils;
	
	public UtilResponse() {
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
	public List<?> getUtils() {
		return utils;
	}
	public void setUtils(List<?> utils) {
		this.utils = utils;
	}
	
	
}
