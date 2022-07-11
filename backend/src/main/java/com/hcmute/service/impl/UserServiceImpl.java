package com.hcmute.service.impl;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hcmute.api.request.PasswordRequest;
import com.hcmute.api.request.TokenRequest;
import com.hcmute.api.response.UserResponse;
import com.hcmute.dto.UserDTO;
import com.hcmute.entity.RoleEntity;
import com.hcmute.entity.StoreEntity;
import com.hcmute.entity.TypeEntity;
import com.hcmute.entity.UserEntity;
import com.hcmute.pojo.Mail;
import com.hcmute.repository.RoleRepository;
import com.hcmute.repository.StoreRepository;
import com.hcmute.repository.TypeRepository;
import com.hcmute.repository.UserRepository;
import com.hcmute.service.MailService;
import com.hcmute.service.UserService;
import com.hcmute.util.ConstantsUtil;
import com.hcmute.util.PasswordUtil;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private RoleRepository roleRepository;
	@Autowired
	private StoreRepository storeRepository;
	@Autowired
	private TypeRepository typeRepository;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private ModelMapper mapper;
	@Autowired
	private AuthenticationManager authenticationManager;
	@Autowired
	private MailService mailService;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserEntity userEntity = userRepository.findOneByUsername(username);
		 if (userEntity == null){
	            throw new UsernameNotFoundException("User does not exist!!!");
	        }
		Set<GrantedAuthority> auth = new HashSet<>();
		auth.add(new SimpleGrantedAuthority(userEntity.getRole().getCode()));
		return new User(userEntity.getUsername(), userEntity.getPassword(), auth);
	}

	@Override
	public UserDTO save(UserDTO userDTO) {
		if (userDTO.getId() == null) {
			userDTO.setPassword(passwordEncoder.encode(userDTO.getPassword()));
		}
		StoreEntity storeEntity = new StoreEntity();
		TypeEntity typeEntity = new TypeEntity();
		if (userDTO.getStoreId() != null) {
			storeEntity = storeRepository.findOne(userDTO.getStoreId());
			typeEntity = null;
		}
		
		if (userDTO.getTypeId() != null) {
			typeEntity = typeRepository.findOne(userDTO.getTypeId());
			storeEntity = null;
		}
		
		RoleEntity roleEntity = roleRepository.findOneByName(userDTO.getRoleName());
		UserEntity userEntity = mapper.map(userDTO, UserEntity.class);
		userEntity.setRole(roleEntity);
		if (storeEntity != null)
			userEntity.setStore(storeEntity);
		if (typeEntity != null)
			userEntity.setType(typeEntity);
		if (userEntity.getId() != null) {
			UserEntity entityPre = userRepository.findOne(userEntity.getId());
			userEntity.setRates(entityPre.getRates());
			userEntity.setBills(entityPre.getBills());
			userEntity.setCustomerBills(entityPre.getCustomerBills());
			userEntity.setCustomerCarts(entityPre.getCustomerCarts());
		}
		userRepository.save(userEntity);
		return mapper.map(userEntity, UserDTO.class);
	}

	@Override
	public UserDTO findOneByUsername(String username) {
		return mapper.map(userRepository.findOneByUsername(username), UserDTO.class);
	}
	
	@Override
	public UserDTO findOneByCode(String code) {
		return mapper.map(userRepository.findOneByCode(code), UserDTO.class);
	}

	@Override
	public UserDTO findOne(Long id) {
		return mapper.map(userRepository.findOne(id), UserDTO.class);
	}

	@Override
	public List<UserDTO> findAll() {
		List<UserDTO> dtos = new ArrayList<UserDTO>();
		List<UserEntity> entities = userRepository.findAll();
		entities.forEach(entity -> dtos.add(mapper.map(entity, UserDTO.class)));
		return dtos;
	}
	
	@Override
	public List<UserDTO> findByRoleAndCreatedDateBetween(String roleName, Date start, Date end) {
		
		RoleEntity role = roleRepository.findOneByName(roleName);
		List<UserDTO> dtos = new ArrayList<UserDTO>();
		List<UserEntity> entities = userRepository.findByRoleAndCreatedDateBetween(role, start, end);
		entities.forEach(entity -> dtos.add(mapper.map(entity, UserDTO.class)));
		return dtos;
	}


	@Override
	public Boolean updateToken(TokenRequest tokenRequest) {
		try {
			UserEntity entity = userRepository.findOne(ConstantsUtil.userDTO.getId());
			if (!"".equals(tokenRequest.getToken())) {
				entity.setToken(tokenRequest.getToken());
			}
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	@Override
	public UserDTO updatePassword(PasswordRequest passwordRequest) {
		UserDTO dto = passwordRequest.getUser();
		try {
			authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(
					dto.getUsername(), passwordRequest.getOldPassword()));
		} catch (BadCredentialsException e) {
			return null;
		}
		
		UserEntity entity = userRepository.findOneByUsername(dto.getUsername());
		if (entity != null) {
			String newPassword = passwordEncoder.encode(passwordRequest.getNewPassword());
			entity.setPassword(newPassword);
			entity = userRepository.save(entity);
			return mapper.map(entity, UserDTO.class);
		}
		return null;
	}

	@Override
	public Boolean resetPassword(String email) {
		UserEntity entity = userRepository.findOneByEmail(email);
		if(entity != null) {
			String password = PasswordUtil.generateRandomPassword(8);
			String passwordEncoded = passwordEncoder.encode(password);
			entity.setPassword(passwordEncoded);
			entity = userRepository.save(entity);
			if (entity != null) {
				Mail mail = new Mail();
		        mail.setMailFrom("atcoffee2021@gmail.com");
		        mail.setMailTo(email);
		        mail.setMailSubject("Reset password - A&T Coffee");
		        mail.setMailContent(password + " là mật khẩu mới của bạn!");
		        mailService.sendEmail(mail);
		        return true;
			}
		}
		return false;
	}

	@Override
	public UserResponse findByKeyword(String keyword, Pageable pageable) {
		RoleEntity admin = roleRepository.findOneByName(ConstantsUtil.ROLE_NAME_ADMIN);
		RoleEntity staff = roleRepository.findOneByName(ConstantsUtil.ROLE_NAME_STAFF);
		Page<UserEntity> page = userRepository.findByKeyword(keyword, admin, staff, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public UserResponse findByStoreCodeAndKeyword(String storeCode, String keyword, Pageable pageable) {
		StoreEntity store = storeRepository.findOneByCode(storeCode);
		Page<UserEntity> page = userRepository.findByStoreAndKeyword(store, keyword, pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public UserResponse findByRoleNameAndKeyword(String roleName, String keyword, Pageable pageable) {
		RoleEntity role = roleRepository.findOneByName(roleName);
		Page<UserEntity> page =  userRepository.findByRoleAndKeyword(role, keyword, pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public UserResponse findByStateAndKeyword(Boolean state, String keyword, Pageable pageable) {
		RoleEntity admin = roleRepository.findOneByName(ConstantsUtil.ROLE_NAME_ADMIN);
		RoleEntity staff = roleRepository.findOneByName(ConstantsUtil.ROLE_NAME_STAFF);
		Page<UserEntity> page =  userRepository.findByStateAndKeyword(state, keyword, admin, staff, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public UserResponse findByStoreCodeAndRoleNameAndKeyword(String storeCode, String roleName, String keyword,
			Pageable pageable) {
		StoreEntity store = storeRepository.findOneByCode(storeCode);
		RoleEntity role = roleRepository.findOneByName(roleName);
		Page<UserEntity> page =  userRepository.findByStoreAndRoleAndKeyword(store, role, keyword, pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public UserResponse findByStoreCodeAndStateAndKeyword(String storeCode, Boolean state, String keyword,
			Pageable pageable) {
		StoreEntity store = storeRepository.findOneByCode(storeCode);
		Page<UserEntity> page =  userRepository.findByStoreAndStateAndKeyword(store, state, keyword, pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public UserResponse findByRoleNameAndStateAndKeyword(String roleName, Boolean state, String keyword,
			Pageable pageable) {
		RoleEntity role = roleRepository.findOneByName(roleName);
		Page<UserEntity> page =  userRepository.findByRoleAndStateAndKeyword(role, state, keyword, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public UserResponse findByStoreCodeAndRoleNameAndStateAndKeyword(String storeCode, String roleName, Boolean state, String keyword, 
			Pageable pageable) {
		StoreEntity store = storeRepository.findOneByCode(storeCode);
		RoleEntity role = roleRepository.findOneByName(roleName);
		Page<UserEntity> page = userRepository.findByStoreAndRoleAndStateAndKeyword(store, role, state, keyword, pageable);
		return resultResponse(page, pageable);
	}
	
	public UserResponse resultResponse(Page<UserEntity> page, Pageable pageable) {
		List<UserEntity> entities = page.getContent();
		List<UserDTO> dtos = new ArrayList<UserDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, UserDTO.class)));
		UserResponse result = new UserResponse();
		result.setUsers(dtos);
		result.setTotalPage(page.getTotalPages());
		result.setSize(page.getSize());
		result.setPage(pageable.getPageNumber());
		return result;
	}

	@Override
	public List<UserDTO> validate(String username, String code, String email, String phone, String identityCard) {
		List<UserEntity> entities = userRepository.findByUsernameOrCodeOrEmailOrPhoneOrIdentityCard(username, code, email, phone, identityCard);
		List<UserDTO> dtos = new ArrayList<UserDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, UserDTO.class)));
		return dtos;
	}

	@Override
	public String validateSignUpUser(UserDTO userDto) {
		String validateMsg = "";
		UserEntity entity = userRepository.findOneByEmail(userDto.getEmail());
		if (entity != null) {
			validateMsg += "Email đã tồn tại. ";
		}
		entity = userRepository.findOneByPhone(userDto.getPhone());
		if (entity != null) {
			validateMsg += "Số điện thoại đã tồn tại.";
		}
		
		return validateMsg;
	}

}
