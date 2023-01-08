package spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import spring.vo.CountByMonthVo;
import spring.vo.CountByYearVo;

public class AdminDao {

	private SqlSession sqlSession;
	public AdminDao(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<String> memberAdminYears() { // 가입 기록이나 탈퇴 기록이 있는 년도
		return sqlSession.selectList("mybatis.mapper.admin.selectMemberAdminYears");
	}

	public List<CountByYearVo> countAllMemberYear() { // 년도별 누적 회원수
		return sqlSession.selectList("mybatis.mapper.admin.countAllMemberYear");
	}

	public List<CountByYearVo> countJoinMemberYear() { // 년도별 가입 건수
		return sqlSession.selectList("mybatis.mapper.admin.countJoinMemberYear");
	}
	
	public List<CountByYearVo> countWithdrawMemberYear() { // 년도별 탈퇴 건수
		return sqlSession.selectList("mybatis.mapper.admin.countWithdrawMemberYear");
	}
	
	public List<CountByMonthVo> countJoinMemberMonth() { // 월별 가입 건수
		return sqlSession.selectList("mybatis.mapper.admin.countJoinMemberMonth");
	}

	public List<CountByMonthVo> countWithdrawMemberMonth() { // 월별 탈퇴 건수
		return sqlSession.selectList("mybatis.mapper.admin.countWithdrawMemberMonth");
	}
	
}
