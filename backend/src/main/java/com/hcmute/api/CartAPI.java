package com.hcmute.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hcmute.api.request.RateDeleteRequest;
import com.hcmute.dto.CartDTO;
import com.hcmute.service.CartService;

@RestController
public class CartAPI {
	
	@Autowired
	private CartService cartService;
	
	@GetMapping(value = "/api/user/cart", params = {"customerId"})
	public ResponseEntity<List<CartDTO>> findByCustomerId(@RequestParam(name = "customerId") Long customerId) {
		return ResponseEntity.ok(cartService.findByCustomerId(customerId));
	}
	
	@PostMapping("/api/user/cart") 
	public ResponseEntity<CartDTO> save(@RequestBody CartDTO cartDTO) {
		return ResponseEntity.ok(cartService.save(cartDTO));
	}
	
	@PutMapping("/api/user/cart") 
	public ResponseEntity<CartDTO> update(@RequestBody CartDTO cartDTO) {
		return ResponseEntity.ok(cartService.save(cartDTO));
	}
	
	/**
	 * Object send
	 	{
    		"ids": [1, 2, 3, 4, 5]
		}
	 * 
	 * 
	 * @param rateDeleteRequest
	 * @return
	 */
	@PostMapping("/api/user/cart/delete")
	public ResponseEntity<Boolean> delete(@RequestBody RateDeleteRequest rateDeleteRequest) {
		return ResponseEntity.ok(cartService.delete(rateDeleteRequest.getIds()));
	}
	
	@DeleteMapping(value = "/api/user/cart", params = {"cartId"}) 
	public ResponseEntity<Boolean> deleteById(@RequestParam(name = "cartId") Long cartId) {
		cartService.delete(cartId);
		return ResponseEntity.ok(true);
	}
	
	@DeleteMapping(value = "/api/user/cart", params = {"userId"}) 
	public ResponseEntity<Boolean> deleteByUserId(@RequestParam(name = "userId") Long userId) {
		return ResponseEntity.ok(cartService.deleteByUserId(userId));
	}
}
