package spring.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import spring.exception.IdPasswordNotMatchingException;
import spring.service.AuthService;
import spring.vaildator.LoginCommandValidator;
import spring.vo.AuthInfo;
import spring.vo.LoginCommand;

@RestController
public class LoginController {
	
	
	@Autowired
	private AuthService authService;
	

}
