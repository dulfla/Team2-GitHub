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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import spring.exception.IdNotMatchingException;
import spring.exception.IdPasswordNotMatchingException;
import spring.service.member.AuthService;
import spring.service.member.RegisterService;
import spring.vaildator.LoginCommandValidator;
import spring.vo.member.AuthInfo;
import spring.vo.member.LoginCommand;
import spring.vo.member.Member;
import spring.vo.member.NaverCommand;

@Controller
public class LoginController {
	
	
	@Autowired
	private AuthService authService;
	
	@Autowired
	private RegisterService registerService;
	
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
		} catch (IdNotMatchingException e) {
			
			return null;
		}
		return result;
	}
	
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {

		session.invalidate();

		return "redirect:/index";

	}
	
	@RequestMapping(value="naverSave", method=RequestMethod.POST)
	@ResponseBody
	public String naverSave(@RequestBody NaverCommand naverCommand,HttpSession session) {
		Member naver = new Member();
	    
		// ajax에서 성공 결과에서 ok인지 no인지에 따라 다른 페이지에 갈 수 있게끔 result의 기본값을 "no"로 선언
		String result = "no";
		try {
			AuthInfo authInfo = authService.naverAuthenticate(naverCommand);
			session.setAttribute("authInfo", authInfo);
			// naver가 비어있지 않는다는건 데이터를 잘 받아왔다는 뜻이므로 result를 "ok"로 설정
			result = "ok";
		}catch (IdNotMatchingException e) {
			registerService.naverRegist(naverCommand);
			AuthInfo authInfo = authService.naverAuthenticate(naverCommand);
			session.setAttribute("authInfo", authInfo);
			result = "ok";
		}
		
		return result;
	    
	}

}
