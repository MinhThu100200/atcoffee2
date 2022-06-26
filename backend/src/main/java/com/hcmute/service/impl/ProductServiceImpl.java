package com.hcmute.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.hcmute.api.request.FavouriteRequest;
import com.hcmute.api.response.ProductResponse;
import com.hcmute.dto.CategoryDTO;
import com.hcmute.dto.ProductDTO;
import com.hcmute.dto.StoreDTO;
import com.hcmute.entity.BillDetailEntity;
import com.hcmute.entity.BillEntity;
import com.hcmute.entity.CategoryEntity;
import com.hcmute.entity.ProductEntity;
import com.hcmute.entity.StoreEntity;
import com.hcmute.entity.UserEntity;
import com.hcmute.repository.BillRepository;
import com.hcmute.repository.CategoryRepository;
import com.hcmute.repository.ProductRepository;
import com.hcmute.repository.StoreRepository;
import com.hcmute.repository.UserRepository;
import com.hcmute.service.ProductService;
import com.hcmute.util.ConstantsUtil;

@Service
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	private ModelMapper mapper;
	@Autowired	
	private ProductRepository productRepository;
	@Autowired
	private StoreRepository storeRepository;
	@Autowired
	private CategoryRepository categoryRepository;
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private BillRepository billRepository;
	
	@Override
	public ProductDTO save(ProductDTO dto) {
		ProductEntity entity = mapper.map(dto, ProductEntity.class);
		entity.setState(true);
		entity = productRepository.save(entity);
		if (entity.getId() != null)
		{
			List<StoreEntity> stores = storeRepository.findAll();
			for (int i = 0; i < stores.size(); i++) {
				stores.get(i).getProducts().removeIf(product -> product.getId() == dto.getId());
			}
			storeRepository.save(stores);
			List<CategoryEntity> categories = categoryRepository.findAll();
			for (int j = 0; j < categories.size(); j++) {
				categories.get(j).getProducts().removeIf(product -> product.getId() == dto.getId());
			}
			ProductEntity entityPre = productRepository.findOne(entity.getId());
			entity.setRates(entityPre.getRates());
			entity.setBillDetails(entityPre.getBillDetails());
			entity.setCarts(entityPre.getCarts());
			categoryRepository.save(categories);
		}
		for (StoreDTO storeDTO : dto.getStores()) {
			StoreEntity storeEntity = storeRepository.findOne(storeDTO.getId());
			storeEntity.getProducts().add(entity);
			storeRepository.save(storeEntity);
		}
		for (CategoryDTO categoryDTO : dto.getCategories()) {
			CategoryEntity categoryEntity = categoryRepository.findOne(categoryDTO.getId());
			categoryEntity.getProducts().add(entity);
			categoryRepository.save(categoryEntity);
		}
		return mapper.map(entity, ProductDTO.class);
	}
	
	@Override
	public ProductDTO updateState(Long id, boolean state) {
		ProductEntity productEntity = productRepository.findOne(id);
		productEntity.setState(state);
		productEntity = productRepository.save(productEntity);
		return mapper.map(productEntity, ProductDTO.class);
	}

	@Override
	public ProductDTO findOne(long id) {
		ProductEntity entity = productRepository.findOne(id);
		ProductDTO dto = mapper.map(entity, ProductDTO.class);
		dto.setNumberFavourites(entity.getCustomers().size());
		if (ConstantsUtil.userDTO != null) {
			dto.setFavourited(entity.getCustomers().contains(userRepository.findOne(ConstantsUtil.userDTO.getId())));
		}
		return dto;
	}
	
	@Override
	public ProductDTO findOneByCode(String code ) {
		return mapper.map(productRepository.findOneByCode(code), ProductDTO.class);
	}

	@Override
	public List<ProductDTO> findAll() {
		List<ProductEntity> entities = productRepository.findAll();
		List<ProductDTO> dtos = new ArrayList<ProductDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, ProductDTO.class)));
		return dtos;
	}
	
	@Override
	public List<ProductDTO> findSuggesstion(long customerId, int num) {
		UserEntity customer = userRepository.findOne(customerId);
		List<BillEntity> billEntities = billRepository.findByCustomerOrderByCreatedDateDesc(customer);
		List<ProductEntity> entities = new ArrayList<ProductEntity>();
		boolean flg = false;
		for (int i = 0; i < billEntities.size(); i++) {
			List<BillDetailEntity> billDetailEntities = billEntities.get(i).getBillDetails();
			for (int j = 0; j < billDetailEntities.size(); j++) {
				if (entities.contains(billDetailEntities.get(j).getProduct()) == false) {
					entities.add(billDetailEntities.get(j).getProduct());
					
					if (entities.size() == num) {
						flg = true;
					}
				}
				if (flg == true) {
					break;
				}
			}
			if (flg == true) {
				break;
			}
		}
		List<ProductDTO> dtos = new ArrayList<ProductDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, ProductDTO.class)));
		return dtos;
	}
	
	@Override
	public List<ProductDTO> findFavouritesByCustomerId(long customerId) {
		UserEntity customer = userRepository.findOne(customerId);
		List<ProductEntity> entities = customer.getFavourites();
		List<ProductDTO> dtos = new ArrayList<ProductDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, ProductDTO.class)));
		return dtos;
	}

	@Override
	public ProductResponse findAll(Pageable pageable) {
		Page<ProductEntity> page = productRepository.findAll(pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public int countItem() {
		return (int)productRepository.count();
	}

	@Override
	public int countByCategoryCode(String categoryCode) {
		CategoryEntity category = categoryRepository.findOneByCode(categoryCode);
		List<ProductEntity> entities = productRepository.findByCategoryId(category.getId());
		return entities.size();
	}

	@Override
	public ProductResponse findByState(Boolean state, Pageable pageable) {
		Page<ProductEntity> page = productRepository.findByState(state, pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public ProductResponse findByStoreCodeAndKeyword(String storeCode, String keyword, Pageable pageable) {
		StoreEntity store = storeRepository.findOneByCode(storeCode);
		Page<ProductEntity> page = productRepository.findByStoreIdAndKeyword(store.getId(), keyword, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public ProductResponse findByCategoryCodeAndKeyword(String categoryCode, String keyword,  Pageable pageable) {
		CategoryEntity category = categoryRepository.findOneByCode(categoryCode);
		Page<ProductEntity> page = productRepository.findByCategoryIdAndKeyword(category.getId(), keyword, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public ProductResponse findByStoreCodeAndCategoryCodeAndKeyword(String storeCode, String categoryCode, String keyword, Pageable pageable) {
		StoreEntity store = storeRepository.findOneByCode(storeCode);
		CategoryEntity category = categoryRepository.findOneByCode(categoryCode);
		Page<ProductEntity> page = productRepository.findByStoreIdAndCategoryIdAndKeyword(store.getId(), category.getId(), keyword, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public ProductResponse findByKeyword(String keyword, Pageable pageable) {
		Page<ProductEntity> page = productRepository.findByNameContainingOrCodeContainingAndState(keyword, keyword, true, pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public ProductResponse findByStateIgnore(Boolean state, Pageable pageable) {
		Page<ProductEntity> page = productRepository.findByState(state, pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public ProductResponse findByStoreCodeAndKeywordIgnore(String storeCode, String keyword, Pageable pageable) {
		StoreEntity store = storeRepository.findOneByCode(storeCode);
		Page<ProductEntity> page = productRepository.findByStoreIdAndKeywordIgnore(store.getId(), keyword, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public ProductResponse findByCategoryCodeAndKeywordIgnore(String categoryCode, String keyword,  Pageable pageable) {
		CategoryEntity category = categoryRepository.findOneByCode(categoryCode);
		Page<ProductEntity> page = productRepository.findByCategoryIdAndKeywordIgnore(category.getId(), keyword, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public ProductResponse findByStoreCodeAndCategoryCodeAndKeywordIgnore(String storeCode, String categoryCode, String keyword, Pageable pageable) {
		StoreEntity store = storeRepository.findOneByCode(storeCode);
		CategoryEntity category = categoryRepository.findOneByCode(categoryCode);
		Page<ProductEntity> page = productRepository.findByStoreIdAndCategoryIdAndKeywordIgnore(store.getId(), category.getId(), keyword, pageable);
		return resultResponse(page, pageable);
	}

	@Override
	public ProductResponse findByKeywordIgnore(String keyword, Pageable pageable) {
		Page<ProductEntity> page = productRepository.findByKeywordIgnore(keyword, pageable);
		return resultResponse(page, pageable);
	}
	
	public ProductResponse resultResponse(Page<ProductEntity> page, Pageable pageable) {
		List<ProductEntity> entities = page.getContent();
		List<ProductDTO> dtos = new ArrayList<ProductDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, ProductDTO.class)));
		ProductResponse result = new ProductResponse();
		result.setProducts(dtos);
		result.setTotalPage(page.getTotalPages());
		result.setSize(page.getSize());
		result.setPage(pageable.getPageNumber());
		return result;
	}

	@Override
	public boolean saveFavourite(FavouriteRequest favouriteRequest) {
		try {
			UserEntity userEntity = userRepository.findOne(favouriteRequest.getCustomerId());
			ProductEntity productEntity = productRepository.findOne(favouriteRequest.getProductId());
			if (userEntity.getFavourites().contains(productEntity) == false) {
				userEntity.getFavourites().add(productEntity);
				userRepository.save(userEntity);
			}
			return true;
		} catch (Exception e) {
			return false;
		}
		
	}
	
	@Override
	public boolean deleteFavourite(FavouriteRequest favouriteRequest) {
		try {
			UserEntity userEntity = userRepository.findOne(favouriteRequest.getCustomerId());
			ProductEntity productEntity = productRepository.findOne(favouriteRequest.getProductId());
			if (userEntity.getFavourites().contains(productEntity)) {
				userEntity.getFavourites().remove(productEntity);
				userRepository.save(userEntity);
			}
			return true;
		} catch (Exception e) {
			return false;
		}
		
	}
}
