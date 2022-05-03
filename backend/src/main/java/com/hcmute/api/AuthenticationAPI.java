package com.hcmute.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.hcmute.api.request.AuthenticationRequest;
import com.hcmute.api.response.AuthenticationResponse;
import com.hcmute.dto.UserDTO;
import com.hcmute.service.UserService;
import com.hcmute.util.JwtUtil;

@RestController
public class AuthenticationAPI {
	@Autowired
	private AuthenticationManager authenticationManager;
	@Autowired 
	private UserService userService;
	@Autowired
	private JwtUtil jwtTokenUtil;
	
	@PostMapping("/api/authenticate")
	public ResponseEntity<AuthenticationResponse> createAuthenticationToken(@RequestBody AuthenticationRequest authenticationRequest)
			throws Exception {
		try {
			authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(
					authenticationRequest.getUsername(), authenticationRequest.getPassword()));
		} catch (BadCredentialsException e) {
			// TODO: handle exception
			throw new Exception("Incorrect username or password", e);
		}
		
		final UserDetails userDetails = userService
				.loadUserByUsername(authenticationRequest.getUsername());
		final String jwt = jwtTokenUtil.generateToken(userDetails);
		final UserDTO userDTO = userService.findOneByUsername(authenticationRequest.getUsername());
		
		return ResponseEntity.ok(new AuthenticationResponse(jwt, userDTO));
	}
}
