package spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import oracle.jdbc.proxy.annotation.Post;

@Controller
public class MemberWithDrawal {

	@GetMapping("memberWithDrawal")
	public String memberWithDrawal() {
		return "edit/memberWithDrawal";
	}
	
	@PostMapping("memberWithDrawalPost")
	public String memberWithDrawalPost() {
		
		return null;
	}
	
	
}
