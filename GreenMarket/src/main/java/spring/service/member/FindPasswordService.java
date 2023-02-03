package spring.service.member;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.dao.member.MemberDao;
import spring.exception.AlreadyExistingMemberException;
import spring.exception.IdPasswordNotMatchingException;
import spring.exception.MemberNotFoundException;
import spring.vo.member.FindPasswordCommand;
import spring.vo.member.MailAuthCommand;
import spring.vo.member.Member;

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
		
		if(getKey != findPwdCmd.getAuthKey() || getKey == 0) {
			throw new AlreadyExistingMemberException("인증키 맞지않음");
		}
			
	}

	public void changePassword(FindPasswordCommand findPwdCmd) {
		Member member = dao.selectByEmail(findPwdCmd.getEmail());
		
		if(!findPwdCmd.getNewPassword().equals(findPwdCmd.getNewPassword2())) {
			throw new AlreadyExistingMemberException("비밀번호가 일치하지 않음");
		}
		member.changePassword(member.getPassword(), findPwdCmd.getNewPassword());
		
		dao.updatePassword(member);
	}
	
	
}
