package com.hcmute.dto;

public class CartDTO extends BaseDTO<CartDTO>{
	private int quantity;
	private String description;
	private String size;
	private long productId;
	private long customerId;
	private long storeId;
	private ProductDTO product;
	
	public CartDTO() {
		super();
	}
	public CartDTO(int quantity, String description, long productId, long customerId, long storeId, ProductDTO product) {
		super();
		this.quantity = quantity;
		this.description = description;
		this.productId = productId;
		this.customerId = customerId;
		this.storeId = storeId;
		this.product = product;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public long getProductId() {
		return productId;
	}
	public void setProductId(long productId) {
		this.productId = productId;
	}
	public long getCustomerId() {
		return customerId;
	}
	public void setCustomerId(long customerId) {
		this.customerId = customerId;
	}
	public long getStoreId() {
		return storeId;
	}
	public void setStoreId(long storeId) {
		this.storeId = storeId;
	}
	public ProductDTO getProduct() {
		return product;
	}
	public void setProduct(ProductDTO product) {
		this.product = product;
	}
}
