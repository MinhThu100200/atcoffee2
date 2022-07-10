package com.hcmute.service.impl;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.hcmute.api.response.BillResponse;
import com.hcmute.dto.BillDTO;
import com.hcmute.dto.BillDetailDTO;
import com.hcmute.entity.BillDetailEntity;
import com.hcmute.entity.BillEntity;
import com.hcmute.entity.PaymentEntity;
import com.hcmute.entity.ProductEntity;
import com.hcmute.entity.PromotionEntity;
import com.hcmute.entity.RewardEntity;
import com.hcmute.entity.StoreEntity;
import com.hcmute.entity.TypeEntity;
import com.hcmute.entity.UserEntity;
import com.hcmute.repository.BillDetailRepository;
import com.hcmute.repository.BillRepository;
import com.hcmute.repository.PaymentRepository;
import com.hcmute.repository.ProductRepository;
import com.hcmute.repository.PromotionRepository;
import com.hcmute.repository.RewardRepository;
import com.hcmute.repository.StoreRepository;
import com.hcmute.repository.TypeRepository;
import com.hcmute.repository.UserRepository;
import com.hcmute.service.BillService;
import com.hcmute.util.ConstantsUtil;

@Service
public class BillServiceImpl implements BillService{
	
	@Autowired
	private ModelMapper mapper;
	@Autowired
	private BillRepository billRepository;
	@Autowired
	private ProductRepository productRepository;
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private StoreRepository storeRepository;
	@Autowired
	private RewardRepository rewardRepository;
	@Autowired
	private PromotionRepository promotionRepository;
	@Autowired
	private PaymentRepository paymentRepository;
	@Autowired
	private BillDetailRepository billDetailRepository;
	@Autowired
	private TypeRepository typeRepository;

	@Override
	public BillDTO save(BillDTO billDTO) {
		List<BillDetailDTO> billDetailDTOs = billDTO.getBillDetails();
		billDTO.setBillDetails(new ArrayList<BillDetailDTO>());
		BillEntity entity = mapper.map(billDTO, BillEntity.class);
		UserEntity staff = userRepository.findOne(billDTO.getStaffId());
		UserEntity customer = userRepository.findOne(billDTO.getCustomerId());
		RewardEntity reward = rewardRepository.findOne(billDTO.getRewardId());
		PromotionEntity promotion = promotionRepository.findOne(billDTO.getPromotionId());
		PaymentEntity payment = paymentRepository.findOne(billDTO.getPaymentId());
		StoreEntity store = storeRepository.findOne(billDTO.getStoreId());
		entity.setStaff(staff);
		entity.setCustomer(customer);
		entity.setReward(reward);
		entity.setPromotion(promotion);
		entity.setPayment(payment);
		entity.setStore(store);
		entity = billRepository.save(entity);
		List<BillDetailEntity> billDetailEntities = new ArrayList<BillDetailEntity>();
		for (int i = 0; i < billDetailDTOs.size(); i++) {
			BillDetailDTO billDetailDTO = billDetailDTOs.get(i);
			BillDetailEntity billDetailEntity = mapper.map(billDetailDTO, BillDetailEntity.class);
			ProductEntity productEntity = productRepository.findOne(billDetailDTO.getProductId());
			billDetailEntity.setBill(entity);
			billDetailEntity.setState(true);
			billDetailEntity.setProduct(productEntity);
			billDetailEntities.add(billDetailEntity);
		}
		billDetailEntities = billDetailRepository.save(billDetailEntities);
		entity.setBillDetails(billDetailEntities);
		return mapper.map(entity, BillDTO.class);
	}

