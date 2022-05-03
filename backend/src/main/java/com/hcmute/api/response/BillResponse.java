package com.hcmute.api.response;

import java.util.List;

import com.hcmute.dto.BillDTO;

public class BillResponse {
	
	private int page;
	private int size;
	private int totalPage;
	private List<BillDTO> bills;
	public BillResponse() {
		super();
	}
	public BillResponse(int page, int size, int totalPage, List<BillDTO> bills) {
		super();
		this.page = page;
		this.size = size;
		this.totalPage = totalPage;
		this.bills = bills;
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
	public List<BillDTO> getBills() {
		return bills;
	}
	public void setBills(List<BillDTO> bills) {
		this.bills = bills;
	}
	
	
}
