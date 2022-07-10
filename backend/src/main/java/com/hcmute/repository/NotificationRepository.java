package com.hcmute.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.hcmute.entity.NotificationEntity;

public interface NotificationRepository extends JpaRepository<NotificationEntity, Long>{
	Page<NotificationEntity> findByStateOrderByCreatedDateDesc(Boolean state, Pageable pageable);
	Page<NotificationEntity> findByTitleContainingOrMessageContainingOrderByCreatedDateDesc(String title, String message, Pageable pageable);
	Page<NotificationEntity> findByTitleContainingAndStateOrMessageContainingAndStateOrderByCreatedDateDesc(String title, Boolean state1, String message, Boolean state2, Pageable pageable);
}
