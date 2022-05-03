package com.hcmute.dto;

import java.util.List;

import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

public class ProductDTO extends BaseDTO<ProductDTO>{
	private String name;
	private String image;
	@Transient
	private MultipartFile file;
	private String description; 
	private int discount;
	private float rate;
	private int numberReviewers;
	private List<CategoryDTO> categories;
	private List<StoreDTO> stores;
	private List<SizeDTO> sizes;
	
	public ProductDTO() {
		super();
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public float getRate() {
		return rate;
	}
	public void setRate(float rate) {
		this.rate = rate;
	}
	public int getNumberReviewers() {
		return numberReviewers;
	}
	public void setNumberReviewers(int numberReviewers) {
		this.numberReviewers = numberReviewers;
	}
	public List<CategoryDTO> getCategories() {
		return categories;
	}
	public void setCategories(List<CategoryDTO> categories) {
		this.categories = categories;
	}
	public List<StoreDTO> getStores() {
		return stores;
	}
	public void setStores(List<StoreDTO> stores) {
		this.stores = stores;
	}
	public List<SizeDTO> getSizes() {
		return sizes;
	}
	public void setSizes(List<SizeDTO> sizes) {
		this.sizes = sizes;
	}
	
}
