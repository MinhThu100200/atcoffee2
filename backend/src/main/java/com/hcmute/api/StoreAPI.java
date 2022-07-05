package com.hcmute.api;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hcmute.api.request.FavouriteStoreRequest;
import com.hcmute.api.response.StoreResponse;
import com.hcmute.dto.StoreDTO;
import com.hcmute.service.StoreService;
import com.hcmute.util.ConstantsUtil;

@RestController
public class StoreAPI {

	@Autowired
	private Cloudinary cloudinary;
	@Autowired
	private StoreService storeService;
	@Autowired
	private ObjectMapper objectMapper;
	
	@GetMapping("/api/info/store/{id}")
	public ResponseEntity<StoreDTO> findOne(@PathVariable(name = "id") long id){
		return ResponseEntity.ok(storeService.findOne(id));
	}
	
	@RequestMapping(value = "/api/info/store", params = "code", method = RequestMethod.GET)
	public ResponseEntity<StoreDTO> findBy(@RequestParam(name = "code") String code){
		return ResponseEntity.ok(storeService.findOneByCode(code));
	}
	
	@GetMapping(value = "/api/info/store")
	public ResponseEntity<List<StoreDTO>> findAll(){
		return ResponseEntity.ok(storeService.findByState(true));
	}
	
	@GetMapping(value = "/api/staff/store", params = {"page", "size", "keyword"})
	public ResponseEntity<StoreResponse> findAllWithStaff(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size") int size,
			@RequestParam(name="keyword") String keyword){
		Pageable pageable = new PageRequest(page - 1, size);
		return ResponseEntity.ok(storeService.findByKeyword(keyword, pageable));
	}
	
	@GetMapping(value = "/api/info/store", params = {"page", "size", "keyword"})
	public ResponseEntity<StoreResponse> findAll(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size") int size,
			@RequestParam(name="keyword") String keyword,
			@RequestParam(name = "state", defaultValue = "true", required = false) Boolean state){
		Pageable pageable = new PageRequest(page - 1, size);
		return ResponseEntity.ok(storeService.findByKeywordAndState(keyword, state, pageable));
	}
	
	@PostMapping("/api/admin/store")
	public ResponseEntity<StoreDTO> save(@RequestParam(value="file", required=false) MultipartFile multipartFile, @RequestParam("store") String storeJson){
		try {
			StoreDTO storeDTO = objectMapper.readValue(storeJson, StoreDTO.class);	
			if (multipartFile != null) {
				@SuppressWarnings("rawtypes")
				Map r = this.cloudinary.uploader().upload(multipartFile.getBytes(),
		                  ObjectUtils.asMap("resource_type", "auto"));
				String img = (String) r.get("secure_url");
				storeDTO.setImage(img);
			}
			return ResponseEntity.ok(storeService.save(storeDTO));
		} catch (Exception e) {
			return ResponseEntity.ok(null);
		}
	}
	
	@GetMapping("/api/user/favourite-store")
	public ResponseEntity<List<StoreDTO>> findFavourites() {
		List<StoreDTO> storeDTOs = storeService.findFavouriteStoresByCustomerId(ConstantsUtil.userDTO.getId());
		return ResponseEntity.ok(storeDTOs);
	}
	
	@PostMapping("/api/user/favourite-store")
	public ResponseEntity<Boolean> addFavourites(@RequestBody FavouriteStoreRequest favouriteStoreRequest) {
		favouriteStoreRequest.setCustomerId(ConstantsUtil.userDTO.getId());
		return ResponseEntity.ok(storeService.saveFavouriteStore(favouriteStoreRequest));
	}
	
	@DeleteMapping("/api/user/favourite-store")
	public ResponseEntity<Boolean> removeFavourites(@RequestParam(name = "storeId") int storeId) {
		FavouriteStoreRequest favouriteStoreRequest = new FavouriteStoreRequest();
		favouriteStoreRequest.setCustomerId(ConstantsUtil.userDTO.getId());
		favouriteStoreRequest.setStoreId(storeId);
		return ResponseEntity.ok(storeService.deleteFavouriteStore(favouriteStoreRequest));
	}
}
