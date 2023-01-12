package spring.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import spring.dao.MemberDao;
import spring.exception.IdPasswordNotMatchingException;
import spring.vo.AuthInfo;
import spring.vo.LoginCommand;
import spring.vo.Member;

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
}
