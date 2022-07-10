package com.hcmute.api;

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
import com.hcmute.api.response.NotificationResponse;
import com.hcmute.dto.NotificationDTO;
import com.hcmute.service.NotificationService;

@RestController
public class NotificationAPI {
	
	@Autowired
	private Cloudinary cloudinary;
	@Autowired
	private ObjectMapper objectMapper;
	@Autowired
	private NotificationService notificationService;
	
	@PostMapping("/api/staff/notification")
	public ResponseEntity<NotificationDTO> save(@RequestParam(value="file", required=false) MultipartFile multipartFile, @RequestParam("notification") String notificationJson){
		try {
			NotificationDTO dto = objectMapper.readValue(notificationJson, NotificationDTO.class);	
			if (multipartFile != null) {
				@SuppressWarnings("rawtypes")
				Map r = this.cloudinary.uploader().upload(multipartFile.getBytes(),
		                  ObjectUtils.asMap("resource_type", "auto"));
				String img = (String) r.get("secure_url");
				dto.setImage(img);
			}
			return ResponseEntity.ok(notificationService.save(dto));
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}
	}
	
	
	@GetMapping("/api/staff/notification/{id}")
	public ResponseEntity<NotificationDTO>findOne(@PathVariable(name = "id") Long id) {
		return ResponseEntity.ok(notificationService.findOne(id));
	}
	
	@GetMapping("/api/staff/notification") 
	public ResponseEntity<NotificationResponse> findAll(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "10000") int size, 
			@RequestParam(name = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(name = "state", required = false, defaultValue = "") Boolean state,
			@RequestParam(name = "searchState", required = false, defaultValue = "false") Boolean searchState) {
		
		NotificationResponse result  = new NotificationResponse();
		Pageable pageable = new PageRequest(page - 1, size);
		if (searchState == false) {
			result = notificationService.findByKeyword(keyword, pageable);
		} else {
			result = notificationService.findByKeywordAndState(keyword, state, pageable);
		}
		return ResponseEntity.ok(result);
	}
}
