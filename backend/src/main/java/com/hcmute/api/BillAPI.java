package com.hcmute.api;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hcmute.api.response.BillResponse;
import com.hcmute.dto.BillDTO;
import com.hcmute.service.BillService;

@RestController
public class BillAPI {
	
	@Autowired
	private BillService billService;
	
	@PostMapping("/api/staff/bill")
	public ResponseEntity<BillDTO> save(@RequestBody BillDTO billDTO) {
		return ResponseEntity.ok(billService.save(billDTO));
	}
	
	@PutMapping(value = "/api/staff/bill", params = "status") 
	public ResponseEntity<BillDTO> updateStatus(@RequestBody BillDTO billDTO) {
		return ResponseEntity.ok(billService.updateStatus(billDTO));
	}
	
	@GetMapping(value = "/api/staff/bill/statistics", params = {"startDate", "endDate"})
	public ResponseEntity<List<BillDTO>> findByDate(@RequestParam(name = "startDate") Date startDate, 
			@RequestParam(name = "endDate") Date endDate,
			@RequestParam(name = "status", required = false, defaultValue = "COMPLETED") String status) {
		return ResponseEntity.ok(billService.findByBetweenDate(startDate, endDate, status));
	}
	
	@GetMapping(value = "/api/admin/bill/statistics", params = {"keyword"})
	public ResponseEntity<BillResponse> findBy(
			@RequestParam(name = "start", required = false, defaultValue = "2000-01-01") Date start,
			@RequestParam(name = "end", required = false, defaultValue = "2200-01-01") Date end,
			@RequestParam(name = "storeId", required = false, defaultValue = "-1") Long storeId, 
			@RequestParam(name = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(name = "status", required = false, defaultValue = "COMPLETED") String status, 
			@RequestParam(name = "page", required = false, defaultValue = "1") int page,
			@RequestParam(name = "size", required = false, defaultValue = "10000") int size) {

		BillResponse result = new BillResponse();
		Pageable pageable = new PageRequest(page - 1, size);
		if (storeId < 0 && start.toString().equals("2000-01-01")) {
			result = billService.findByKeywordAndStatus(keyword, status, pageable);
		} else if (storeId > 0 && start.toString().equals("2000-01-01")){
			result = billService.findByStoreIdAndKeywordAndStatus(storeId, keyword, status, pageable);
		} else if (storeId < 0 && !start.toString().equals("2000-01-01")) {
			result = billService.findByModifiedDateAndKeywordAndStatus(start, end, keyword, status, pageable);
		} else {
			result = billService.findByModifiedDateAndStoreIdAndKeywordAndStatus(start, end, storeId, keyword, status, pageable);
		}
		return ResponseEntity.ok(result);
	}

}
