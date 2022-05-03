package com.hcmute.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.hcmute.entity.ProductEntity;

public interface ProductRepository extends JpaRepository<ProductEntity, Long>{
	Page<ProductEntity> findByState(Boolean state, Pageable pageable);

	@Query("select p from ProductEntity p "
			+ "Where (p.name LIKE %?1% OR p.code LIKE %?2%) AND p.state = ?3")
	Page<ProductEntity> findByNameContainingOrCodeContainingAndState(String name, String code, Boolean state, Pageable pageable);
	@Query("select p from ProductEntity p left join p.categories as s where s.id = ?1 AND p.state = 1")
	List<ProductEntity> findByCategoryId(Long categoryId);
	@Query("select p from ProductEntity p left join p.stores as s where s.id = ?1 AND (p.name like %?2% OR p.code LIKE %?2%) AND p.state = 1")
	Page<ProductEntity> findByStoreIdAndKeyword(Long storeId, String keyword, Pageable pageable);
	@Query("select p from ProductEntity p left join p.categories as c where c.id = ?1 AND (p.name LIKE %?2% OR p.code LIKE %?2%) AND p.state = 1")
	Page<ProductEntity> findByCategoryIdAndKeyword(Long categoryId, String keyword, Pageable pageable);
	@Query("select p from ProductEntity p left join p.stores as s left join p.categories as c where s.id = ?1 AND c.id = ?2 AND (p.name LIKE %?3% OR p.code LIKE %?3%) AND p.state = 1")
	Page<ProductEntity> findByStoreIdAndCategoryIdAndKeyword(Long storeId, Long categoryId, String keyword, Pageable pageable);
	ProductEntity findOneByCode(String code);
	@Query("select p from ProductEntity p where (p.name LIKE %?1% OR p.code LIKE %?1%)")
	Page<ProductEntity> findByKeywordIgnore(String keyword, Pageable pageable);
	@Query("select p from ProductEntity p left join p.stores as s where s.id = ?1 AND (p.name like %?2% OR p.code LIKE %?2%)")
	Page<ProductEntity> findByStoreIdAndKeywordIgnore(Long storeId, String keyword, Pageable pageable);
	@Query("select p from ProductEntity p left join p.categories as c where c.id = ?1 AND (p.name LIKE %?2% OR p.code LIKE %?2%)")
	Page<ProductEntity> findByCategoryIdAndKeywordIgnore(Long categoryId, String keyword, Pageable pageable);
	@Query("select p from ProductEntity p left join p.stores as s left join p.categories as c where s.id = ?1 AND c.id = ?2 AND (p.name LIKE %?3% OR p.code LIKE %?3%)")
	Page<ProductEntity> findByStoreIdAndCategoryIdAndKeywordIgnore(Long storeId, Long categoryId, String keyword, Pageable pageable);
}
