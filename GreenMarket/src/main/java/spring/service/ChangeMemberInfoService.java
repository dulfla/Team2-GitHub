package spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.dao.MemberDao;

@Service
public class ChangeMemberInfoService {
	
	@Autowired
	private MemberDao dao;
	
	public int getNickNameMember(String nickname) {
		System.out.println(nickname);
        return dao.getNickName(nickname);
    }
	
	
}
