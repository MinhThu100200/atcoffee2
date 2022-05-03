package com.hcmute.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.hcmute.entity.StoreEntity;

public interface StoreRepository extends JpaRepository<StoreEntity, Long>{
	StoreEntity findOneByCode(String code);
	List<StoreEntity> findByState(Boolean state);
	Page<StoreEntity> findByState(Boolean state, Pageable pageable);
	@Query("select s from StoreEntity s where (s.name like %?1% OR s.code LIKE %?1% OR s.address LIKE %?1%) AND s.state = ?2")
	Page<StoreEntity> findByKeywordAndState(String keyword, Boolean state, Pageable pageable);
	@Query("select s from StoreEntity s where (s.name like %?1% OR s.code LIKE %?1% OR s.address LIKE %?1%)")
	Page<StoreEntity> findByKeyword(String keyword, Pageable pageable);
}
