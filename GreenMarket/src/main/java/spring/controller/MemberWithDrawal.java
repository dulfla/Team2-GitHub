package spring.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import oracle.jdbc.proxy.annotation.Post;
import spring.exception.AlreadyExistingMemberException;
import spring.exception.IdPasswordNotMatchingException;
import spring.service.MailSendService;
import spring.service.MemberWithDrawalService;
import spring.vo.MailAuthCommand;

@Controller
public class MemberWithDrawal {
	
	
	@Autowired
	private MemberWithDrawalService memberWithDrawalService;
	
	@Autowired
	private MailSendService mailSendService;
	
	
	@GetMapping("memberWithDrawal")
	public String memberWithDrawal() {
		
		return "edit/memberWithDrawal";
	}
	
	@PostMapping("memberWithDrawalPost")
	@ResponseBody
	public int memberWithDrawalPost(@RequestBody MailAuthCommand mailAuth ,HttpSession session) {
		
		
		try {
			
			System.out.println("테스트키 : "+mailSendService.key);
			int getKey = mailSendService.key;
			memberWithDrawalService.withDrawal(mailAuth,getKey);
			session.invalidate();
			return 0;
		
		}catch (IdPasswordNotMatchingException e) {
			return 1;
		}catch (AlreadyExistingMemberException e) {
			return 2;
		}
		
	}

	
	
}
