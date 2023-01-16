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
	
	public List<Member> selectAll(){
		return sqlSession.selectList(nameSpace+"selectAll");
	}
	
	public Member selectByEmail(String email) {
		System.out.println(email);
		return sqlSession.selectOne(nameSpace+"selectByEmail",email);	
	}
	
	public Member selectByName(String name) {
		System.out.println(name);
		return sqlSession.selectOne(nameSpace+"selectByEmail",name);	
	}
	
	
	public void insertMember(Member m) {
		sqlSession.insert(nameSpace+"insertMember",m);
	}
	
	public void update(Member updateMember) {
		System.out.println(updateMember.getName());
		System.out.println(updateMember.getEmail());
		System.out.println(updateMember.getAddress());
		System.out.println(updateMember.getNickname());
		System.out.println(updateMember.getPhone());
		sqlSession.update(nameSpace+"updateMember",updateMember);
	}
	
	
	public int getNickName(String nickname) {
		return sqlSession.selectOne(nameSpace+"getNickName",nickname);
	}

	public int getEmail(String email) {
		
		return sqlSession.selectOne(nameSpace+"getEmail",email);
	}

}
