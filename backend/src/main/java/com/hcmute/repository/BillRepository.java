package com.hcmute.repository;

import java.sql.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.hcmute.entity.BillEntity;
import com.hcmute.entity.StoreEntity;
import com.hcmute.entity.UserEntity;

public interface BillRepository extends JpaRepository<BillEntity, Long>{
	
	List<BillEntity> findByCreatedDateBetweenAndStatus(Date start, Date end, String status);
	List<BillEntity> findByCustomerOrderByCreatedDateDesc(UserEntity customer);
	@Query("select b from BillEntity b left join b.staff s left join b.customer c WHERE "
			+ "(b.code LIKE %?1% OR s.name LIKE %?1% OR c.name LIKE %?1%) AND b.status = ?2 ORDER BY b.modifiedDate DESC")
	Page<BillEntity>findByKeywordAndStatus(String keyword, String status, Pageable pageable);
	@Query("select b from BillEntity b left join b.staff s left join b.customer c WHERE "
			+ "b.store = ?1 AND (b.code LIKE %?2% OR s.name LIKE %?2% OR c.name LIKE %?2%) AND b.status = ?3 ORDER BY b.modifiedDate DESC")
	Page<BillEntity>findByStoreAndKeywordAndStatus(StoreEntity store, String keyword, String status, Pageable pageable);
	@Query("select b from BillEntity b left join b.staff s left join b.customer c WHERE "
			+ "(b.modifiedDate >= ?1 AND b.modifiedDate <= ?2) "
			+ "AND (b.code LIKE %?3% OR s.name LIKE %?3% OR c.name LIKE %?3%) AND b.status = ?4 ORDER BY b.modifiedDate DESC")
	Page<BillEntity>findByModifiedDateBewteenAndKeywordAndStatus(Date start, Date end, String keyword, String status, Pageable pageable);
	@Query("select b from BillEntity b left join b.staff s left join b.customer c WHERE "
			+ "(b.modifiedDate >= ?1 AND b.modifiedDate <= ?2) AND b.store = ?3 "
			+ "AND (b.code LIKE %?4% OR s.name LIKE %?4% OR c.name LIKE %?4%) AND b.status = ?5 ORDER BY b.modifiedDate DESC")
	Page<BillEntity>findByModifiedDateBewteenAndStoreAndKeywordAndStatus(Date start, Date end, StoreEntity store, String keyword, String status, Pageable pageable);
}
