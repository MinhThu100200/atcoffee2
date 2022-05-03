package com.hcmute.service;

import java.util.List;

import com.hcmute.dto.TypeDTO;

public interface TypeService {
	TypeDTO save(TypeDTO typeDTO);
	TypeDTO findOne(Long id);
	TypeDTO findOneByCode(String code);
	List<TypeDTO> findAll();
}
