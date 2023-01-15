package spring.controller;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import spring.service.ChangeMemberInfoService;
import spring.vo.Member;

@RestController
public class ChangeMemberInfoController {
	
	@Autowired
	private ChangeMemberInfoService changeMemberInfoService;
	
	@PostMapping("updateName")
	public String updateName() {
		System.out.println("테스트");	
			
		return null;
	}
	
	
	public String changeNickname() {
		
		
		
		return null;
	}
	
	
}
