package com.hcmute.entity;

import static javax.persistence.TemporalType.TIMESTAMP;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;

@Entity
@Table(name = "notification")
public class NotificationEntity extends BaseEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String title;
	private String message;
	private String image;
	private String creator;
	private String sender;
	@Temporal(TIMESTAMP)
	private Date sendedDate;
	
	public NotificationEntity() {
		super();
	}
	public NotificationEntity(String title, String message, String image) {
		super();
		this.title = title;
		this.message = message;
		this.image = image;
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
