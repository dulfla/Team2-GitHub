package spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import spring.dao.MemberDao;
import spring.exception.MemberNotFoundException;
import spring.vo.Member;

@Controller
public class MemberDetailController {
	
	@Autowired
	private MemberDao memberDao;
	
	
	
	@GetMapping("memberDetail")
	public String memberDetail() {
		
		return "member/memberDetail";
	}
	
	@GetMapping("changeMemberInfo")
	public String changeMemberInfo() {
		
		return "member/changeMemberInfo";
	}
	
}
