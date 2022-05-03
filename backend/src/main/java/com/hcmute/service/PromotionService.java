package com.hcmute.service;

import java.sql.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;

import com.hcmute.api.response.PromotionResponse;
import com.hcmute.dto.PromotionDTO;

public interface PromotionService {
	PromotionDTO save(PromotionDTO promotionDTO);
	PromotionDTO findOne(Long id);
	PromotionDTO findOneByCode(String code);
	List<PromotionDTO> findAll();
	PromotionResponse findAll(Pageable pageable);
	PromotionResponse findByState(Boolean state, Pageable pageable);
	PromotionResponse findByKeywordAndState(String keyword, Boolean state, Pageable pageable);
	PromotionResponse findByObjectAndKeywordAndState(String object, String keyword, Boolean state, Pageable pageable);
	PromotionResponse findByExpiredAndKeywordAndState(Date date, String keyword,Boolean state, Pageable pageable);
	PromotionResponse findByActiveAndKeywordAndState(Date date, String keyword,Boolean state, Pageable pageable);
	PromotionResponse findByUpcomingAndKeywordAndState(Date date, String keyword,Boolean state, Pageable pageable);
	PromotionResponse findByExpiredAndObjectAndKeywordAndState(Date date, String object, String keyword,Boolean state, Pageable pageable);
	PromotionResponse findByActiveAndObjectAndKeywordAndState(Date date, String object, String keyword,Boolean state, Pageable pageable);
	PromotionResponse findByUpcomingAndObjectAndKeywordAndState(Date date, String object, String keyword,Boolean state, Pageable pageable);
}
