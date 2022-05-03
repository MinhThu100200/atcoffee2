package com.hcmute.api;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hcmute.api.request.PasswordRequest;
import com.hcmute.api.response.UserResponse;
import com.hcmute.dto.UserDTO;
import com.hcmute.service.UserService;
import com.hcmute.util.ConstantsUtil;

@RestController
public class UserAPI {
	@Autowired
	private Cloudinary cloudinary;
	@Autowired
	private ObjectMapper objectMapper;
	@Autowired
	private UserService userService;
	
	@GetMapping("/api/user/authenticate")
	public ResponseEntity<UserDTO> authenticate(){
		UserDTO user = ConstantsUtil.userDTO;
		return ResponseEntity.ok(user);
	}
	
	@GetMapping("/api/info/user")
	public ResponseEntity<UserDTO> findOneByUsername(@RequestParam(name = "username") String username){
		return ResponseEntity.ok(userService.findOneByUsername(username));
	}
	
	@GetMapping(value = "/api/admin/user", params = "list")
	public ResponseEntity<List<UserDTO>> findAll(){
		return ResponseEntity.ok(userService.findAll());
	}
	

	@GetMapping(value = "/api/staff/user", params = "code")
	public ResponseEntity<UserDTO> findOneByCode(@RequestParam(name = "code") String code){
		return ResponseEntity.ok(userService.findOneByCode(code));
	}
		
	@GetMapping("/api/staff/user/{id}")
	public ResponseEntity<UserDTO> findOne(@PathVariable(name = "id") Long id){
		return ResponseEntity.ok(userService.findOne(id));
	}
	
	@GetMapping(value = "/api/staff/user/statistics", params = {"roleName", "startDate", "endDate"})
	public ResponseEntity<List<UserDTO>> findByRoleNameCreatedDateBetween(@RequestParam(name = "roleName") String roleName,
			@RequestParam(name = "startDate") Date startDate, 
			@RequestParam(name = "endDate") Date endDate) {
		
		return ResponseEntity.ok(userService.findByRoleAndCreatedDateBetween(roleName, startDate, endDate));
	}
	
	@PutMapping("/api/user/change-password")
	public ResponseEntity<UserDTO> changePassword(@RequestBody PasswordRequest passwordRequest){
		return ResponseEntity.ok(userService.updatePassword(passwordRequest));
	}
	
	@GetMapping("/api/info/reset-password")
	public ResponseEntity<Boolean> resetPassowrd(@RequestParam(value = "email") String email){
		return ResponseEntity.ok(userService.resetPassword(email));
	}
	
	@PostMapping("/api/login/user")
	public ResponseEntity<UserDTO> signUp(@RequestBody UserDTO userDTO){
		userDTO.setRoleName("USER");
		userDTO = userService.save(userDTO);
		return ResponseEntity.ok(userDTO);
	}
	
	@PostMapping(value = "/api/info/user")
	public ResponseEntity<UserDTO> addCustomer(@RequestParam(value = "file", required = false) MultipartFile multipartFile,
			@RequestParam("user") String userJson){
		try {
			UserDTO user = objectMapper.readValue(userJson, UserDTO.class);	
			user.setState(true);
			user.setAccumulatedPoints(0);
			user.setCurrentPoints(0);
			user.setTypeId(1L);
			if (multipartFile != null) {
				@SuppressWarnings("rawtypes")
				Map r = this.cloudinary.uploader().upload(multipartFile.getBytes(),
		                  ObjectUtils.asMap("resource_type", "auto"));
				String img = (String) r.get("secure_url");
				user.setImage(img);
			}
			user.setRoleName(ConstantsUtil.ROLE_NAME_USER);
			user = userService.save(user);
			return ResponseEntity.ok(user);
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}
	} 
	
	@PutMapping(value = "/api/info/user")
	public ResponseEntity<UserDTO> updateCustomer(@RequestParam(value = "file", required = false) MultipartFile multipartFile,
			@RequestParam("user") String userJson){
		try {
			UserDTO user = objectMapper.readValue(userJson, UserDTO.class);	
			if (multipartFile != null) {
				@SuppressWarnings("rawtypes")
				Map r = this.cloudinary.uploader().upload(multipartFile.getBytes(),
		                  ObjectUtils.asMap("resource_type", "auto"));
				String img = (String) r.get("secure_url");
				user.setImage(img);
			}
			user.setRoleName(ConstantsUtil.ROLE_NAME_USER);
			user = userService.save(user);
			return ResponseEntity.ok(user);
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}
	} 
	
	
	
	@PostMapping("/api/admin/user")
	public ResponseEntity<UserDTO> add(@RequestParam(value = "file", required = false) MultipartFile multipartFile,
			@RequestParam("user") String userJson){
		try {
			UserDTO user = objectMapper.readValue(userJson, UserDTO.class);	
			if (multipartFile != null) {
				@SuppressWarnings("rawtypes")
				Map r = this.cloudinary.uploader().upload(multipartFile.getBytes(),
		                  ObjectUtils.asMap("resource_type", "auto"));
				String img = (String) r.get("secure_url");
				user.setImage(img);
			}
			user = userService.save(user);
			return ResponseEntity.ok(user);
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}
	}
	
	@GetMapping("/api/info/user/validate")
	public ResponseEntity<List<UserDTO>> validate(@RequestParam(name = "username", required = false) String username, @RequestParam(name = "code", required = false) String code,
			@RequestParam(name = "email", required = false) String email, @RequestParam(name = "phone", required = false) String phone, 
			@RequestParam(name = "identity-card", required = false) String identityCard){
		return ResponseEntity.ok(userService.validate(username, code, email, phone, identityCard));
	}
	
	
	@GetMapping("/api/admin/user") 
	public ResponseEntity<UserResponse> findAll(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size") int size, @RequestParam(name = "store", required = false) String storeCode,
			@RequestParam(name="role", required = false) String roleName,
			@RequestParam(name="state", required=false) String stateString,
			@RequestParam(name = "keyword", required = false) String keyword) {
		
		UserResponse result  = new UserResponse();
		Pageable pageable = new PageRequest(page - 1, size);
		if (storeCode == "" && roleName == "" && stateString == "" && keyword == "") {
			result = userService.findByKeyword(keyword, pageable);
		} else {
			if (storeCode != "" && roleName != "" && stateString != "") {
				Boolean state = stateString.equalsIgnoreCase("true");
				result = userService.findByStoreCodeAndRoleNameAndStateAndKeyword(storeCode, roleName, state, keyword, pageable);
			} else if (storeCode != "" && roleName != "") {
				result = userService.findByStoreCodeAndRoleNameAndKeyword(storeCode, roleName, keyword, pageable);
			} else if (storeCode != "" && stateString != "") {
				Boolean state = stateString.equalsIgnoreCase("true");
				result = userService.findByStoreCodeAndStateAndKeyword(storeCode, state, keyword, pageable);
			} else if (roleName != "" && stateString != "") {
				Boolean state = stateString.equalsIgnoreCase("true");
				result = userService.findByRoleNameAndStateAndKeyword(roleName, state, keyword, pageable);
			}
			else if (storeCode != "") {
				result = userService.findByStoreCodeAndKeyword(storeCode, keyword, pageable);
			} else if (roleName != "") {
				result = userService.findByRoleNameAndKeyword(roleName, keyword, pageable);
			} else if (stateString != "") {
				Boolean state = stateString.equalsIgnoreCase("true");
				result = userService.findByStateAndKeyword(state, keyword, pageable);
			} else {
				result = userService.findByKeyword(keyword, pageable);
			}
		}
		return ResponseEntity.ok(result);
	}
}
