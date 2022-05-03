package com.hcmute.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.hcmute.api.response.CategoryResponse;
import com.hcmute.dto.CategoryDTO;
import com.hcmute.entity.CategoryEntity;
import com.hcmute.repository.CategoryRepository;
import com.hcmute.service.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService{
	@Autowired
	private ModelMapper mapper;
	@Autowired
	private CategoryRepository categoryRepository;
	
	@Override
	public CategoryDTO save(CategoryDTO dto) {
		CategoryEntity entity = mapper.map(dto, CategoryEntity.class);
		if (entity.getId() != null) {
			CategoryEntity entityPre = categoryRepository.findOne(entity.getId());
			entity.setProducts(entityPre.getProducts());
		}
		entity = categoryRepository.save(entity);
		return mapper.map(entity, CategoryDTO.class);
	}

	@Override
	public CategoryDTO findOne(Long id) {
		return mapper.map(categoryRepository.findOne(id), CategoryDTO.class);
	}
	
	@Override
	public CategoryDTO findOneByCode(String code) {
		return mapper.map(categoryRepository.findOneByCode(code), CategoryDTO.class);
	}

	@Override
	public List<CategoryDTO> findAll() {
		List<CategoryDTO> dtos = new ArrayList<CategoryDTO>();
		List<CategoryEntity> entities = categoryRepository.findAll();
		entities.forEach(entity -> dtos.add(mapper.map(entity, CategoryDTO.class)));
		return dtos;
	}
	
	@Override
	public List<CategoryDTO> findByState(Boolean state) {
		List<CategoryDTO> dtos = new ArrayList<CategoryDTO>();
		List<CategoryEntity> entities = categoryRepository.findByState(state);
		entities.forEach(entity -> dtos.add(mapper.map(entity, CategoryDTO.class)));
		return dtos;
	}
	
	@Override
	public CategoryResponse findAll(Pageable pageable) {
		Page<CategoryEntity> page = categoryRepository.findAll(pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public CategoryResponse findByState(Boolean state, Pageable pageable) {
		Page<CategoryEntity> page = categoryRepository.findByState(state, pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public CategoryResponse findByKeywordAndState(String keyword, Boolean state, Pageable pageable) {
		Page<CategoryEntity> page = categoryRepository.findByKeywordAndState(keyword, state, pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public CategoryResponse findByKeyword(String keyword, Pageable pageable) {
		Page<CategoryEntity> page = categoryRepository.findByKeyword(keyword, pageable);
		return resultResponse(page, pageable);
	}
	
	public CategoryResponse resultResponse(Page<CategoryEntity> page, Pageable pageable) {
		List<CategoryEntity> entities = page.getContent();
		List<CategoryDTO> dtos = new ArrayList<CategoryDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, CategoryDTO.class)));
		CategoryResponse result = new CategoryResponse();
		result.setCategories(dtos);
		result.setTotalPage(page.getTotalPages());
		result.setSize(page.getSize());
		result.setPage(pageable.getPageNumber());
		return result;
	}

}
