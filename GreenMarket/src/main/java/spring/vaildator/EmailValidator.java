package spring.vaildator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import spring.vo.RegisterRequest;

public class EmailValidator implements Validator{
	
	private static final String emailExp = // 정규 표현식
			"^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";
	private Pattern pattern = Pattern.compile(emailExp);
	// 자바, 정규표현식
	
	@Override
	public boolean supports(Class<?> clazz) {
		// 전달받은 객체가 커맨드 객체가 맞는 지, 변환은 가능한지 체크 
		return RegisterRequest.class.isAssignableFrom(clazz);
	}
	
	
	@Override
	public void validate(Object target, Errors errors) {
		
		RegisterRequest regReq = (RegisterRequest)target;
		
		
		if(regReq.getEmail() == null || regReq.getEmail().trim().isEmpty()) {
			
			errors.rejectValue("email","required");
		}else {
			// 이메일 형식은 맞는가?
			// pattern 객체, 정규식!
			Matcher matcher = pattern.matcher(regReq.getEmail());
			
			if(!matcher.matches()) {
				// 정규식과 패턴이 일치한다면 true, 일치하지 않는다면 false
				errors.rejectValue("email","bad");
			}
		}
		
	}

}
