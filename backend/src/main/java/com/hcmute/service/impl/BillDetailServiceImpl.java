package com.hcmute.service.impl;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hcmute.dto.BillDetailDTO;
import com.hcmute.entity.BillDetailEntity;
import com.hcmute.repository.BillDetailRepository;
import com.hcmute.service.BillDetailService;

@Service
public class BillDetailServiceImpl implements BillDetailService{
	
	@Autowired
	private BillDetailRepository billDetailRepository;
	@Autowired 
	private ModelMapper mapper;

	@Override
	public BillDetailDTO save(BillDetailDTO billDetailDTO) {
		BillDetailEntity entity = mapper.map(billDetailDTO, BillDetailEntity.class);
		entity = billDetailRepository.save(entity);
		return mapper.map(entity, BillDetailDTO.class);
	}
}
