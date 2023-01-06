package spring.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import oracle.jdbc.proxy.annotation.Post;
import spring.exception.IdPasswordNotMatchingException;
import spring.service.AuthService;
import spring.vaildator.LoginCommandValidator;
import spring.vo.AuthInfo;
import spring.vo.LoginCommand;
import spring.vo.Member;

@Controller
public class MemberController {
	
	@Autowired
	private AuthService authService;
	

	@GetMapping("register")
	public String memberRegister() { 
		return "member/register";
	}
	
	@GetMapping("login")
	public String memberLoginGet(LoginCommand loginCommand) {
		return "member/login";
	}
	
	@PostMapping("login")
	public String memberLoginPost(LoginCommand loginCommand,HttpSession session, Errors errors, HttpServletResponse response) {
		
		new LoginCommandValidator().validate(loginCommand, errors);
		
		if(errors.hasErrors()) {
			
			return "member/login";
		}
		
		try {
			
			AuthInfo authInfo = authService.authenticate(loginCommand);
			System.out.println(authInfo.getType());
			session.setAttribute("member", authInfo);
			return "index";
			
		}catch (IdPasswordNotMatchingException e) {
			
			errors.reject("idPasswordNotMatching");
			return "member/login";
		}
		
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/index";
		
	}
	
	/*
	 * @RequestMapping("loginCheck")
	 * 
	 * @ResponseBody public String loginCheck() {
	 * 
	 * }
	 */
	
}
