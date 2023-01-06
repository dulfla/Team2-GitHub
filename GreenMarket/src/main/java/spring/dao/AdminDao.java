package spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import spring.vo.CountVo;

public class AdminDao {

	private SqlSession sqlSession;
	public AdminDao(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<CountVo> countAllJoinMember() {
		return sqlSession.selectList("mybatis.mapper.admin.countAllMember");
	}

	public List<CountVo> countAllWithdrawMember() {
		return sqlSession.selectList("mybatis.mapper.admin.countAllWithdraw");
	}
	
}
