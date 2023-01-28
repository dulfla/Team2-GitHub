package spring.vaildator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import spring.vo.member.ChangeMemberInfoCommand;

public class ChangeMemberInfoValidator implements Validator{
	
	private static final String emailExp = // 정규 표현식
			"^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";
	
	private Pattern pattern = Pattern.compile(emailExp);
	// 자바, 정규표현식
	
	
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
