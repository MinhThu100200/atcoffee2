package com.hcmute.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.hcmute.entity.ProductEntity;
import com.hcmute.entity.RateEntity;
import com.hcmute.entity.UserEntity;

public interface RateRepository extends JpaRepository<RateEntity, Long>{
	List<RateEntity> findByProduct(ProductEntity product);
	Page<RateEntity> findByProduct(ProductEntity product, Pageable pageable);
	List<RateEntity> findByUser(UserEntity user);
	Page<RateEntity> findByUser(UserEntity user, Pageable pageable);
	RateEntity findOneByProductAndUser(ProductEntity product, UserEntity user);
	Page<RateEntity>findByProductAndUser(ProductEntity product, UserEntity user, Pageable pageable);
}
