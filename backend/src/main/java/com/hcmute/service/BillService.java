package com.hcmute.service;

import java.sql.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;

import com.hcmute.api.response.BillResponse;
import com.hcmute.dto.BillDTO;

public interface BillService {
	BillDTO save(BillDTO billDTO);
	BillDTO updateStatus(BillDTO billDTO);
	List<BillDTO> findByBetweenDate(Date start, Date end, String status);
	List<BillDTO> findByCustomerId(long customerId);
	BillResponse findByKeywordAndStatus(String keyword, String status, Pageable pageable);
	BillResponse findByStoreIdAndKeywordAndStatus(Long storeId, String keyword, String status, Pageable pageable);
	BillResponse findByModifiedDateAndKeywordAndStatus(Date start, Date end, String keyword, String status, Pageable pageable);
	BillResponse findByModifiedDateAndStoreIdAndKeywordAndStatus(Date start, Date end, Long storeId, String keyword, String status, Pageable pageable);
}
