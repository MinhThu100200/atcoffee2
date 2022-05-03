package com.hcmute.api.response;

import java.util.List;

import com.hcmute.dto.RateDTO;

public class RateResponse {
	private int page;
	private int size;
	private int totalPage;
	private List<RateDTO> rates;
	
	public RateResponse() {
		super();
	}

	public RateResponse(int page, int size, int totalPage, List<RateDTO> rates) {
		super();
		this.page = page;
		this.size = size;
		this.totalPage = totalPage;
		this.rates = rates;
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
	public List<RateDTO> getRates() {
		return rates;
	}
	public void setRates(List<RateDTO> rates) {
		this.rates = rates;
	}
	
	
}
