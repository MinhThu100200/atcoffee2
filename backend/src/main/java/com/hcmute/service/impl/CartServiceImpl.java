package com.hcmute.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hcmute.dto.CartDTO;
import com.hcmute.entity.CartEntity;
import com.hcmute.entity.ProductEntity;
import com.hcmute.entity.StoreEntity;
import com.hcmute.entity.UserEntity;
import com.hcmute.repository.CartRepository;
import com.hcmute.repository.ProductRepository;
import com.hcmute.repository.StoreRepository;
import com.hcmute.repository.UserRepository;
import com.hcmute.service.CartService;

@Service
@Transactional
public class CartServiceImpl implements CartService{
	
	@Autowired
	private ModelMapper mapper;
	@Autowired
	private CartRepository cartRespository;
	@Autowired
	private UserRepository userRepository;
	@Autowired 
	private ProductRepository productRepository;
	@Autowired
	private StoreRepository storeRepository;
	
	@Override
	public CartDTO save(CartDTO cartDTO) {
		mapper.getConfiguration().setAmbiguityIgnored(true);
		CartEntity entity = mapper.map(cartDTO, CartEntity.class);
		ProductEntity product = productRepository.findOne(cartDTO.getProductId());
		UserEntity customer = userRepository.findOne(cartDTO.getCustomerId());
		StoreEntity store = storeRepository.findOne(cartDTO.getStoreId());
		entity.setProduct(product);
		entity.setCustomer(customer);
		entity.setStore(store);
		entity = cartRespository.save(entity);
		return mapper.map(entity, CartDTO.class);
	}
	
	@Override
	public List<CartDTO> findByCustomerId(Long id) {
		UserEntity customer = userRepository.findOne(id);
		List<CartEntity> entities = cartRespository.findByCustomer(customer);
		List<CartDTO> dtos = new ArrayList<CartDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, CartDTO.class)));
		return dtos;
	}

	@Override
	public void delete(Long id) {
		cartRespository.delete(id);
	}
	
	@Override
	public Boolean delete(List<Long> ids) {
		for (int i = 0; i < ids.size(); i++) {
			cartRespository.delete(ids.get(i));
		}
		return true;
	}

	@Override
	public boolean deleteByUserId(Long userId) {
		UserEntity customer = userRepository.findOne(userId);
		long count = cartRespository.deleteByCustomer(customer);
		return count > 0;
	}
	
}
