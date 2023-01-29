package spring.dao.member;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.vo.member.Member;

@Repository
public class MemberDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	String nameSpace = "mybatis.mapper.member.";
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public Member selectByEmail(String email) {
		System.out.println("테스트 : "+email);
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
		sqlSession.update(nameSpace+"updateEmail",updateMember);
		
	}


	public void updatePassword(Member member) {
		sqlSession.update(nameSpace+"updatePassword",member);
	}


	public void deleteMember(Member member) {
		sqlSession.delete(nameSpace+"deleteMember",member);
	}
}