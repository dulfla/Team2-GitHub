package spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.dao.MemberDao;
import spring.exception.AlreadyExistingMemberException;
import spring.exception.IdPasswordNotMatchingException;
import spring.exception.MemberNotFoundException;
import spring.vo.ChangeMemberInfoCommand;
import spring.vo.Member;

@Service
public class ChangeMemberInfoService {
	
	@Autowired
	private MemberDao dao;
	
	public void changeMember(ChangeMemberInfoCommand changeCommand) {
		
		Member updateMember = new
		Member(changeCommand.getEmail(),changeCommand.getBirth(),changeCommand.getAddress(),
				  changeCommand.getPhone(), changeCommand.getName(),changeCommand.getNickname());
		
		dao.updateMember(updateMember);
    }

	public int getEmailMember(String email) {
		return dao.getEmail(email);
	}

	public int getNicknameMember(String nickname) {
		return dao.getNickName(nickname);
	}

	public void changeEmail(ChangeMemberInfoCommand changeCommand) {
		System.out.println(changeCommand.getEmail());	
		Member updateMember = new
				Member(changeCommand.getEmail(),changeCommand.getBirth(),changeCommand.getAddress(),
						  changeCommand.getPhone(), changeCommand.getName(),changeCommand.getNickname());
		
		dao.updateEmail(updateMember);
	}
	
	
}
