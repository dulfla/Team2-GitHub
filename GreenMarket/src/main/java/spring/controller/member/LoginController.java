package spring.controller.member;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import spring.exception.IdPasswordNotMatchingException;
import spring.service.member.AuthService;
import spring.vaildator.LoginCommandValidator;
import spring.vo.member.AuthInfo;
import spring.vo.member.LoginCommand;
import spring.vo.member.Member;

@Controller
public class LoginController {
	
	
	@Autowired
	private AuthService authService;
	

	@GetMapping("login")
	public String memberLoginGet(HttpSession session) {
		Object result = (Object)session.getAttribute("authInfo");
		if(result != null ) {
			return "redirect:/index";
		}else {
			return "member/login";
		}
	}
	
	@PostMapping(value = "postLogin",consumes="application/json")
	@ResponseBody
	public AuthInfo memberLoginPost(@RequestBody LoginCommand loginCommand, HttpSession session,
			HttpServletResponse response, Errors errors) {

		new LoginCommandValidator().validate(loginCommand, errors);
		
		AuthInfo result; // ajax 반환받기 위한 변수
		
		if (errors.hasErrors()) {
			return null;
		}
		try {
			AuthInfo authInfo = authService.authenticate(loginCommand);
			
			session.setAttribute("authInfo", authInfo);
			result = authInfo;
		} catch (IdPasswordNotMatchingException e) {
			
			return null;
		}
		return result;
	}
	
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {

		session.invalidate();

		return "redirect:/index";

	}

}