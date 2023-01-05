package spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import oracle.jdbc.proxy.annotation.Post;
import spring.service.AuthService;
import spring.vo.AuthInfo;
import spring.vo.LoginCommand;
import spring.vo.Member;

@Controller
public class MemberController {
	
	private AuthService authService;
	
	public void setAuthService(AuthService authService) {
		this.authService = authService;
	}

	@GetMapping("register")
	public String memberRegister() { 
		return "member/register";
	}
	
	@GetMapping("login")
	public String memberLogin() {
		return "member/login";
	}
	
	@PostMapping("login")
	public String memberLoginPost(LoginCommand loginCommand,HttpSession session) {
		AuthInfo authInfo = authService.authenticate(loginCommand);
		session.setAttribute("authInfo", authInfo);
		return "index";
	}
}
