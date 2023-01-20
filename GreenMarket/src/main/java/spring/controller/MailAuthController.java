package spring.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import spring.service.MailSendService;

@Controller
public class MailAuthController {

	
	@Inject
	MailSendService mailSendService;
	
	
	
	@RequestMapping("mailAuth.wow")
	@ResponseBody
	public int mailAuth(String mail, HttpServletResponse resp) throws Exception {
	    int authKey = mailSendService.sendAuthMail(mail); //사용자가 입력한 메일주소로 메일을 보냄
	    
	    System.out.println("인증키 : "+authKey);
	    
	    return authKey;
	}
	
	
}
