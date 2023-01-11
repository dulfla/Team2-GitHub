package spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberDetailController {

	@GetMapping("memberDetail")
	public String memberDetail() {
		
		return "member/memberDetail";
	}
	
	@GetMapping("changeMemberInfo")
	public String changeMemberInfo() {
		
		return "member/changeMemberInfo";
	}
	
}
