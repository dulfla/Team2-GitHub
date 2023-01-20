package spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import spring.exception.AlreadyExistingMemberException;
import spring.exception.MemberNotFoundException;
import spring.service.FindPasswordService;
import spring.service.MailSendService;
import spring.vo.FindPasswordCommand;

@Controller
public class FindPasswordController {

	
	@Autowired
	private MailSendService mailSendService;
	
	@Autowired
	private FindPasswordService findPasswordService;
	
	@GetMapping("findPassword")
	public String findPassword() {
		
		return "edit/findPassword";
	}
	
	@PostMapping("findPasswordAuth")
	@ResponseBody
	public int findPasswordAuth(@RequestBody FindPasswordCommand findPwdCmd, Model model) {
		
		try {
			int getKey = mailSendService.key;
			System.out.println("테스트키 : "+mailSendService.key);
			findPasswordService.MailAuth(findPwdCmd, getKey);
			model.addAttribute("findPwdCmd",findPwdCmd.getEmail());
			return 0 ;
			
		}catch (AlreadyExistingMemberException e) {
			return 1;
			
		}catch (MemberNotFoundException e) {
			return 1;
		}
		
	}
	
	@GetMapping("mailAuthSuccess")
	public String mailAuthSuccess(Model model) {
		
		model.getAttribute("findPwdCmd");
		return "edit/findPasswordSuccess";
	}
	
}
