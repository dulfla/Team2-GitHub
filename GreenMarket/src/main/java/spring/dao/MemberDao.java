package spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
	public int count() {
		return sqlSession.selectOne(nameSpace+"selectCount");	
	}
	
	public void insertMember(Member m) {
		sqlSession.insert(nameSpace+"insertMember",m);
	}

	public int getNickName(String nickname) {
		return sqlSession.selectOne(nameSpace+"getNickName",nickname);
	}

	public int getEmail(String email) {
		
		return sqlSession.selectOne(nameSpace+"getEmail",email);
	}

}
