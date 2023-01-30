package spring.service.member;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import spring.dao.member.MemberDao;
import spring.exception.IdNotMatchingException;
import spring.exception.IdPasswordNotMatchingException;
import spring.vo.member.AuthInfo;
import spring.vo.member.LoginCommand;
import spring.vo.member.Member;
import spring.vo.member.NaverCommand;

@Service
public class AuthService { // 실제 로그인 기능을 담당할 객체
	
	@Autowired
	private MemberDao memberDao;

	public AuthInfo authenticate(LoginCommand lc) {
		
		Member member = memberDao.selectByEmail(lc.getEmail());
		
		if(member == null) {
			throw new IdPasswordNotMatchingException();
		}
		
		if(!member.getPassword().equals(lc.getPassword())) {
			throw new IdPasswordNotMatchingException();
		}
		
		AuthInfo authInfo = new AuthInfo()
				.setNickname(member.getNickname())
				.setEmail(member.getEmail())
				.setName(member.getName())
				.setType(member.getType());
		
		return authInfo;
	}

	public AuthInfo naverAuthenticate(NaverCommand naverCommand) {
		Member member = memberDao.selectByEmail(naverCommand.getN_email());
		//System.out.println(member.getEmail());
		
		  if(member == null) { 
			  throw new IdNotMatchingException(); 
		}
		 
		
		AuthInfo authInfo = new AuthInfo()
				.setNickname(member.getNickname())
				.setEmail(member.getEmail())
				.setName(member.getName())
				.setType(member.getType());
		return authInfo;
	}
	
}
