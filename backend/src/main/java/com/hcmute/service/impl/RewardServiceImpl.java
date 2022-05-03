package com.hcmute.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.hcmute.api.response.RewardResponse;
import com.hcmute.dto.RewardDTO;
import com.hcmute.entity.RewardEntity;
import com.hcmute.repository.RewardRepository;
import com.hcmute.service.RewardService;

@Service
public class RewardServiceImpl implements RewardService{

	@Autowired
	private ModelMapper mapper;
	@Autowired
	private RewardRepository rewardRepository;
	
	@Override
	public RewardDTO save(RewardDTO rewardDTO) {
		RewardEntity entity = mapper.map(rewardDTO, RewardEntity.class);
		entity = rewardRepository.save(entity);
		return mapper.map(entity, RewardDTO.class);
	}

	@Override
	public List<RewardDTO> findAll() {
		List<RewardEntity> entities = rewardRepository.findAll();
		List<RewardDTO> dtos = new ArrayList<RewardDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, RewardDTO.class)));
		return dtos;
	}
	
	@Override
	public List<RewardDTO> findByState(Boolean state) {
		List<RewardEntity> entities = rewardRepository.findByState(state);
		List<RewardDTO> dtos = new ArrayList<RewardDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, RewardDTO.class)));
		return dtos;
	}
	
	@Override
	public RewardDTO findOne(Long id) {
		RewardEntity entity = rewardRepository.findOne(id);
		return mapper.map(entity, RewardDTO.class);
	}

	@Override
	public RewardDTO findOneByCode(String code) {
		RewardEntity entity = rewardRepository.findOneByCode(code);
		return mapper.map(entity, RewardDTO.class);
	}

	@Override
	public RewardResponse findAll(Pageable pageable) {
		Page<RewardEntity> page = rewardRepository.findAll(pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public RewardResponse findByKeywordAndState(String keyword, Boolean state, Pageable pageable) {
		Page<RewardEntity> page = rewardRepository.findByKeywordAndState(keyword, state, pageable);
		return resultResponse(page, pageable);
	}
	
	public RewardResponse resultResponse(Page<RewardEntity> page, Pageable pageable) {
		List<RewardEntity> entities = page.getContent();
		List<RewardDTO> dtos = new ArrayList<RewardDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, RewardDTO.class)));
		RewardResponse result = new RewardResponse();
		result.setRewards(dtos);
		result.setTotalPage(page.getTotalPages());
		result.setSize(page.getSize());
		result.setPage(pageable.getPageNumber());
		return result;
	}

}
