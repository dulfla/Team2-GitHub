package spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.dao.MemberDao;
import spring.exception.AlreadyExistingMemberException;
import spring.vo.Member;
import spring.vo.RegisterRequest;

@Service
public class RegisterService { // 회원정보를 저장하기 위한 기능을 담당하는 클래스
	
	@Autowired
	private MemberDao dao;
	
	public void regist(RegisterRequest req) {
		Member member = dao.selectByEmail(req.getEmail());
		
		if(member != null) {
			throw new AlreadyExistingMemberException("계정 중복 : "+req.getEmail());
		}
		
		Member newMember = new Member(req.getEmail(),
				req.getPassword(), req.getBirth(),req.getAddress(),
				req.getPhone(),req.getName(), req.getNickname());
		
		dao.insertMember(newMember);
		
	}
	
}
