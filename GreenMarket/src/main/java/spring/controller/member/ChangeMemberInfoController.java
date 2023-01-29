package spring.controller.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import spring.exception.AlreadyExistingMemberException;
import spring.exception.RequiredException;
import spring.service.member.ChangeMemberInfoService;
import spring.vo.member.ChangeMemberInfoCommand;
import spring.vo.member.Member;

@RestController
public class ChangeMemberInfoController {
	
	@Autowired
	private ChangeMemberInfoService changeMemberInfoService;
	
	@PostMapping("updateName")
	public int updateName(@RequestBody ChangeMemberInfoCommand changeCommand ,HttpSession session) {
		
		Member loginMember = (Member) session.getAttribute("member");
		
		try {
			changeMemberInfoService.changeNameMember(changeCommand,loginMember.getEmail(),loginMember.getName());
			return 1;

		}catch (RequiredException e) {
			
			return 0;
		}catch (AlreadyExistingMemberException e){
			return 2;
		}
		
	}
	
	
	@PostMapping("updateBirth")
	public int updateBirth(@RequestBody ChangeMemberInfoCommand changeCommand ,HttpSession session) {
		
		Member loginMember = (Member) session.getAttribute("member");
		
		try {
			changeMemberInfoService.changeBirthMember(changeCommand,loginMember.getEmail(),loginMember.getBirth());
			return 1;

		}catch (RequiredException e) {
			return 0;
		}catch (AlreadyExistingMemberException e) {
			return 2;
		}catch (Exception e) {
			return 2;
		}
		
	}
	
	@PostMapping("updatePhone")
	public int updatePhone(@RequestBody ChangeMemberInfoCommand changeCommand ,HttpSession session) {
		
		Member loginMember = (Member) session.getAttribute("member");
		
		try {
			changeMemberInfoService.changePhoneMember(changeCommand,loginMember.getEmail(),loginMember.getPhone());
			return 1;	
		}catch (RequiredException e) {
			return 0;
		}catch (AlreadyExistingMemberException e) {
			
			return 2;
		}
		
	}
	
	@PostMapping("updateAddress")
	public int updateAddress(@RequestBody ChangeMemberInfoCommand changeCommand ,HttpSession session) {
		
		Member loginMember = (Member) session.getAttribute("member");
		
		try {
			changeMemberInfoService.changeAddressMember(changeCommand,loginMember.getEmail(),loginMember.getAddress());
			return 1;

		}catch (RequiredException e) {
			
			return 0;
		}catch (AlreadyExistingMemberException e) {
			return 2;
		}
		
	}
	
	@PostMapping("updateNickname")
	public int updateNickname(@RequestBody ChangeMemberInfoCommand changeCommand, HttpSession session) {
		
		Member loginMember = (Member) session.getAttribute("member");
		try {
			changeMemberInfoService.changeNickNameMember(changeCommand,loginMember.getEmail(),loginMember.getNickname());
			return 0;
			
		
		}catch (RequiredException e) {
			return 2;
		}
		catch (AlreadyExistingMemberException e) {
			
			return 1;
		}
		
	}
	
}
