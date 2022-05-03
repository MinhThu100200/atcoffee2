package com.hcmute.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.hcmute.dto.PaymentDTO;
import com.hcmute.service.PaymentService;

@RestController
public class PaymentAPI {
	
	@Autowired
	private PaymentService paymentService;
	
	@GetMapping("/api/info/payment")
	public ResponseEntity<List<PaymentDTO>> findAll() {
		return ResponseEntity.ok(paymentService.findAll());
	}
	
	@GetMapping("/api/info/payment/{id}")
	public ResponseEntity<PaymentDTO> findOne(@PathVariable(name = "id") Long id) {
		return ResponseEntity.ok(paymentService.findOne(id));
	}
}
