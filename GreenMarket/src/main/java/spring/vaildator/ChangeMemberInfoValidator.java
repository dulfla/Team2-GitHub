package spring.vaildator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import spring.vo.ChangeMemberInfoCommand;

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
		
		if(changeCommand.getEmail() == null || changeCommand.getEmail().trim().isEmpty()) {
			errors.rejectValue("email","required");
		}else{
			Matcher matcher = pattern.matcher(changeCommand.getEmail());
			if(!matcher.matches()) {
				// 정규식과 패턴이 일치한다면 true, 일치하지 않는다면 false
				errors.rejectValue("email","bad");
			}
		}
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "birth", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "phone", "required");
		ValidationUtils.rejectIfEmpty(errors, "address", "required");
	}

}
