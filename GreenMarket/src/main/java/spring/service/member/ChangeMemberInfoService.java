package spring.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.dao.member.MemberDao;
import spring.exception.AlreadyExistingMemberException;
import spring.exception.IdPasswordNotMatchingException;
import spring.exception.MemberNotFoundException;
import spring.exception.RequiredException;
import spring.vo.member.ChangeMemberInfoCommand;
import spring.vo.member.Member;

@Service
public class ChangeMemberInfoService {
	
	@Autowired
	private MemberDao dao;
	
	
	public void update(ChangeMemberInfoCommand changeCommand, String email) {
		Member updateMember = new
				Member(email,changeCommand.getBirth(),changeCommand.getAddress(),
						  changeCommand.getPhone(), changeCommand.getName(),changeCommand.getNickname());
				dao.updateMember(updateMember);
	}
	
	public void changePhoneMember(ChangeMemberInfoCommand changeCommand, String email, String phone) {
		
		if(changeCommand.getPhone().equals("") ||
				changeCommand.getPhone() == null) {
			throw new RequiredException();
		}
		
		if(changeCommand.getPhone().equals(phone)) {
			throw new AlreadyExistingMemberException("중복");
		}
		
		update(changeCommand,email);
	}

	public void changeNameMember(ChangeMemberInfoCommand changeCommand, String email, String name) {
		
		if(changeCommand.getName().equals("") ||
				changeCommand.getName() == null) {
			throw new RequiredException();
		}
		
		if(changeCommand.getName().equals(name)) {
			throw new AlreadyExistingMemberException("중복");
		}
		update(changeCommand,email);
	}

	public void changeBirthMember(ChangeMemberInfoCommand changeCommand, String email, int birth) {
		if(changeCommand.getBirth() == 0) {
			throw new RequiredException();
		}
		
		if(changeCommand.getBirth() == birth) {
			throw new AlreadyExistingMemberException("중복");
		}
		update(changeCommand,email);
	}

	public void changeAddressMember(ChangeMemberInfoCommand changeCommand, String email, String address) {
		
		if(changeCommand.getAddress().equals("") ||
			changeCommand.getAddress() == null) {
			throw new RequiredException();
		}
		
		if(changeCommand.getAddress().equals(address)) {
			throw new AlreadyExistingMemberException("중복");
		}
		
		update(changeCommand,email);
	}
	
	public void changeNickNameMember(ChangeMemberInfoCommand changeCommand, String email, String nickname) {
		int result = getNicknameMember(changeCommand.getNickname());
		
		if(changeCommand.getNickname().equals("")|| 
			changeCommand.getNickname() == null	) {
			throw new RequiredException();
		}
		
		if(result == 1) {
			throw new AlreadyExistingMemberException("중복");
		}
		
		update(changeCommand,email);
	}
	
	public int getEmailMember(String email) {
		return dao.getEmail(email);
	}

	public int getNicknameMember(String nickname) {
		return dao.getNickName(nickname);
	}

	
}
