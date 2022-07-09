package com.hcmute.api.response;

import java.util.List;

import com.hcmute.dto.NotificationDTO;

public class NotificationResponse {
	private int page;
	private int size;
	private int totalPage;
	private List<NotificationDTO> notifications;
	public NotificationResponse() {
		super();
	}
	public NotificationResponse(int page, int size, int totalPage, List<NotificationDTO> notifications) {
		super();
		this.page = page;
		this.size = size;
		this.totalPage = totalPage;
		this.notifications = notifications;
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
	public List<NotificationDTO> getNotifications() {
		return notifications;
	}
	public void setNotifications(List<NotificationDTO> notifications) {
		this.notifications = notifications;
	}
	
	
}