	@Override
	public BillDTO updateStatus(BillDTO billDTO) {
		
		if (billDTO.getId() == null) {
			billDTO = this.save(billDTO);
		}
		if (billDTO.getId() != null) {
			BillEntity entity = billRepository.findOne(billDTO.getId());
			entity.setStatus(billDTO.getStatus());
			entity = billRepository.save(entity);
			if (entity.getStatus().equals(ConstantsUtil.STATUS_COMPLETED)) {
				UserEntity user = userRepository.findOne(billDTO.getCustomerId());
				int newPoint = (int)(billDTO.getAmount() * ConstantsUtil.POINTS_REFUND);
				user.setAccumulatedPoints(user.getAccumulatedPoints() + newPoint);
				user.setCurrentPoints(user.getCurrentPoints() + newPoint);
				if (entity.getReward() != null) {
					user.setCurrentPoints(user.getCurrentPoints() - entity.getReward().getProviso());
				}
				List<TypeEntity> types = typeRepository.findAll();
				int points = user.getAccumulatedPoints();
				if (points <= types.get(0).getPoint()) {
					user.setType(types.get(0));
				} else if (points > types.get(0).getPoint() && points <= types.get(1).getPoint()) {
					user.setType(types.get(1));
				} else {
					user.setType(types.get(2));
				}
				userRepository.save(user);
			}
			return mapper.map(entity, BillDTO.class);
		}
		return null;
	}

	@Override
	public List<BillDTO> findByBetweenDate(Date start, Date end, String status) {
		
		LocalDate endLocalDate = end.toLocalDate();
		end = Date.valueOf(endLocalDate.plusDays(1));
		List<BillEntity> entities = billRepository.findByCreatedDateBetweenAndStatus(start, end, status);
		List<BillDTO> dtos = new ArrayList<BillDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, BillDTO.class)));
		return dtos;
	}
	
	@Override
	public List<BillDTO> findByCustomerId(long customerId) {
		UserEntity customer = userRepository.findOne(customerId);
		List<BillEntity> entities = billRepository.findByCustomerOrderByCreatedDateDesc(customer);
		List<BillDTO> dtos = new ArrayList<BillDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, BillDTO.class)));
		return dtos;
	}

	@Override
	public BillResponse findByKeywordAndStatus(String keyword, String status, Pageable pageable) {
		Page<BillEntity> page = billRepository.findByKeywordAndStatus(keyword, status, pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public BillResponse findByStoreIdAndKeywordAndStatus(Long storeId, String keyword, String status, Pageable pageable) {
		StoreEntity store = storeRepository.findOne(storeId);
		Page<BillEntity> page = billRepository.findByStoreAndKeywordAndStatus(store, keyword, status, pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public BillResponse findByModifiedDateAndKeywordAndStatus(Date start, Date end, String keyword, String status,
			Pageable pageable) {
		LocalDate endLocalDate = end.toLocalDate();
		end = Date.valueOf(endLocalDate.plusDays(1));
		Page<BillEntity> page = billRepository.findByModifiedDateBewteenAndKeywordAndStatus(start, end, keyword, status, pageable);
		return resultResponse(page, pageable);
	}
	
	@Override
	public BillResponse findByModifiedDateAndStoreIdAndKeywordAndStatus(Date start, Date end, Long storeId,
			String keyword, String status, Pageable pageable) {
		LocalDate endLocalDate = end.toLocalDate();
		end = Date.valueOf(endLocalDate.plusDays(1));
		StoreEntity store = storeRepository.findOne(storeId);
		Page<BillEntity> page = billRepository.findByModifiedDateBewteenAndStoreAndKeywordAndStatus(start, end, store, keyword, status, pageable);
		return resultResponse(page, pageable);
	}
	
	public BillResponse resultResponse(Page<BillEntity> page, Pageable pageable) {
		List<BillEntity> entities = page.getContent();
		List<BillDTO> dtos = new ArrayList<BillDTO>();
		entities.forEach(entity -> dtos.add(mapper.map(entity, BillDTO.class)));
		BillResponse result = new BillResponse();
		result.setBills(dtos);
		result.setTotalPage(page.getTotalPages());
		result.setSize(page.getSize());
		result.setPage(pageable.getPageNumber());
		return result;
	}

}
