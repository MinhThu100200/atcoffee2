package com.hcmute.api;

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

import com.hcmute.api.response.RateResponse;
import com.hcmute.dto.RateDTO;
import com.hcmute.service.RateService;

@RestController
public class RateAPI {
	
	@Autowired
	private RateService rateService;
	
	@PostMapping("/api/user/rate")
	public ResponseEntity<RateDTO> save(@RequestBody RateDTO rateDTO) {
		rateDTO.setState(true);
		return ResponseEntity.ok(rateService.save(rateDTO));
	}
	
	@PutMapping("/api/user/rate")
	public ResponseEntity<RateDTO> update(@RequestBody RateDTO rateDTO) {
		return ResponseEntity.ok(rateService.save(rateDTO));
	}
			
	@GetMapping("/api/info/rate")
	public ResponseEntity<List<RateDTO>> findAll() {
		return ResponseEntity.ok(rateService.findAll());
	}

	@GetMapping(value = "/api/info/rate", params = "productId")
	public ResponseEntity<List<RateDTO>> findByProductId(@RequestParam(name = "productId") Long productId) {
		return ResponseEntity.ok(rateService.findByProductId(productId));
	}
	
	@GetMapping(value = "/api/info/rate", params = "userId")
	public ResponseEntity<List<RateDTO>> findByUserId(@RequestParam(name = "userId") Long userId) {
		return ResponseEntity.ok(rateService.findByUserId(userId));
	}
		
	@GetMapping(value = "/api/info/rate", params = {"productId", "userId"})
	public ResponseEntity<RateDTO> findByProductIdAndUserId(@RequestParam(name = "productId") Long productId,
			@RequestParam(name = "userId") Long userId) {
		return ResponseEntity.ok(rateService.findByProductIdAndUserId(productId, userId));
	}
	
	@GetMapping(value = "/api/staff/rate", params = "productId")
	public ResponseEntity<RateResponse> findByProductId(@RequestParam(name = "productId") Long productId,
			@RequestParam(name = "page", required = false, defaultValue = "1") int page,
			@RequestParam(name = "size",required = false, defaultValue = "10000") int size) {
			Pageable pageable = new PageRequest(page - 1, size);
		return ResponseEntity.ok(rateService.findByProductId(productId, pageable));
	}
	
	@GetMapping(value = "/api/staff/rate", params = "userId")
	public ResponseEntity<RateResponse> findByUserId(@RequestParam(name = "userId") Long userId,
		@RequestParam(name = "page", required = false, defaultValue = "1") int page,
		@RequestParam(name = "size",required = false, defaultValue = "10000") int size) {
		Pageable pageable = new PageRequest(page - 1, size);
		return ResponseEntity.ok(rateService.findByUserId(userId, pageable));
	}
		
	@GetMapping(value = "/api/staff/rate", params = {"productId", "userId"})
	public ResponseEntity<RateResponse> findByProductIdAndUserId(@RequestParam(name = "productId") Long productId,
			@RequestParam(name = "userId") Long userId,
			@RequestParam(name = "page", required = false, defaultValue = "1") int page,
			@RequestParam(name = "size",required = false, defaultValue = "10000") int size) {
			Pageable pageable = new PageRequest(page - 1, size);
		return ResponseEntity.ok(rateService.findByProductIdAndUserId(productId, userId, pageable));
	}
	
	@GetMapping(value = "/api/admin/rate")
	public ResponseEntity<RateResponse> findAll(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
			@RequestParam(name = "size",required = false, defaultValue = "10000") int size) {
		Pageable pageable = new PageRequest(page - 1, size);
		return ResponseEntity.ok(rateService.findAll(pageable));
	}
}
