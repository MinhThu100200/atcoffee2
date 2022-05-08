package com.hcmute.repository;

import java.sql.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.hcmute.entity.RoleEntity;
import com.hcmute.entity.StoreEntity;
import com.hcmute.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Long>{
	UserEntity findOneByUsername(String username);
	UserEntity findOneByCode(String code);
	UserEntity findOneByEmail(String email);
	UserEntity findOneByPhone(String phone);
	List<UserEntity> findByRoleAndCreatedDateBetween(RoleEntity role, Date start, Date end);
	UserEntity findOneByUsernameAndPassword(String username, String password);
	List<UserEntity> findByUsernameOrCodeOrEmailOrPhoneOrIdentityCard(String username, String code, String email, String phone, String identityCard);
	@Query("select u from UserEntity u WHERE "
			+ " (u.name LIKE %?1% OR u.code LIKE %?1% OR u.phone LIKE %?1% OR u.email LIKE %?1% OR u.identityCard LIKE %?1%)"
			+ " AND (u.role = ?2 OR u.role = ?3)")
	Page<UserEntity> findByKeyword(String keyword, RoleEntity admin, RoleEntity staff, Pageable pageable);
	@Query("select u from UserEntity u WHERE u.store = ?1 AND u.role != 3 AND"
			+ " (u.name like %?2% OR u.code LIKE %?2% OR u.phone LIKE %?2% OR u.email LIKE %?2% OR u.identityCard LIKE %?2%)"
			+ " ")
	Page<UserEntity> findByStoreAndKeyword(StoreEntity store, String keyword, Pageable pageable);
	@Query("select u from UserEntity u WHERE u.role = ?1 AND"
			+ " (u.name like %?2% OR u.code LIKE %?2% OR u.phone LIKE %?2% OR u.email LIKE %?2% OR u.identityCard LIKE %?2%)")
	Page<UserEntity> findByRoleAndKeyword(RoleEntity role, String keyword, Pageable pageable);
	@Query("select u from UserEntity u WHERE u.state = ?1 AND"
			+ " (u.name like %?2% OR u.code LIKE %?2% OR u.phone LIKE %?2% OR u.email LIKE %?2% OR u.identityCard LIKE %?2%)"
			+ " AND (u.role = ?3 OR u.role = ?4)")
	Page<UserEntity> findByStateAndKeyword(Boolean state, String keyword, RoleEntity admin, RoleEntity staff, Pageable pageable);
	@Query("select u from UserEntity u WHERE u.store = ?1 AND u.role = ?2 AND"
			+ " (u.name like %?3% OR u.code LIKE %?3% OR u.phone LIKE %?3% OR u.email LIKE %?3%  OR u.identityCard LIKE %?3%)")
	Page<UserEntity> findByStoreAndRoleAndKeyword(StoreEntity store, RoleEntity role, String keyword, Pageable pageable);
	@Query("select u from UserEntity u WHERE u.store = ?1 AND u.state = ?2 AND u.role != 3 AND"
			+ " (u.name like %?3% OR u.code LIKE %?3% OR u.phone LIKE %?3% OR u.email LIKE %?3%  OR u.identityCard LIKE %?3%)")
	Page<UserEntity> findByStoreAndStateAndKeyword(StoreEntity store, Boolean state, String keyword, Pageable pageable);
	@Query("select u from UserEntity u WHERE u.role = ?1 AND u.state = ?2 AND"	
			+ " (u.name like %?3% OR u.code LIKE %?3% OR u.phone LIKE %?3% OR u.email LIKE %?3%  OR u.identityCard LIKE %?3%)")
	Page<UserEntity> findByRoleAndStateAndKeyword(RoleEntity role, Boolean state, String keyword, Pageable pageable);
	@Query("select u from UserEntity u WHERE u.store = ?1 AND u.role = ?2 AND u.state = ?3 AND"
			+ " (u.name like %?4% OR u.code LIKE %?4% OR u.phone LIKE %?4% OR u.email LIKE %?4% OR u.identityCard LIKE %?4%)")
	Page<UserEntity> findByStoreAndRoleAndStateAndKeyword(StoreEntity store, RoleEntity role, Boolean state, String keyword, Pageable pageable);
	
}
