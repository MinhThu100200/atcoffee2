package com.hcmute.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.hcmute.entity.CategoryEntity;

public interface CategoryRepository extends JpaRepository<CategoryEntity, Long>{
	CategoryEntity findOneByCode(String code);
	Page<CategoryEntity> findByState(Boolean state, Pageable pageable);
	List<CategoryEntity> findByState(Boolean state);
	@Query("select c from CategoryEntity c where (c.name like %?1% OR c.code LIKE %?1%) AND c.state = ?2")
	Page<CategoryEntity> findByKeywordAndState(String keyword, Boolean state, Pageable pageable);
	@Query("select c from CategoryEntity c where (c.name like %?1% OR c.code LIKE %?1%)")
	Page<CategoryEntity> findByKeyword(String keyword, Pageable pageable);
}
