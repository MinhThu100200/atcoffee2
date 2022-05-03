package com.hcmute.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hcmute.dto.PaymentDTO;
import com.hcmute.entity.PaymentEntity;
import com.hcmute.repository.PaymentRepository;
import com.hcmute.service.PaymentService;

@Service
public class PaymentServiceImpl implements PaymentService{

	@Autowired
	private ModelMapper mapper;
	@Autowired
	private PaymentRepository paymentRepository;
	
	@Override
	public List<PaymentDTO> findAll() {
		List<PaymentEntity> entities = paymentRepository.findAll();
		List<PaymentDTO> dtos = new ArrayList<PaymentDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, PaymentDTO.class)));
		return dtos;
	}

	@Override
	public PaymentDTO save(PaymentDTO dto) {
		PaymentEntity entity = mapper.map(dto, PaymentEntity.class);
		return mapper.map(paymentRepository.save(entity), PaymentDTO.class);
	}

	@Override
	public PaymentDTO findOne(Long id) {
		return mapper.map(paymentRepository.findOne(id), PaymentDTO.class);
	}
	
	
	

}
