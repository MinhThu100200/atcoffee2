package com.hcmute.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.hcmute.api.request.FavouriteStoreRequest;
import com.hcmute.api.response.StoreResponse;
import com.hcmute.dto.StoreDTO;
import com.hcmute.entity.StoreEntity;
import com.hcmute.entity.UserEntity;
import com.hcmute.repository.StoreRepository;
import com.hcmute.repository.UserRepository;
import com.hcmute.service.StoreService;
import com.hcmute.util.ConstantsUtil;

@Service
public class StoreServiceImpl implements StoreService {

	@Autowired
	private ModelMapper mapper;
	@Autowired
	private StoreRepository storeRepository;
	@Autowired
	private UserRepository userRepository;

	@Override
	public StoreDTO save(StoreDTO storeDTO) {
		StoreEntity entity = mapper.map(storeDTO, StoreEntity.class);
		if (entity.getId() != null) {
			StoreEntity entityPre = storeRepository.findOne(entity.getId());
			entity.setProducts(entityPre.getProducts());
		}
		entity = storeRepository.save(entity);
		return mapper.map(entity, StoreDTO.class);
	}

	@Override
	public StoreDTO findOne(Long id) {
		StoreEntity entity = storeRepository.findOne(id);
		StoreDTO dto = mapper.map(entity, StoreDTO.class);
		if (ConstantsUtil.userDTO != null) {
			dto.setFavourited(entity.getCustomers().contains(userRepository.findOne(ConstantsUtil.userDTO.getId())));
		}
		dto.setNumberFavourites(entity.getCustomers().size());
		return dto;
	}
	
	@Override
	public StoreDTO findOneByCode(String code) {
		return mapper.map(storeRepository.findOneByCode(code), StoreDTO.class);
	}

	@Override
	public List<StoreDTO> findAll() {
		List<StoreDTO> dtos = new ArrayList<StoreDTO>();
		List<StoreEntity> entities = storeRepository.findAll();
		entities.forEach(entity -> {
			StoreDTO dto = mapper.map(entity, StoreDTO.class);
			if (ConstantsUtil.userDTO != null) {
				dto.setFavourited(entity.getCustomers().contains(userRepository.findOne(ConstantsUtil.userDTO.getId())));
			}
			dto.setNumberFavourites(entity.getCustomers().size());
			dtos.add(dto);
		});
		return dtos;
	}
	
	@Override 
	public List<StoreDTO> findByState(Boolean state) {
		List<StoreDTO> dtos = new ArrayList<StoreDTO>();
		List<StoreEntity> entities = storeRepository.findByState(state);
		entities.forEach(entity -> {
			StoreDTO dto = mapper.map(entity, StoreDTO.class);
			if (ConstantsUtil.userDTO != null) {
				dto.setFavourited(entity.getCustomers().contains(userRepository.findOne(ConstantsUtil.userDTO.getId())));
			}
			dto.setNumberFavourites(entity.getCustomers().size());
			dtos.add(dto);
		});
		return dtos;
	}
	
	@Override
	public StoreResponse findAll(Pageable pageable) {
		Page<StoreEntity> page = storeRepository.findAll(pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public StoreResponse findByState(Boolean state, Pageable pageable) {
		Page<StoreEntity> page = storeRepository.findByState(state, pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public StoreResponse findByKeywordAndState(String keyword, Boolean state, Pageable pageable) {
		Page<StoreEntity> page = storeRepository.findByKeywordAndState(keyword, state, pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public StoreResponse findByKeyword(String keyword, Pageable pageable) {
		Page<StoreEntity> page = storeRepository.findByKeyword(keyword, pageable);
		return resultResponse(page, pageable);
	}
	
	public StoreResponse resultResponse(Page<StoreEntity> page, Pageable pageable) {
		List<StoreEntity> entities = page.getContent();
		List<StoreDTO> dtos = new ArrayList<StoreDTO>();
		entities.forEach(entity -> {
			StoreDTO dto = mapper.map(entity, StoreDTO.class);
			if (ConstantsUtil.userDTO != null) {
				dto.setFavourited(entity.getCustomers().contains(userRepository.findOne(ConstantsUtil.userDTO.getId())));
			}
			dto.setNumberFavourites(entity.getCustomers().size());
			dtos.add(mapper.map(entity, StoreDTO.class));
		});
		StoreResponse result = new StoreResponse();
		result.setStores(dtos);
		result.setTotalPage(page.getTotalPages());
		result.setSize(page.getSize());
		result.setPage(pageable.getPageNumber());
		return result;
	}

	@Override
	public List<StoreDTO> findFavouriteStoresByCustomerId(long customerId) {
		UserEntity customer = userRepository.findOne(customerId);
		List<StoreEntity> entities = customer.getFavouriteStores();
		List<StoreDTO> dtos = new ArrayList<StoreDTO>();
		entities.forEach(entity -> {
			StoreDTO dto = mapper.map(entity, StoreDTO.class);
			dto.setFavourited(true);
			dto.setNumberFavourites(entity.getCustomers().size());
			dtos.add(dto);
		});
		return dtos;
	}

	@Override
	public boolean saveFavouriteStore(FavouriteStoreRequest favouriteStoreRequest) {
		try {
			UserEntity userEntity = userRepository.findOne(favouriteStoreRequest.getCustomerId());
			StoreEntity storeEntity = storeRepository.findOne(favouriteStoreRequest.getStoreId());
			if (userEntity.getFavouriteStores().contains(storeEntity) == false) {
				userEntity.getFavouriteStores().add(storeEntity);
				userRepository.save(userEntity);
			}
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public boolean deleteFavouriteStore(FavouriteStoreRequest favouriteStoreRequest) {
		try {
			UserEntity userEntity = userRepository.findOne(favouriteStoreRequest.getCustomerId());
			StoreEntity storeEntity = storeRepository.findOne(favouriteStoreRequest.getStoreId());
			if (userEntity.getFavouriteStores().contains(storeEntity)) {
				userEntity.getFavouriteStores().remove(storeEntity);
				userRepository.save(userEntity);
			}
			return true;
		} catch (Exception e) {
			return false;
		}
	}

}
