package com.hcmute.service;

import java.util.List;

import com.hcmute.dto.PaymentDTO;

public interface PaymentService {
	PaymentDTO save(PaymentDTO dto);
	List<PaymentDTO> findAll();
	PaymentDTO findOne(Long id);
}
