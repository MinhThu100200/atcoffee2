package com.hcmute.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.hcmute.api.response.RateResponse;
import com.hcmute.dto.RateDTO;
import com.hcmute.entity.ProductEntity;
import com.hcmute.entity.RateEntity;
import com.hcmute.entity.UserEntity;
import com.hcmute.repository.ProductRepository;
import com.hcmute.repository.RateRepository;
import com.hcmute.repository.UserRepository;
import com.hcmute.service.RateService;

@Service
public class RateServiceImpl implements RateService{

	@Autowired
	private ModelMapper mapper;
	@Autowired
	private RateRepository rateRepository;
	@Autowired
	private ProductRepository productRepository;
	@Autowired
	private UserRepository userRepository;
	
	@Override
	public RateDTO save(RateDTO rateDTO) {
		RateEntity entity = mapper.map(rateDTO, RateEntity.class);
		ProductEntity product = productRepository.findOne(rateDTO.getProductId());
		UserEntity user = userRepository.findOne(rateDTO.getUserId());
		entity.setProduct(product);
		entity.setUser(user);
		entity = rateRepository.save(entity);
		return mapper.map(entity, RateDTO.class);
	}
	
	@Override
	public List<RateDTO> findAll() {
		List<RateEntity> entities = rateRepository.findAll();
		List<RateDTO> dtos = new ArrayList<RateDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, RateDTO.class)));
		return dtos;
	}
	
	@Override
	public List<RateDTO> findByProductId(Long productId) {
		ProductEntity product = productRepository.findOne(productId);
		List<RateEntity> entities = rateRepository.findByProduct(product);
		List<RateDTO> dtos = new ArrayList<RateDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, RateDTO.class)));
		return dtos;
	}

	@Override
	public List<RateDTO> findByUserId(Long userId) {
		UserEntity user = userRepository.findOne(userId);
		List<RateEntity> entities = rateRepository.findByUser(user);
		List<RateDTO> dtos = new ArrayList<RateDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, RateDTO.class)));
		return dtos;
	}

	
	@Override
	public RateDTO findByProductIdAndUserId(Long productId, Long userId) {
		ProductEntity product = productRepository.findOne(productId);
		UserEntity user = userRepository.findOne(userId);
		RateEntity entity = rateRepository.findOneByProductAndUser(product, user);
		return mapper.map(entity, RateDTO.class);
	}

	@Override
	public RateDTO findOne(Long id) {
		RateEntity entity = rateRepository.findOne(id);
		return mapper.map(entity, RateDTO.class);
	}

	@Override
	public RateResponse findAll(Pageable pageable) {
		Page<RateEntity> page = rateRepository.findAll(pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public RateResponse findByProductId(Long productId, Pageable pageable) {
		ProductEntity product = productRepository.findOne(productId);
		Page<RateEntity> page = rateRepository.findByProduct(product, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public RateResponse findByUserId(Long userId, Pageable pageable) {
		UserEntity user = userRepository.findOne(userId);
		Page<RateEntity> page = rateRepository.findByUser(user, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public RateResponse findByProductIdAndUserId(Long productId, Long userId, Pageable pageable) {
		ProductEntity product = productRepository.findOne(productId);
		UserEntity user = userRepository.findOne(userId);
		Page<RateEntity> page = rateRepository.findByProductAndUser(product, user, pageable);
		return resultResponse(page, pageable);
	}
	
	public RateResponse resultResponse(Page<RateEntity> page, Pageable pageable) {
		List<RateEntity> entities = page.getContent();
		List<RateDTO> dtos = new ArrayList<RateDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, RateDTO.class)));
		RateResponse result = new RateResponse();
		result.setRates(dtos);
		result.setTotalPage(page.getTotalPages());
		result.setSize(page.getSize());
		result.setPage(pageable.getPageNumber());
		return result;
	}

}
