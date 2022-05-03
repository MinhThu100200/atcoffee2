package com.hcmute.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.hcmute.api.response.RateResponse;
import com.hcmute.dto.RateDTO;

public interface RateService {
	
	RateDTO save(RateDTO rateDTO);
	List<RateDTO> findAll();
	List<RateDTO> findByProductId(Long productId);
	List<RateDTO> findByUserId(Long userId);
	RateDTO findByProductIdAndUserId(Long productId, Long userId);
	RateDTO findOne(Long id);
	RateResponse findAll(Pageable pageable);
	RateResponse findByProductId(Long productId, Pageable pageable);
	RateResponse findByUserId(Long userId, Pageable pageable);
	RateResponse findByProductIdAndUserId(Long productId, Long userId, Pageable pageable);
}
