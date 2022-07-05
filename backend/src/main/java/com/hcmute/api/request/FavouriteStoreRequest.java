package com.hcmute.api.request;

public class FavouriteStoreRequest {
	
	private long customerId;
	private long storeId;
	
	public FavouriteStoreRequest() {
		super();
	}
	
	public FavouriteStoreRequest(long customerId, long storeId) {
		super();
		this.customerId = customerId;
		this.storeId = storeId;
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
	
	
}
