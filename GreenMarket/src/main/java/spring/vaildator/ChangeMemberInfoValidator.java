package spring.vaildator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import spring.vo.member.ChangeMemberInfoCommand;

public class ChangeMemberInfoValidator implements Validator{
	
	
	@Override
	public boolean supports(Class<?> clazz) {
		
		return ChangeMemberInfoCommand.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		ChangeMemberInfoCommand changeCommand  = (ChangeMemberInfoCommand)target;
		
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "birth", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "phone", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "nickname", "required");
		ValidationUtils.rejectIfEmpty(errors, "address", "required");
	}

}
