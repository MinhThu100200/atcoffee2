package com.hcmute.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.hcmute.api.response.NotificationResponse;
import com.hcmute.dto.NotificationDTO;
import com.hcmute.entity.NotificationEntity;
import com.hcmute.repository.NotificationRepository;
import com.hcmute.service.NotificationService;
import com.hcmute.util.ConstantsUtil;

@Service
public class NotificationServiceImpl implements NotificationService {

	@Autowired
	private ModelMapper mapper;
	@Autowired
	private NotificationRepository notificationRepository;
	
	@Override
	public NotificationResponse findByKeyword(String keyword, Pageable pageable) {
		Page<NotificationEntity> page = notificationRepository.findByTitleContainingOrMessageContainingOrderByCreatedDateDesc(keyword, keyword, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public NotificationResponse findByKeywordAndState(String keyword, Boolean state, Pageable pageable) {
		Page<NotificationEntity> page = notificationRepository.findByTitleContainingAndStateOrMessageContainingAndStateOrderByCreatedDateDesc(keyword, state, keyword, state, pageable);
		return resultResponse(page, pageable);
	}

	public NotificationResponse resultResponse(Page<NotificationEntity> page, Pageable pageable) {
		List<NotificationEntity> entities = page.getContent();
		List<NotificationDTO> dtos = new ArrayList<NotificationDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, NotificationDTO.class)));
		NotificationResponse result = new NotificationResponse();
		result.setNotifications(dtos);
		result.setTotalPage(page.getTotalPages());
		result.setSize(page.getSize());
		result.setPage(pageable.getPageNumber());
		return result;
	}

	@Override
	public NotificationDTO save(NotificationDTO notificationDTO) {
		NotificationEntity entity = mapper.map(notificationDTO, NotificationEntity.class);
		
		if ("".equals(entity.getCreator()) || entity.getCreator() == null) {
			entity.setCreator(ConstantsUtil.userDTO.getName());
		}
		
		entity = notificationRepository.save(entity);
		
		if (entity.isState()) {
			entity.setSender(ConstantsUtil.userDTO.getName());
			entity.setSendedDate(entity.getModifiedDate());
		}
		
		entity = notificationRepository.save(entity);
		
		return mapper.map(entity, NotificationDTO.class);
	}

	@Override
	public NotificationDTO findOne(Long id) {
		NotificationEntity entity = notificationRepository.findOne(id);
		return mapper.map(entity, NotificationDTO.class);
	}
}
