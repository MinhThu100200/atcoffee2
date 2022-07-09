package com.hcmute.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.hcmute.entity.NotificationEntity;

public interface NotificationRepository extends JpaRepository<NotificationEntity, Long>{
	Page<NotificationEntity> findByState(Boolean state, Pageable pageable);
	Page<NotificationEntity> findByTitleContainingOrMessageContaining(String title, String message, Pageable pageable);
	Page<NotificationEntity> findByTitleContainingOrMessageContainingAndState(String title, String message, Boolean state, Pageable pageable);
}
