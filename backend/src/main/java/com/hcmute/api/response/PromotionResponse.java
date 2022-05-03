package com.hcmute.api.response;

import java.util.List;

import com.hcmute.dto.PromotionDTO;

public class PromotionResponse {
	private int page;
	private int size;
	private int totalPage;
	private List<PromotionDTO> promotions;
	
	public PromotionResponse() {
		super();
	}
	public PromotionResponse(int page, int size, int totalPage, List<PromotionDTO> promotions) {
		super();
		this.page = page;
		this.size = size;
		this.totalPage = totalPage;
		this.promotions = promotions;
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
	public List<PromotionDTO> getPromotions() {
		return promotions;
	}
	public void setPromotions(List<PromotionDTO> promotions) {
		this.promotions = promotions;
	}
	
	
}
