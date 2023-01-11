package spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import spring.vo.CategoryVO;
import spring.vo.ProductVO;

@Repository
public class MemberDaoImpl implements MemberDao{

	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 상품등록
	@Override
	public void productRegister(ProductVO vo) {

		sqlSession.insert("mybatis.mapper.member.productReg", vo);
	}

	// 카테고리
	@Override
	public List<CategoryVO> category() {
		
		return sqlSession.selectList("mybatis.mapper.member.category");
	}

	// 상품조회
	@Override
	public ProductVO productDetail(String p_id) {
		return sqlSession.selectOne("mybatis.mapper.member.productDetail", p_id);
	}


	
}
