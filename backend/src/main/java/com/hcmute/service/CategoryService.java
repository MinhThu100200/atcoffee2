package com.hcmute.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.hcmute.api.response.CategoryResponse;
import com.hcmute.dto.CategoryDTO;

public interface CategoryService {
	CategoryDTO save(CategoryDTO dto);
	CategoryDTO findOne(Long id);
	CategoryDTO findOneByCode(String code);
	List<CategoryDTO> findAll();
	CategoryResponse findAll(Pageable pageable);
	List<CategoryDTO> findByState(Boolean state);
	CategoryResponse findByState(Boolean state, Pageable pageable);
	CategoryResponse findByKeywordAndState(String keyword, Boolean state, Pageable pageable);
	CategoryResponse findByKeyword(String keyword, Pageable pageable);
}
