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
	private MemberDao dao; 
	
	
	
	@Transactional 
	public void changePassword(String email,String oldPassword, String newPassword) {
		
		Member member = dao.selectByEmail(email);
		if(member==null) {
			throw new MemberNotFoundException();
		}
		System.out.println(oldPassword);
		System.out.println(newPassword);
		
		member.changePassword(oldPassword, newPassword);
		
		dao.updatePassword(member); 
	}
}
