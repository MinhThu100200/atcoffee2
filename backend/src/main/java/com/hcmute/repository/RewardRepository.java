package com.hcmute.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.hcmute.entity.RewardEntity;

public interface RewardRepository extends JpaRepository<RewardEntity, Long>{
	RewardEntity findOneByCode(String code);
	@Query("select r from RewardEntity r where (r.name like %?1% OR r.code LIKE %?1%) AND r.state = ?2")
	Page<RewardEntity>findByKeywordAndState(String keyword, Boolean state, Pageable pageable);
	List<RewardEntity> findByState(Boolean state);
}
