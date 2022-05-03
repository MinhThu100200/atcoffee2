package com.hcmute.api.response;

import java.util.List;

import com.hcmute.dto.RewardDTO;

public class RewardResponse {
	private int page;
	private int size;
	private int totalPage;
	private List<RewardDTO> rewards;
	public RewardResponse(int page, int size, int totalPage, List<RewardDTO> rewards) {
		super();
		this.page = page;
		this.size = size;
		this.totalPage = totalPage;
		this.rewards = rewards;
	}
	public RewardResponse() {
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
	public List<RewardDTO> getRewards() {
		return rewards;
	}
	public void setRewards(List<RewardDTO> rewards) {
		this.rewards = rewards;
	}
}
