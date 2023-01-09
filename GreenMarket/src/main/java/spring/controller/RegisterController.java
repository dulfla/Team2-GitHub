package spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import spring.exception.AlreadyExistingMemberException;
import spring.service.RegisterService;
import spring.vaildator.RegisterRequestValidator;
import spring.vo.RegisterRequest;

@Controller
public class RegisterController {
	
	
	@Autowired
	private RegisterService registerService;
	
	
	@GetMapping("register")
	public String memberRegister() {
		return "member/register";
	}
	
	@PostMapping("registerPost")
	public String memberRegisterPost(@ModelAttribute("formData")  RegisterRequest regReq ,Errors errors) {
		new RegisterRequestValidator().validate(regReq, errors);
		
		if(errors.hasErrors()) {
			// 에러 객체에 에러가 하나라도 검출이 되었다면
			return "member/register"; 
		}
		
		
		//받아온 데이터를 DB에 저장
		try {
			registerService.regist(regReq);
			return "member/login";

		}catch (AlreadyExistingMemberException e) {
			errors.rejectValue("email", "duplicate");
			return "member/register";
		}
	}
	
}
