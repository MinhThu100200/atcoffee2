package com.hcmute.service.impl;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.hcmute.api.response.PromotionResponse;
import com.hcmute.dto.PromotionDTO;
import com.hcmute.entity.PromotionEntity;
import com.hcmute.repository.PromotionRepository;
import com.hcmute.service.PromotionService;

@Service
public class PromotionServiceImpl implements PromotionService{

	@Autowired
	private ModelMapper mapper;
	@Autowired
	private PromotionRepository promotionRepository;
	
	@Override
	public PromotionDTO save(PromotionDTO promotionDTO) {
		PromotionEntity entity = mapper.map(promotionDTO, PromotionEntity.class);
		if (entity.getId() == null) {
			entity.setState(true);
		}
		entity = promotionRepository.save(entity);
		return mapper.map(entity, PromotionDTO.class);
	}

	@Override
	public PromotionDTO findOne(Long id) {
		return mapper.map(promotionRepository.findOne(id), PromotionDTO.class);
	}
	
	@Override
	public PromotionDTO findOneByCode(String code) {
		return mapper.map(promotionRepository.findOneByCode(code), PromotionDTO.class);
	}

	@Override
	public List<PromotionDTO> findAll() {
		List<PromotionEntity> entities = promotionRepository.findAll();
		List<PromotionDTO> dtos = new ArrayList<PromotionDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, PromotionDTO.class)));
		return dtos;
	}

	@Override
	public PromotionResponse findAll(Pageable pageable) {
		Page<PromotionEntity> page = promotionRepository.findAll(pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public PromotionResponse findByState(Boolean state, Pageable pageable) {
		Page<PromotionEntity> page = promotionRepository.findByState(state, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public PromotionResponse findByKeywordAndState(String keyword, Boolean state,
			Pageable pageable) {
		Page<PromotionEntity> page = promotionRepository.findByKeywordAndState(keyword, state, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public PromotionResponse findByObjectAndKeywordAndState(String object, String keyword, Boolean state, Pageable pageable) {
		Page<PromotionEntity> page = promotionRepository.findByObjectAndKeywordAndState(object, keyword, state, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public PromotionResponse findByExpiredAndKeywordAndState(Date date, String keyword, Boolean state, Pageable pageable) {
		Page<PromotionEntity> page = promotionRepository.findByExpiredAndKeywordAndState(date, keyword, state, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public PromotionResponse findByActiveAndKeywordAndState(Date date, String keyword, Boolean state, Pageable pageable) {
		Page<PromotionEntity> page = promotionRepository.findByActiveAndKeywordAndState(date, keyword, state, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public PromotionResponse findByUpcomingAndKeywordAndState(Date date, String keyword, Boolean state, Pageable pageable) {
		Page<PromotionEntity> page = promotionRepository.findByUpcomingAndKeywordAndState(date, keyword, state, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public PromotionResponse findByExpiredAndObjectAndKeywordAndState(Date date, String object, String keyword, Boolean state,
			Pageable pageable) {
		Page<PromotionEntity> page = promotionRepository.findByExpiredAndObjectAndKeywordAndState(date, object, keyword, state, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public PromotionResponse findByActiveAndObjectAndKeywordAndState(Date date, String object, String keyword, Boolean state, Pageable pageable) {
		Page<PromotionEntity> page = promotionRepository.findByActiveAndObjectAndKeywordAndState(date, object, keyword, state, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public PromotionResponse findByUpcomingAndObjectAndKeywordAndState(Date date, String object, String keyword, Boolean state,
			Pageable pageable) {
		Page<PromotionEntity> page = promotionRepository.findByUpcomingAndObjectAndKeywordAndState(date, object, keyword, state, pageable);
		return resultResponse(page, pageable);
	}
	
	public PromotionResponse resultResponse(Page<PromotionEntity> page, Pageable pageable) {
		List<PromotionEntity> entities = page.getContent();
		List<PromotionDTO> dtos = new ArrayList<PromotionDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, PromotionDTO.class)));
		PromotionResponse result = new PromotionResponse();
		result.setPromotions(dtos);
		result.setTotalPage(page.getTotalPages());
		result.setSize(page.getSize());
		result.setPage(pageable.getPageNumber());
		return result;
	}

}
