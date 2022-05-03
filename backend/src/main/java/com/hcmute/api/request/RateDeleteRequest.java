package com.hcmute.api.request;

import java.util.List;

public class RateDeleteRequest {
	private List<Long> ids;

	public RateDeleteRequest() {
		super();
	}

	public List<Long> getIds() {
		return ids;
	}

	public void setIds(List<Long> ids) {
		this.ids = ids;
	}
}
