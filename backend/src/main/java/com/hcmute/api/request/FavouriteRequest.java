package com.hcmute.api.request;

public class FavouriteRequest {
	
	private long customerId;
	private long productId;
	
	public FavouriteRequest() {
		super();
	}
	
	public FavouriteRequest(long customerId, long productId) {
		super();
		this.customerId = customerId;
		this.productId = productId;
	}


	public long getCustomerId() {
		return customerId;
	}

	public void setCustomerId(long customerId) {
		this.customerId = customerId;
	}

	public long getProductId() {
		return productId;
	}

	public void setProductId(long productId) {
		this.productId = productId;
	}
	
	
}
