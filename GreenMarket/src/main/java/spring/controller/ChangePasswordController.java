package spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import spring.exception.IdPasswordNotMatchingException;
import spring.service.ChangePasswordService;
import spring.vaildator.ChangePwdCommandValidator;
import spring.vo.AuthInfo;
import spring.vo.ChangePwdCommand;

@Controller
public class ChangePasswordController {
	
	@Autowired
	private ChangePasswordService changePasswordSvc;
	
	
	@GetMapping("changePassword")
	public String changePassword() {
		
		return "member/changePassword";
	}
	
	
	@PostMapping("changePasswordPost")
	public int submit(@RequestBody ChangePwdCommand changePwdCommand, Errors errors,HttpSession session) {
		// 1.입력 값 검증
		new ChangePwdCommandValidator().validate(changePwdCommand, errors);
		
		if(errors.hasErrors()) { 
			return 1;
		}
		
		AuthInfo authInfo = (AuthInfo)session.getAttribute("authInfo"); // 이메일
		
		try {
			changePasswordSvc.changePassword(authInfo.getEmail()
					,changePwdCommand.getCurrentPassword() , changePwdCommand.getNewPassword());
			return 0;
		}catch (IdPasswordNotMatchingException e) {
			// 저장된 비밀번호가 입력된 현재 비밀번호가 일치하지 않을때
			errors.rejectValue("currentPassword", "notMatching");
			return 1;
		}
		
	}
	
	
	@PostMapping("confirmPassword")
	public int confirmPassword(@RequestBody ChangePwdCommand changePwdCommand) {
		int result = 0;
		if(changePwdCommand.getNewPassword().equals(changePwdCommand.getNewPassword2())) {
			result = 1;
		}
		
		return result;
	}
}
