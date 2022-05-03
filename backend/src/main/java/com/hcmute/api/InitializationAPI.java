package com.hcmute.api;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hcmute.dto.CategoryDTO;
import com.hcmute.dto.PaymentDTO;
import com.hcmute.dto.RoleDTO;
import com.hcmute.dto.StoreDTO;
import com.hcmute.dto.TypeDTO;
import com.hcmute.dto.UserDTO;
import com.hcmute.service.CategoryService;
import com.hcmute.service.PaymentService;
import com.hcmute.service.RoleService;
import com.hcmute.service.StoreService;
import com.hcmute.service.TypeService;
import com.hcmute.service.UserService;

@RestController
public class InitializationAPI {
	
	@Autowired 
	private StoreService storeService;
	@Autowired
	private TypeService typeService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private UserService userService;
	@Autowired 
	private CategoryService categoryService;
	@Autowired
	private PaymentService paymentService;
	
	
	@PostMapping("/api/initialization")
	public ResponseEntity<Boolean> initialization(){
		boolean flag = true;
		try {
			if (storeService.findAll().isEmpty()) {
				StoreDTO store = new StoreDTO("AT_THUDUC", "A&T Coffee", "Thủ Đức, HCM", "8:00", "23:00");
				storeService.save(store);
				store = new StoreDTO("AT_DISTRICT2", "A&T Coffee", "Quận 2, Hồ Chí Minh", "8:00", "23:00");
				storeService.save(store);
			}
			if (typeService.findAll().isEmpty()) {
				TypeDTO type = new TypeDTO("BRONZE", "Đồng", 10000);
				typeService.save(type);
				type = new TypeDTO("GOLD", "Vàng", 50000);
				typeService.save(type);
				type = new TypeDTO("PLATINUM", "Bạch Kim", 125000);
				typeService.save(type);
			}
			if (roleService.findAll().isEmpty()) {
				RoleDTO role = new RoleDTO("ROLE_ADMIN", "ADMIN");
				roleService.save(role);
				role = new RoleDTO("ROLE_STAFF", "STAFF");
				roleService.save(role);
				role = new RoleDTO("ROLE_USER", "USER");
				roleService.save(role);
			}
			if(categoryService.findAll().isEmpty()) {
				CategoryDTO category = new CategoryDTO("COFFEE", "Cà phê");
				categoryService.save(category);
				category = new CategoryDTO("MILKTEA", "Trà sữa");
				categoryService.save(category);
				category = new CategoryDTO("DRINK", "Đồ uống");
				categoryService.save(category);
			}
			if (userService.findAll().isEmpty()) {
				Date dob = new Date();
				UserDTO user = new UserDTO("virtualuser", "virtualuser", "https://res.cloudinary.com/tranan2509/image/upload/v1637334237/male_d5nb3t.jpg", "Virtual User", "0000000000", "Nam",
						"virtualuser@gmail.com", "Không có địa chỉ", 0, 0, 1L, "USER");
				user.setCode("VIRTUAL_USER");
				userService.save(user);
				user = new UserDTO("admin", "admin", "https://res.cloudinary.com/tranan2509/image/upload/v1636107801/avatar_a9azml.png", "Trần Văn Ân", "01692889894", "Nam",
						"tranan2509@gmail.com", "9 Trình Hoài Đức, Quận 9", dob, "215523098", 1L, "ADMIN");
				user.setCode("AN_TV");
				userService.save(user);
				user = new UserDTO("staff", "staff", "https://res.cloudinary.com/tranan2509/image/upload/v1638505322/otx0l3euew6butlst5br.jpg", "Nguyễn Thị Minh Thư", "01692889893", "Nữ",
						"thuntm@gmail.com", "9 Trình Hoài Đức, Quận 9", dob, "215533098", 1L, "STAFF");
				user.setCode("THU_NTM");
				userService.save(user);
				
			}
			if(paymentService.findAll().isEmpty()) {
				PaymentDTO payment = new PaymentDTO("CASH", "Tiền mặt");
				paymentService.save(payment);
				payment = new PaymentDTO("CREDIT_CARD", "Thẻ tín dụng");
				paymentService.save(payment);
			}
		}catch (Exception e) {
			flag = false;
		}
		return new ResponseEntity<Boolean>(flag, HttpStatus.OK);
	}
}
