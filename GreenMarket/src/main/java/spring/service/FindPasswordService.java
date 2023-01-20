package spring.service;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.dao.MemberDao;
import spring.exception.AlreadyExistingMemberException;
import spring.exception.IdPasswordNotMatchingException;
import spring.exception.MemberNotFoundException;
import spring.vo.FindPasswordCommand;
import spring.vo.MailAuthCommand;
import spring.vo.Member;

@Service
public class FindPasswordService {
	
	@Autowired
	private MemberDao dao;
	
	@Inject
	private MailSendService mailSendService;
	
	public void MailAuth(FindPasswordCommand findPwdCmd, int getKey) {
			
		Member member = dao.selectByEmail(findPwdCmd.getEmail());
		if(member == null) {
			throw new MemberNotFoundException();
		}
		
		System.out.println(findPwdCmd.getAuthKey());
		
		if(getKey != findPwdCmd.getAuthKey() || getKey == 0) {
			throw new AlreadyExistingMemberException("인증키 맞지않음");
		}
			
	}
	
	
}
