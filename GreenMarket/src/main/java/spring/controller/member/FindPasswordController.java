package spring.controller.member;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import oracle.jdbc.proxy.annotation.Post;
import spring.exception.AlreadyExistingMemberException;
import spring.exception.MemberNotFoundException;
import spring.service.member.FindPasswordService;
import spring.service.member.MailSendService;
import spring.vo.member.FindPasswordCommand;

@Controller
public class FindPasswordController {

	
	@Autowired
	private MailSendService mailSendService;
	
	@Inject
	BCryptPasswordEncoder passwordEncoder;
	
	// 메일 확인키
	int authCheck = 0;
	
	@Autowired
	private FindPasswordService findPasswordService;
	
	@GetMapping("findPassword")
	public String findPassword() {
		
		return "edit/findPassword";
	}
	
	@PostMapping("findPasswordAuth")
	@ResponseBody
	public int findPasswordAuth(@RequestBody FindPasswordCommand findPwdCmd, Model model, HttpSession session) {
		
		try {
			int getKey = mailSendService.key;
			authCheck = 1;
			
			findPasswordService.MailAuth(findPwdCmd, getKey);
			model.addAttribute("findPwdCmd",findPwdCmd);
			session.setAttribute("findPwdCmd", findPwdCmd.getEmail());
			return 0 ;
			
		}catch (AlreadyExistingMemberException e) {
			return 1;
			
		}catch (MemberNotFoundException e) {
			return 1;
		}
		
	}
	
	@GetMapping("mailAuthSuccess")
	public String mailAuthSuccess() {
		if(authCheck == 1) {
			authCheck = 0;
			return "edit/findPasswordSuccess";
			
		}else {
			return "redirect:/index";
		}
		
	}
	
	@PostMapping("changePassword")
	@ResponseBody
	public int changePassword(@RequestBody FindPasswordCommand findPwdCmd, HttpSession session) {
		
		try {
			findPasswordService.changePassword(findPwdCmd);
			session.invalidate();
			return 0;
		}catch (AlreadyExistingMemberException e) {
			return 1;
		}
		
	}
	
}
