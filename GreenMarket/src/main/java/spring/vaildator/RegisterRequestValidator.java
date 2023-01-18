package spring.vaildator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import spring.vo.RegisterRequest;

public class RegisterRequestValidator implements Validator{
	
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
		
		// 실제 검증용 코드를 작성하는 부분
		// 이름은 입력이 되었는가?
		// 비밀번호와 비밀번호 확인은 입력이 되었는가?
		// 비밀번호와 비밀번호 확인의 값은 일치하는가?
		// 이메일은 입력이되었는가? => 이메일 형식은 맞는가?
		
		RegisterRequest regReq = (RegisterRequest)target;
		
		// 이메일 체크
		if(regReq.getEmail() == null || regReq.getEmail().trim().isEmpty()) {
			// 이메일이 입력이 되었는가?
			errors.rejectValue("email","required");
			// jsp 에러메시지 출력시 email이라는 속성에 required값을 전달 
		}else {
			// 이메일 형식은 맞는가?
			// pattern 객체, 정규식!
			Matcher matcher = pattern.matcher(regReq.getEmail());
			
			if(!matcher.matches()) {
				// 정규식과 패턴이 일치한다면 true, 일치하지 않는다면 false
				errors.rejectValue("email","bad");
			}
		}
		
		
		// 이름 체크
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "required");
		// target 객체에서 name 필드(getName())가 비어있거나 공백 문자인경우
		// name이라는 속성에 required값을 전달하는 errors 객체 반환
		
		// 비밀번호 체크
		ValidationUtils.rejectIfEmpty(errors, "password", "required");
		// 비밀번호 확인 체크
		ValidationUtils.rejectIfEmpty(errors, "confirmPassword", "required");
		
		//비밀번호와 비밀번호 확인이 같은 지 체크
		
		if(!regReq.isPasswordEqualToConfirmPassword()) {
			errors.rejectValue("confirmPassword", "nomatch");
			
		}
				
		 
		
		// 검증용 객체 => 어디서 검증??
		
	}
	
	
}
