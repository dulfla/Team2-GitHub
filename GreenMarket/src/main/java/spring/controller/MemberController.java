package spring.controller;

import java.awt.PageAttributes.MediaType;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@PostMapping(value = "postLogin",consumes="application/json")
	@ResponseBody
	public String memberLoginPost(@RequestBody LoginCommand loginCommand, HttpSession session,
			HttpServletResponse response, Errors errors) {

		new LoginCommandValidator().validate(loginCommand, errors);
		
		String result ;
		if (errors.hasErrors()) {
			result ="0";
		}

		try {
			AuthInfo authInfo = authService.authenticate(loginCommand);
			System.out.println(authInfo.getType());

			session.setAttribute("member", authInfo);
			result ="1";
		} catch (IdPasswordNotMatchingException e) {
			result ="0";
		}
		return result;
	}
	
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {

		session.invalidate();

		return "redirect:/index";

	}


}
