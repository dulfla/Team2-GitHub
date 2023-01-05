package spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@GetMapping("/register")
	public String memberRegister() { 
		return "member/register";
	}
	
	@GetMapping("/login")
	public String memberLogin() {
		return "member/login";
	}
	
	
}
