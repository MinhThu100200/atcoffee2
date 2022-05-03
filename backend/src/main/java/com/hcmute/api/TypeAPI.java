package com.hcmute.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hcmute.api.response.TypeResponse;
import com.hcmute.dto.TypeDTO;
import com.hcmute.dto.UserDTO;
import com.hcmute.service.TypeService;
import com.hcmute.util.ConstantsUtil;

@RestController
public class TypeAPI {
	
	@Autowired
	private TypeService typeService;
	
	@PostMapping("/api/admin/type")
	public ResponseEntity<TypeResponse> add( @RequestBody TypeDTO dto){
		UserDTO user = ConstantsUtil.userDTO;
		dto = typeService.save(dto);
		return ResponseEntity.ok(new TypeResponse(dto, user));
	}
	
	@GetMapping("/api/info/type")
	public ResponseEntity<List<TypeDTO>> findAll() {
		return ResponseEntity.ok(typeService.findAll());
	}
	
	@GetMapping(value = "/api/info/type", params = {"code"})
	public ResponseEntity<TypeDTO> findOneByCode(@RequestParam(name = "code") String code) {
		return ResponseEntity.ok(typeService.findOneByCode(code));
	}
	
	@GetMapping("/api/info/type/{id}")
	public ResponseEntity<TypeDTO> findOne(@PathVariable(name = "id") Long id) {
		return ResponseEntity.ok(typeService.findOne(id));
	}
}
