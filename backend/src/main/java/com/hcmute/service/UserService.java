package com.hcmute.service;

import java.sql.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UserDetailsService;

import com.hcmute.api.request.PasswordRequest;
import com.hcmute.api.request.TokenRequest;
import com.hcmute.api.response.UserResponse;
import com.hcmute.dto.UserDTO;

public interface UserService extends UserDetailsService{
	UserDTO save(UserDTO userDTO);
	UserDTO updatePassword(PasswordRequest passwordRequest);
	Boolean updateToken(TokenRequest tokenRequest);
	Boolean resetPassword(String email);
	UserDTO findOneByUsername(String username);
	UserDTO findOneByCode(String code);
	UserDTO findOne(Long id);
	String validateSignUpUser(UserDTO userDto);
	List<UserDTO> validate(String username, String code, String email, String phone, String identityCard);
	List<UserDTO> findAll();
	List<UserDTO> findByRoleAndCreatedDateBetween(String roleName, Date start, Date end);
	UserResponse findByKeyword(String keyword, Pageable pageable);
	UserResponse findByStoreCodeAndKeyword(String storeCode,  String keyword, Pageable pageable);
	UserResponse findByRoleNameAndKeyword(String roleName,  String keyword, Pageable pageable);
	UserResponse findByStateAndKeyword(Boolean state,  String keyword, Pageable pageable);
	UserResponse findByStoreCodeAndRoleNameAndKeyword(String storeCode, String roleName, String keyword, Pageable pageable);
	UserResponse findByStoreCodeAndStateAndKeyword(String storeCode, Boolean state, String keyword, Pageable pageable);
	UserResponse findByRoleNameAndStateAndKeyword(String roleName, Boolean state, String keyword, Pageable pageable);
	UserResponse findByStoreCodeAndRoleNameAndStateAndKeyword(String storeCode, String roleName, Boolean state, String keyword, Pageable pageable);
}
