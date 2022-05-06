package com.hcmute.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.hcmute.api.request.FavouriteRequest;
import com.hcmute.api.response.ProductResponse;
import com.hcmute.dto.ProductDTO;

public interface ProductService {
	ProductDTO save(ProductDTO dto);
	ProductDTO updateState(Long id, boolean state);
	ProductDTO findOne(long id);
	ProductDTO findOneByCode(String code);
	int countByCategoryCode(String categoryCode);
	List<ProductDTO> findAll();
	List<ProductDTO> findSuggesstion(long customerId, int num);
	List<ProductDTO> findFavouritesByCustomerId(long customerId);
	boolean saveFavourite(FavouriteRequest favouriteRequest);
	boolean deleteFavourite(FavouriteRequest favouriteRequest);
	ProductResponse findByState(Boolean state, Pageable pageable);
	ProductResponse findAll(Pageable pageable);
	ProductResponse findByKeyword(String keyword, Pageable pageable);
	ProductResponse findByStoreCodeAndKeyword(String storeCode, String keyword , Pageable pageable);	
	ProductResponse findByCategoryCodeAndKeyword(String categoryCode, String keyword , Pageable pageable);
	ProductResponse findByStoreCodeAndCategoryCodeAndKeyword(String storeCode, String categoryCode, String keyword, Pageable pageable);
	int countItem();
	ProductResponse findByStateIgnore(Boolean state, Pageable pageable);
	ProductResponse findByKeywordIgnore(String keyword, Pageable pageable);
	ProductResponse findByStoreCodeAndKeywordIgnore(String storeCode, String keyword , Pageable pageable);	
	ProductResponse findByCategoryCodeAndKeywordIgnore(String categoryCode, String keyword , Pageable pageable);
	ProductResponse findByStoreCodeAndCategoryCodeAndKeywordIgnore(String storeCode, String categoryCode, String keyword, Pageable pageable);
}
