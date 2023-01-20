package spring.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import oracle.jdbc.proxy.annotation.Post;
import spring.exception.AlreadyExistingMemberException;
import spring.exception.IdPasswordNotMatchingException;
import spring.service.MailSendService;
import spring.service.MemberWithDrawalService;
import spring.vo.MailAuthCommand;
import spring.vo.Member;

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
	
	@RequestMapping("deleteMember")
	public String deleteMember(HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		memberWithDrawalService.deleteMember(member);
		session.invalidate();
		return "index";
	}
	
	@PostMapping("memberWithDrawalPost")
	@ResponseBody
	public int memberWithDrawalPost(@RequestBody MailAuthCommand mailAuth ,HttpSession session) {
		
		try {
			
			int getKey = mailSendService.key;
			System.out.println("테스트키 : "+mailSendService.key);
			
			memberWithDrawalService.withDrawal(mailAuth,getKey);
			return 0;
		
		}catch (IdPasswordNotMatchingException e) {
			return 1;
		}catch (AlreadyExistingMemberException e) {
			return 2;
		}
		
	}

	
	
}
