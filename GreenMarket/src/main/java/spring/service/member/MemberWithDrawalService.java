package spring.service.member;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import spring.dao.member.MemberDao;
import spring.exception.AlreadyExistingMemberException;
import spring.exception.IdPasswordNotMatchingException;
import spring.vo.member.MailAuthCommand;
import spring.vo.member.Member;

@Service
public class MemberWithDrawalService {
	
	
	@Autowired
	private MemberDao dao;
	
	@Inject
	private MailSendService mailSendService;
	
	@Transactional
	public void withDrawal(MailAuthCommand mailAuth, int getKey) {
		
		Member member = dao.selectByEmail(mailAuth.getEmail());
		if(!member.getPassword().equals(mailAuth.getPassword())) {
			throw new IdPasswordNotMatchingException();

		}
		
		System.out.println(mailAuth.getAuthKey());
		
		if(getKey != mailAuth.getAuthKey() || getKey == 0) {
			throw new AlreadyExistingMemberException("인증키 맞지않음");
		}
		
	}

	public void deleteMember(Member member2) {
		Member member = dao.selectByEmail(member2.getEmail());
		dao.deleteMember(member);
	}
	
	
	
	
}
