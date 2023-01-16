package spring.controller;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import spring.exception.AlreadyExistingMemberException;
import spring.service.ChangeMemberInfoService;
import spring.vaildator.ChangeMemberInfoValidator;
import spring.vo.ChangeMemberInfoCommand;
import spring.vo.Member;

@RestController
public class ChangeMemberInfoController {
	
	@Autowired
	private ChangeMemberInfoService changeMemberInfoService;
	
	@PostMapping("updateName")
	public Member updateName(@RequestBody ChangeMemberInfoCommand changeCommand ,HttpSession session,
				Errors errors) {
		new ChangeMemberInfoValidator().validate(changeCommand, errors);
		if(errors.hasErrors()) {
			// 에러 객체에 에러가 하나라도 검출이 되었다면
			return null;
		}
		
		Member loginMember = (Member) session.getAttribute("member");
		changeMemberInfoService.changeMember(changeCommand);
		
		try {
			return loginMember;

		}catch (AlreadyExistingMemberException e) {
			errors.rejectValue("name", "duplicate");
			
			return null;
		}
		
		
		
		
	}
	
	
	public String changeNickname() {
		
		
		
		return null;
	}
	
	
}
