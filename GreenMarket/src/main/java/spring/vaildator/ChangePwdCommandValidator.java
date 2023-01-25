package spring.vaildator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import spring.vo.member.ChangePwdCommand;

public class ChangePwdCommandValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		
		return ChangePwdCommand.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		// 실제 검증하는 코드
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "currentPassword", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "newPassword", "required");
		
		ChangePwdCommand cpc = (ChangePwdCommand)target;
		
		if(cpc.getCurrentPassword() != null && !cpc.getCurrentPassword().trim().isEmpty()) {
			if(cpc.getCurrentPassword().equals(cpc.getNewPassword())) {
				errors.reject("passwordMatchingFail");
			}
		}
		
		
	}

	
}
