package spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.vo.ChangeMemberInfoCommand;
import spring.vo.Member;

@Repository
public class MemberDao {
	@Autowired
	private SqlSession sqlSession;
	
	String nameSpace = "mybatis.mapper.member.";
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public Member selectByEmail(String email) {
		System.out.println(email);
		return sqlSession.selectOne(nameSpace+"selectByEmail",email);	
	}
	
	public void insertMember(Member m) {
		sqlSession.insert(nameSpace+"insertMember",m);
	}
	
	public void updateMember(Member updateMember) {
		sqlSession.update(nameSpace+"updateMember",updateMember);
	}
	
	
	public int getNickName(String nickname) {
		return sqlSession.selectOne(nameSpace+"getNickName",nickname);
	}

	public int getEmail(String email) {
		
		return sqlSession.selectOne(nameSpace+"getEmail",email);
	}

	public void updateEmail(Member updateMember) {
		System.out.println(updateMember.getEmail());
		sqlSession.update(nameSpace+"updateEmail",updateMember);
		
	}


	public void updatePassword(Member member) {
		System.out.println();
		sqlSession.update(nameSpace+"updatePassword",member);
	}
}