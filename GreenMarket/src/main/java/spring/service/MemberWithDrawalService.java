package spring.service;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.dao.MemberDao;
import spring.exception.AlreadyExistingMemberException;
import spring.exception.IdPasswordNotMatchingException;
import spring.vo.MailAuthCommand;
import spring.vo.Member;

@Service
public class MemberWithDrawalService {
	
	
	@Autowired
	private MemberDao dao;
	
	@Inject
	private MailSendService mailSendService;
	
	public void withDrawal(MailAuthCommand mailAuth, int getKey) {
		
		Member member = dao.selectByEmail(mailAuth.getEmail());
		if(!member.getPassword().equals(mailAuth.getPassword())) {
			throw new IdPasswordNotMatchingException();

		}
		
		System.out.println(mailAuth.getAuthKey());
		
		if(getKey != mailAuth.getAuthKey() || getKey == 0) {
			throw new AlreadyExistingMemberException("인증키 맞지않음");
		}
		
		dao.deleteMember(member);
	}
	
	
	
	
}
