package com.hcmute.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.hcmute.dto.RoleDTO;
import com.hcmute.service.RoleService;

@RestController
public class RoleAPI {
	@Autowired
	private RoleService roleService;
	
	@PostMapping("/api/admin/role")
	public ResponseEntity<RoleDTO> add(@RequestBody RoleDTO dto){
		dto = roleService.save(dto);
		return ResponseEntity.ok(dto);
	}
	
	@GetMapping("/api/admin/role")
	public ResponseEntity<List<RoleDTO>> findAll() {
		return ResponseEntity.ok(roleService.findAll());
	}
	
	@GetMapping("/api/admin/role/{id}")
	public ResponseEntity<RoleDTO> findOne(@PathVariable(name = "id") Long id) {
		return ResponseEntity.ok(roleService.findOne(id));
	}
}
