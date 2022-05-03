package com.hcmute.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hcmute.api.response.CategoryResponse;
import com.hcmute.dto.CategoryDTO;
import com.hcmute.service.CategoryService;

@RestController
public class CategoryAPI {
	
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private ObjectMapper objectMapper;
	
	@PostMapping("/api/admin/category")
	public ResponseEntity<CategoryDTO> save(@RequestParam("category") String categoryJson){
		try {
			CategoryDTO categoryDTO = objectMapper.readValue(categoryJson, CategoryDTO.class);	
			return ResponseEntity.ok(categoryService.save(categoryDTO));
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}
	}
	
	@PutMapping("/api/admin/category")
	public ResponseEntity<CategoryDTO> update(CategoryDTO category) {
		CategoryDTO dto = categoryService.save(category);
		return ResponseEntity.ok(dto);
	}
	
	@GetMapping("/api/info/category/{id}")
	public ResponseEntity<CategoryDTO> findOne(@PathVariable(name = "id") Long id) {
		CategoryDTO dto = categoryService.findOne(id);
		return ResponseEntity.ok(dto);
	}
	
	@RequestMapping(value = "/api/info/category", params = "code", method = RequestMethod.GET)
	public ResponseEntity<CategoryDTO> findBy(@RequestParam(name = "code", required = false) String code){
		return ResponseEntity.ok(categoryService.findOneByCode(code));
	}
	
	@GetMapping(value = "/api/info/category", params = "list")
	public ResponseEntity<List<CategoryDTO>> findAll() {
		List<CategoryDTO> dtos = categoryService.findByState(true);
		return ResponseEntity.ok(dtos);
	}
	
	@GetMapping(value = "/api/info/category", params = {"page", "size"})
	public ResponseEntity<CategoryResponse> findAll(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "10000", required = false) int size, 
			@RequestParam(name = "keyword", defaultValue = "", required = false) String keyword,
			@RequestParam(name = "state", defaultValue = "true", required = false) Boolean state){
		Pageable pageable = new PageRequest(page - 1, size);
		return ResponseEntity.ok(categoryService.findByKeywordAndState(keyword, state, pageable));
	}
	
	@GetMapping(value = "/api/staff/category", params = {"page", "size"})
	public ResponseEntity<CategoryResponse> findAllWithStaff(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "10000", required = false) int size, 
			@RequestParam(name = "keyword", defaultValue = "", required = false) String keyword){
		Pageable pageable = new PageRequest(page - 1, size);
		return ResponseEntity.ok(categoryService.findByKeyword(keyword, pageable));
	}
	
}
