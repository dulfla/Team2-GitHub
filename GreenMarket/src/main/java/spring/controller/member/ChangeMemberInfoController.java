package spring.controller.member;

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
import spring.exception.RequiredException;
import spring.service.member.ChangeMemberInfoService;
import spring.vaildator.ChangeMemberInfoValidator;
import spring.vo.member.ChangeMemberInfoCommand;
import spring.vo.member.Member;

@RestController
public class ChangeMemberInfoController {
	
	@Autowired
	private ChangeMemberInfoService changeMemberInfoService;
	
	@PostMapping("updateName")
	public int updateName(@RequestBody ChangeMemberInfoCommand changeCommand ,HttpSession session,
				Errors errors) {
		new ChangeMemberInfoValidator().validate(changeCommand, errors);
		
		
		if(errors.hasErrors()) {
			// 에러 객체에 에러가 하나라도 검출이 되었다면
			return 0;
		}
		
		Member loginMember = (Member) session.getAttribute("member");
		
		if(loginMember.getName().equals(changeCommand.getName())) {
			return 2;
		}
		
		
		try {
			changeMemberInfoService.changeMember(changeCommand,loginMember.getEmail());
			return 1;

		}catch (AlreadyExistingMemberException e) {
			errors.rejectValue("name", "duplicate");
			
			return 0;
		}
		
	}
	
	
	@PostMapping("updateBirth")
	public int updateBirth(@RequestBody ChangeMemberInfoCommand changeCommand ,HttpSession session,
				Errors errors) {
		new ChangeMemberInfoValidator().validate(changeCommand, errors);
		
		
		/*
		 * if(errors.hasErrors()) { // 에러 객체에 에러가 하나라도 검출이 되었다면 return 0; }
		 */
		
		Member loginMember = (Member) session.getAttribute("member");
		
		if(loginMember.getBirth() == changeCommand.getBirth()) {
			return 2;
		}
		
		try {
			changeMemberInfoService.changeMember(changeCommand,loginMember.getEmail());
			return 1;

		}catch (AlreadyExistingMemberException e) {
			errors.rejectValue("birth", "required");
			
			return 0;
		}
		
	}
	
	@PostMapping("updatePhone")
	public int updatePhone(@RequestBody ChangeMemberInfoCommand changeCommand ,HttpSession session) {
		
		Member loginMember = (Member) session.getAttribute("member");
		
		try {
			changeMemberInfoService.changePhoneMember(changeCommand,loginMember);
			return 1;	
		}catch (RequiredException e) {
			return 0;
		}catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
		
	}
	
	@PostMapping("updateAddress")
	public int updateAddress(@RequestBody ChangeMemberInfoCommand changeCommand ,HttpSession session,
				Errors errors) {
		new ChangeMemberInfoValidator().validate(changeCommand, errors);
		
		
		if(errors.hasErrors()) {
			// 에러 객체에 에러가 하나라도 검출이 되었다면
			return 0;
		}
		
		Member loginMember = (Member) session.getAttribute("member");
		if(loginMember.getAddress().equals(changeCommand.getAddress())) {
			return 2;
		}
		
		changeMemberInfoService.changeMember(changeCommand,loginMember.getEmail());
		
		try {
			return 1;

		}catch (AlreadyExistingMemberException e) {
			errors.rejectValue("phone", "duplicate");
			
			return 0;
		}
		
	}
	
	@PostMapping("updateNickname")
	public int updateNickname(@RequestBody ChangeMemberInfoCommand changeCommand, Errors errors,HttpSession session) {
		new ChangeMemberInfoValidator().validate(changeCommand, errors);
		
		int result = changeMemberInfoService.getNicknameMember(changeCommand.getNickname());
		
		if(errors.hasErrors()) {
			// 에러 객체에 에러가 하나라도 검출이 되었다면
			System.out.println("에러");
			return 1;
		}
		
		Member loginMember = (Member) session.getAttribute("member");
		try {
			if(result == 1) {
				return result;

			}else {
				changeMemberInfoService.changeMember(changeCommand,loginMember.getEmail());
				System.out.println(result);
				return result;
			}
			
			
		}catch (AlreadyExistingMemberException e) {
			errors.rejectValue("nickname", "duplicate");
			
			return 1;
		}
		
	}
	
}
