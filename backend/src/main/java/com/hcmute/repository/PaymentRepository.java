package com.hcmute.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hcmute.entity.PaymentEntity;

public interface PaymentRepository extends JpaRepository<PaymentEntity, Long>{

}
