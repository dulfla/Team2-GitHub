package spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberWithDrawal {

	@GetMapping("memberWithDrawal")
	public String memberWithDrawal() {
		return "member/memberWithDrawal";
	}
}
