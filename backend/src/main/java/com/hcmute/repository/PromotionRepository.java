package com.hcmute.repository;

import java.sql.Date;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.hcmute.entity.PromotionEntity;

public interface PromotionRepository extends JpaRepository<PromotionEntity, Long>{
	PromotionEntity findOneByCode(String code);
	Page<PromotionEntity> findByState(Boolean state, Pageable pageable);
	@Query("select p from PromotionEntity p where (p.name like %?1% OR p.code LIKE %?1%) AND p.state = ?2")
	Page<PromotionEntity> findByKeywordAndState(String keyword, Boolean state, Pageable pageable);
	@Query("select p from PromotionEntity p where p.object = ?1 AND (p.name like %?2% OR p.code LIKE %?2%) AND p.state = ?3")
	Page<PromotionEntity> findByObjectAndKeywordAndState(String object, String keyword, Boolean state, Pageable pageable);
	@Query("select p from PromotionEntity p where p.endDate < ?1 AND (p.name like %?2% OR p.code LIKE %?2%) AND p.state = ?3 ORDER BY endDate DESC")
	Page<PromotionEntity> findByExpiredAndKeywordAndState(Date date, String keyword, Boolean state, Pageable pageable);
	@Query("select p from PromotionEntity p where p.startDate <= ?1 AND p.endDate >= ?1 AND (p.name like %?2% OR p.code LIKE %?2%) AND p.state = ?3 ORDER BY startDate ASC")
	Page<PromotionEntity> findByActiveAndKeywordAndState(Date date, String keyword, Boolean state, Pageable pageable);
	@Query("select p from PromotionEntity p where p.startDate > ?1 AND (p.name like %?2% OR p.code LIKE %?2%) AND p.state = ?3 ORDER BY startDate ASC")
	Page<PromotionEntity> findByUpcomingAndKeywordAndState(Date date, String keyword, Boolean state, Pageable pageable);
	@Query("select p from PromotionEntity p where p.endDate < ?1 AND p.object = ?2 AND (p.name like %?3% OR p.code LIKE %?3%) AND p.state = ?4 ORDER BY endDate DESC")
	Page<PromotionEntity> findByExpiredAndObjectAndKeywordAndState(Date date, String object, String keyword, Boolean state, Pageable pageable);
	@Query("select p from PromotionEntity p where p.startDate <= ?1 AND p.endDate >= ?1 AND p.object = ?2 AND "
			+ "(p.name like %?3% OR p.code LIKE %?3%) AND p.state = ?4 ORDER BY startDate ASC")
	Page<PromotionEntity> findByActiveAndObjectAndKeywordAndState(Date date, String object, String keyword, Boolean state, Pageable pageable);
	@Query("select p from PromotionEntity p where p.startDate > ?1 AND p.object = ?2 AND (p.name like %?3% OR p.code LIKE %?3%) "
			+ "AND p.state = ?4 ORDER BY startDate ASC")
	Page<PromotionEntity> findByUpcomingAndObjectAndKeywordAndState(Date date, String object, String keyword, Boolean state, Pageable pageable);
}
