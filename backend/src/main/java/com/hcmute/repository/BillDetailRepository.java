package com.hcmute.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hcmute.entity.BillDetailEntity;

public interface BillDetailRepository extends JpaRepository<BillDetailEntity, Long>{
	
}
