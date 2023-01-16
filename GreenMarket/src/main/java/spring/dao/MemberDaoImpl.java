package spring.dao;

import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import spring.vo.CategoryVO;
import spring.vo.Product1VO;
import spring.vo.ProductImageVO;
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
	@Override
	public void productRegister1(Product1VO vo1) {
		sqlSession.insert("mybatis.mapper.member.product", vo1);
	}
	
	// 사진등록
	@Override
	public void imageRegister(ProductImageVO vo) {
		sqlSession.insert("mybatis.mapper.member.productPic", vo);
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
	
	// 이미지 데이터 반환
	@Override
	public List<ProductImageVO> ProductImage(String p_id) {
		return sqlSession.selectList("mybatis.mapper.member.productImage", p_id);
	}
	
	// 상품수정
	@Override
	public void productModify(ProductVO vo) {
		sqlSession.update("mybatis.mapper.member.productModify", vo);
	}


	// 상품 삭제
	@Override
	public void productDelete(String p_id) {
		sqlSession.delete("mybatis.mapper.member.productDelete1", p_id);
		sqlSession.delete("mybatis.mapper.member.productDelete",p_id);
			
	}














	
}
