package com.hcmute.service;

import org.springframework.data.domain.Pageable;

import com.hcmute.api.response.NotificationResponse;
import com.hcmute.dto.NotificationDTO;

public interface NotificationService {
	NotificationDTO save(NotificationDTO notificationDTO);
	NotificationDTO findOne(Long id);
	NotificationResponse findByKeyword(String keyword, Pageable pageable);
	NotificationResponse findByKeywordAndState(String keyword, Boolean state, Pageable pageable);
}
