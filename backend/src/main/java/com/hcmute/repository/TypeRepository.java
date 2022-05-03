package com.hcmute.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hcmute.entity.TypeEntity;

public interface TypeRepository extends JpaRepository<TypeEntity, Long>{
	TypeEntity findOneByCode(String code);
}
