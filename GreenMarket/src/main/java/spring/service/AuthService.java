package spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.dao.MemberDao;
import spring.vo.AuthInfo;
import spring.vo.LoginCommand;
import spring.vo.Member;

@Service
public class AuthService { // 실제 로그인 기능을 담당할 객체

	private MemberDao memberDao;
	
	
	
	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	public AuthInfo authenticate(LoginCommand lc) {
		int result = 1;
		Member member = memberDao.selectByEmail(lc.getEmail()); 
		
		if(member == null) {
			result = 0;
		}
		
		// 로그인 성공
		//AuthInfo authInfo = new AuthInfo(member.getId(),member.getEmail(),member.getName());
		
		AuthInfo authInfo = new AuthInfo()
				.setNickname(member.getNickName())
				.setEmail(member.getEmail())
				.setName(member.getName());
		
		return authInfo;
	}
}
