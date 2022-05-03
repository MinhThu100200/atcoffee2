package com.hcmute.api;

import java.sql.Date;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hcmute.api.response.PromotionResponse;
import com.hcmute.dto.PromotionDTO;
import com.hcmute.service.PromotionService;

@RestController
public class PromotionAPI {
	
	@Autowired
	private PromotionService promotionService;
	@Autowired
	private Cloudinary cloudinary;
	@Autowired
	private ObjectMapper objectMapper;
	
	@PostMapping("/api/admin/promotion")
	public ResponseEntity<PromotionDTO> save(@RequestParam(value="file", required=false) MultipartFile multipartFile, @RequestParam("promotion") String promotionJson) {
		
		try {
			PromotionDTO promotion = objectMapper.readValue(promotionJson, PromotionDTO.class);	
			if (multipartFile != null) {
				@SuppressWarnings("rawtypes")
				Map r = this.cloudinary.uploader().upload(multipartFile.getBytes(),
		                  ObjectUtils.asMap("resource_type", "auto"));
				String img = (String) r.get("secure_url");
				promotion.setImage(img);
			}
			promotion = promotionService.save(promotion);
			return ResponseEntity.ok(promotion);
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}
	}
	
	@GetMapping("/api/info/promotion/{id}")
	public ResponseEntity<PromotionDTO>findOne(@PathVariable(name = "id") Long id) {
		return ResponseEntity.ok(promotionService.findOne(id));
	}
	
	@SuppressWarnings("deprecation")
	@GetMapping(value = "/api/info/promotion", params = {"page", "size"})
	public ResponseEntity<PromotionResponse>findAll(
			@RequestParam (name = "page", defaultValue = "1", required = false) int page,
			@RequestParam(name = "size", defaultValue = "10000", required = false) int size, 
			@RequestParam(name = "state", required = false) String state,
			@RequestParam(name = "object", required = false) String object, 
			@RequestParam(name = "keyword", required = false) String keyword) {
		PromotionResponse result = new PromotionResponse();
		Pageable pageable = new PageRequest(page - 1, size);
		if (state == "" && object == "" && keyword == "") {
			result = promotionService.findByState(true, pageable);
		} else {
			Date date = new Date(Calendar.getInstance().getTime().getTime());
			date = new Date(date.getYear(), date.getMonth(), date.getDate());
			if (state != "" && object != "") {
				if (state.equals("expired")) {
					result = promotionService.findByExpiredAndObjectAndKeywordAndState(date, object, keyword, true, pageable);
				} else if (state.equals("active")){
					result = promotionService.findByActiveAndObjectAndKeywordAndState(date, object, keyword, true, pageable);
				} else {
					result = promotionService.findByUpcomingAndObjectAndKeywordAndState(date, object, keyword, true, pageable);
				}
			} else if (state != ""){
				if (state.equals("expired")) {
					result = promotionService.findByExpiredAndKeywordAndState(date, keyword, true, pageable);
				} else if (state.equals("active")){
					result = promotionService.findByActiveAndKeywordAndState(date, keyword, true, pageable);
				} else {
					result = promotionService.findByUpcomingAndKeywordAndState(date, keyword, true, pageable);
				}
			} else if (object != "") {
				result = promotionService.findByObjectAndKeywordAndState(object, keyword, true, pageable);
			} else {
				result = promotionService.findByKeywordAndState(keyword, true, pageable);
			}
		}
		return ResponseEntity.ok(result);
	}
	
	@GetMapping(value = "/api/info/promotion", params = {"code"})
	public ResponseEntity<PromotionDTO>findOneByCode(@RequestParam (name = "code") String code) {
		return ResponseEntity.ok(promotionService.findOneByCode(code));
	}
	
	@GetMapping(value = "/api/info/promotion", params = "list")
	public ResponseEntity<List<PromotionDTO>>findAll() {
		return ResponseEntity.ok(promotionService.findAll());
	}
}
