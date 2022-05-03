package com.hcmute.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hcmute.dto.TypeDTO;
import com.hcmute.entity.TypeEntity;
import com.hcmute.repository.TypeRepository;
import com.hcmute.service.TypeService;

@Service
public class TypeServiceImpl implements TypeService{

	@Autowired
	private ModelMapper mapper;
	@Autowired
	private TypeRepository typeRepository;
	
	@Override
	public TypeDTO save(TypeDTO typeDTO) {
		TypeEntity entity = mapper.map(typeDTO, TypeEntity.class);
		entity = typeRepository.save(entity);
		return mapper.map(entity, TypeDTO.class);
	}

	@Override
	public TypeDTO findOne(Long id) {
		return mapper.map(typeRepository.findOne(id), TypeDTO.class);
	}
	
	@Override
	public TypeDTO findOneByCode(String code) {
		return mapper.map(typeRepository.findOneByCode(code), TypeDTO.class);
	}

	@Override
	public List<TypeDTO> findAll() {
		List<TypeDTO> dtos = new ArrayList<TypeDTO>();
		List<TypeEntity> entities = typeRepository.findAll();
		entities.forEach(entity -> dtos.add(mapper.map(entity, TypeDTO.class)));
		return dtos;
	}

}
