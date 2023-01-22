package spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import spring.dao.MemberDao;
import spring.exception.AlreadyExistingMemberException;
import spring.exception.MemberNotFoundException;
import spring.vo.ChangePwdCommand;
import spring.vo.Member;

@Service
public class ChangePasswordService {
	
	@Autowired
	private MemberDao dao; 
	
	
	
	@Transactional 
	public void changePassword(String email, ChangePwdCommand changePwdCommand) {
		
		Member member = dao.selectByEmail(email);
		if(member==null) {
			throw new MemberNotFoundException();
		}
		if(!changePwdCommand.getNewPassword().equals
				(changePwdCommand.getNewPassword2())) {
			throw new AlreadyExistingMemberException("비밀번호 일치하지않음");
		}
		
		member.changePassword(changePwdCommand.getCurrentPassword(), changePwdCommand.getNewPassword());
		
		dao.updatePassword(member); 
	}
}
