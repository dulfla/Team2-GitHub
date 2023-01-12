package spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import spring.service.ChangeMemberInfoService;
import spring.vo.Member;

@Controller
public class ChangeMemberInfoController {
	
	@Autowired
	private ChangeMemberInfoService changeMemberInfoService;
	
	@GetMapping("changeMemberInfo")
	public String changeMemberInfo(String email) {
		System.out.println(email);
		return "member/changeMemberInfo";
	}
	
	
	public String changeNicknameCheck() {
		
		
		
		return null;
	}
	
	
}
