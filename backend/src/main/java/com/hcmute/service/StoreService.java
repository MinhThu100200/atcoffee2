package com.hcmute.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.hcmute.api.request.FavouriteStoreRequest;
import com.hcmute.api.response.StoreResponse;
import com.hcmute.dto.StoreDTO;


public interface StoreService {
	StoreDTO save(StoreDTO storeDTO);
	StoreDTO findOne(Long id);
	StoreDTO findOneByCode(String code);
	List<StoreDTO> findAll();
	List<StoreDTO> findByState(Boolean state);
	List<StoreDTO> findFavouriteStoresByCustomerId(long customerId);
	boolean saveFavouriteStore(FavouriteStoreRequest favouriteStoreRequest);
	boolean deleteFavouriteStore(FavouriteStoreRequest favouriteStoreRequest);
	StoreResponse findAll(Pageable pageable);
	StoreResponse findByState(Boolean state, Pageable pageable);
	StoreResponse findByKeywordAndState(String keyword, Boolean state, Pageable pageable);
	StoreResponse findByKeyword(String keyword, Pageable pageable);
}
