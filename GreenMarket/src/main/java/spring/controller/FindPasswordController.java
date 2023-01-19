package spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FindPasswordController {

	
	@GetMapping("findPassword")
	public String findPassword() {
		
		return "edit/findPassword";
	}
}
