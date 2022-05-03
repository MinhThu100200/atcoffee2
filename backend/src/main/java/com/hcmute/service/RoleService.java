package com.hcmute.service;

import java.util.List;

import com.hcmute.dto.RoleDTO;

public interface RoleService {
	RoleDTO findOne(Long id);
	RoleDTO save(RoleDTO roleDTO);
	List<RoleDTO> findAll();
}
