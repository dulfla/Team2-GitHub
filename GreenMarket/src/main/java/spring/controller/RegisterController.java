package spring.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyEmitterReturnValueHandler;

import spring.exception.AlreadyExistingMemberException;
import spring.service.RegisterService;
import spring.vaildator.EmailValidator;
import spring.vaildator.RegisterRequestValidator;
import spring.vo.Member;
import spring.vo.RegisterRequest;

@Controller
public class RegisterController {
	
	
	@Autowired
	private RegisterService registerService;
	
	
	@GetMapping("register")
	public String memberRegister() {
		return "member/register";
	}
	
	@PostMapping(value = "registerPost",consumes="application/json")
	@ResponseBody
	public String memberRegisterPost(@RequestBody RegisterRequest regReq ,Errors errors) {
		new RegisterRequestValidator().validate(regReq, errors);
		
		String result;
		
		if(errors.hasErrors()) {
			result = "0"; 
		}
		
		
		//받아온 데이터를 DB에 저장
		try {
			registerService.regist(regReq);
			result = "1";

		}catch (AlreadyExistingMemberException e) {
			errors.rejectValue("email", "duplicate");
			result =  "0";
		}
		
		return result;
	}
	
	
	
	@ResponseBody
    @PostMapping(value="checkNickName",consumes="application/json")
    public int nickNameCheck(@RequestBody RegisterRequest regReq ) {
        int result = registerService.getNickNameMember(regReq.getNickname());
        return result;
    }
	
	@ResponseBody
	@PostMapping(value = "checkEmail", consumes="application/json")
	public int checkEmail(@RequestBody RegisterRequest regReq,
			HttpServletResponse response, Errors errors) {
		
		new EmailValidator().validate(regReq, errors);
		
		int result = registerService.getEmailMember(regReq.getEmail());
		
		
		if (errors.hasErrors()) { // 이메일 형식이 아님
			result = 2;
			System.out.println(result);
		}
		try {
			return result;
			 
		}catch(AlreadyExistingMemberException e) { //이메일이 중복되는 경우
			errors.rejectValue("email", "duplicate"); 
			System.out.println(errors);
			return result; 
		}		
				
	}
	
	@ResponseBody
	@PostMapping(value = "confirmPassword",consumes="application/json")
	public int confirmPassword(@RequestBody RegisterRequest regReq) {
		int result = 0;
		
		if(regReq.getPassword().equals(regReq.getConfirmPassword())) {
			result = 1;
		}
		
		return result;
	}
}
