package com.hcmute.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hcmute.entity.CartEntity;
import com.hcmute.entity.UserEntity;

public interface CartRepository extends JpaRepository<CartEntity, Long>{
	List<CartEntity> findByCustomer(UserEntity customer);
	long deleteByCustomer(UserEntity customer);
}
