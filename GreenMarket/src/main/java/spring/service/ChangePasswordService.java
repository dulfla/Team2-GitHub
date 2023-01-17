package spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import spring.dao.MemberDao;
import spring.exception.MemberNotFoundException;
import spring.vo.Member;

@Service
public class ChangePasswordService {
	
	@Autowired
	private MemberDao dao; //= new MemberDao();
	
	
	
	@Transactional // @Transactional가 붙은 메서드는 하나의 트랜젝션 영역 -> 논리적 기능의 단위
	public void changePassword(String email,String oldPassword, String newPassword) {
		
		Member member = dao.selectByEmail(email);
		if(member==null) {
			throw new MemberNotFoundException();
		}
		
		member.changePassword(oldPassword, newPassword);
		
		dao.updatePassword(member); 
	}
}
