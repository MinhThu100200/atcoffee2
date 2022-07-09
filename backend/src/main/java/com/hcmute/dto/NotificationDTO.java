package com.hcmute.dto;

import java.util.Date;

public class NotificationDTO  extends BaseDTO<PaymentDTO> {
	
	private String title;
	private String message;
	private String image;
	private String creator;
	private String sender;
	private Date sendedDate;
	public NotificationDTO() {
		super();
	}
	public NotificationDTO(String title, String message, String image, Date sendedDate) {
		super();
		this.title = title;
		this.message = message;
		this.image = image;
		this.sendedDate = sendedDate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
	public Date getSendedDate() {
		return sendedDate;
	}
	public void setSendedDate(Date sendedDate) {
		this.sendedDate = sendedDate;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
}
