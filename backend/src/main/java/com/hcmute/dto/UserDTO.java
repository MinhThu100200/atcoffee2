package com.hcmute.dto;

import java.util.Date;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.web.multipart.MultipartFile;

public class UserDTO extends BaseDTO<UserDTO>{
	private String username; 
	private String password;
	private String image;
	private MultipartFile file;
	private String name;
	private String phone;
	private String gender;
	private String email;
	private String address;
	private String token;
	//Staff 
	@Temporal(TemporalType.TIMESTAMP)
	private Date dob;
	private String identityCard;
	private Long storeId;
//	Customer
	private int accumulatedPoints;
	private int currentPoints;
	private Long typeId;
	
	private String roleName;
	
	public UserDTO() {
		super();
	}
	public UserDTO(String username, String password, String image, String name, String phone, String gender,
			String email, String address, Date dob, String indentityCard, Long storeId, String roleName) {
		super();
		this.username = username;
		this.password = password;
		this.image = image;
		this.name = name;
		this.phone = phone;
		this.gender = gender;
		this.email = email;
		this.address = address;
		this.dob = dob;
		this.identityCard = indentityCard;
		this.storeId = storeId;
		this.roleName = roleName;
		setState(true);
	}
	public UserDTO(String username, String password, String image, String name, String phone, String gender,
			String email, String address, int accumulatedPoints, int currentPoints,  Long typeId, String roleName) {
		super();
		this.username = username;
		this.password = password;
		this.image = image;
		this.name = name;
		this.phone = phone;
		this.gender = gender;
		this.email = email;
		this.address = address;
		this.accumulatedPoints = accumulatedPoints;
		this.currentPoints = currentPoints;
		this.typeId = typeId;
		this.roleName = roleName;
		setState(true);
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getDob() {
		return dob;
	}
	public void setDob(Date dob) {
		this.dob = dob;
	}
	public String getIdentityCard() {
		return identityCard;
	}
	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}
	
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public Long getStoreId() {
		return storeId;
	}
	public void setStoreId(Long storeId) {
		this.storeId = storeId;
	}
	public int getAccumulatedPoints() {
		return accumulatedPoints;
	}
	public void setAccumulatedPoints(int accumulatedPoints) {
		this.accumulatedPoints = accumulatedPoints;
	}
	public int getCurrentPoints() {
		return currentPoints;
	}
	public void setCurrentPoints(int currentPoints) {
		this.currentPoints = currentPoints;
	}

	public Long getTypeId() {
		return typeId;
	}
	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	
}
