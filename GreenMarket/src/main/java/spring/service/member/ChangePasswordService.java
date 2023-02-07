package spring.service.member;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import spring.dao.member.MemberDao;
import spring.exception.AlreadyExistingMemberException;
import spring.exception.IdPasswordNotMatchingException;
import spring.exception.MemberNotFoundException;
import spring.vo.member.ChangePwdCommand;
import spring.vo.member.Member;

@Service
public class ChangePasswordService {
	
	@Autowired
	private MemberDao dao; 
	
	@Inject
	BCryptPasswordEncoder passwordEncoder;
	
	
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
		
		boolean matchPw = passwordEncoder.matches(changePwdCommand.getCurrentPassword(), member.getPassword());
		
		if(matchPw == false) {
			throw new IdPasswordNotMatchingException();
		}
		
		String currentPassword = member.getPassword();
		// 바꿀암호화 비밀번호
		String pwdBycrypt = passwordEncoder.encode(changePwdCommand.getNewPassword());
		
		member.changePassword(currentPassword, pwdBycrypt);
		
		dao.updatePassword(member); 
	}
}
