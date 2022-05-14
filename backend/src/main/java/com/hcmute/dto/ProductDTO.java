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
	private boolean milk;
	private List<CategoryDTO> categories;
	private List<StoreDTO> stores;
	private List<SizeDTO> sizes;
	private List<RateDTO> rates;
	
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
	
	public boolean isMilk() {
		return milk;
	}
	public void setMilk(boolean milk) {
		this.milk = milk;
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
	
	public List<RateDTO> getRates() {
		return rates;
	}
	public void setRates(List<RateDTO> rates) {
		this.rates = rates;
	}
	public void calRateAndNumberReviewers() {
		this.numberReviewers = rates.size();
		if (numberReviewers > 0) {
			int sumRate = 0;
			for (int i = 0; i < rates.size(); i++) {
				sumRate += rates.get(i).getStar();
			}
			this.rate = (float)sumRate / numberReviewers;
		} else {
			this.rate = 0;
		}
	}
	
}
