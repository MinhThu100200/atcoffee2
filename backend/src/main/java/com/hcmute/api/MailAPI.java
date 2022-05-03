package com.hcmute.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.hcmute.pojo.Mail;
import com.hcmute.service.MailService;

@RestController
public class MailAPI {

	@Autowired
	private MailService mailService;
	
	@PostMapping("/api/user/sendmail")
	public ResponseEntity<Boolean> sendMail(@RequestBody Mail mail) {
		mailService.sendEmail(mail);
		return ResponseEntity.ok(true);
	}
}
