package spring.dao;

import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import spring.service.MemberServiceImpl;
import spring.vo.CategoryVO;
import spring.vo.Product1VO;
import spring.vo.ProductImageVO;
import spring.vo.ProductVO;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(MemberDaoImpl.class);

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
	
	// 이미지 데이터 변환
	@Override
	public List<ProductImageVO> getImageList(String p_id) {
		return sqlSession.selectList("mybatis.mapper.member.productImage", p_id);
	}
		
	// 상품수정
	@Override
	public void productModify(ProductVO vo) {
		logger.info("상품 수정 Dao..........................." + vo);
		sqlSession.update("mybatis.mapper.member.productModify", vo);
	}
	
	// 상품 이미지 삭제
	@Override
	public void deleteImage(String p_id) {
		sqlSession.delete("mybatis.mapper.member.deleteImage", p_id);		
	}
	// 상푸 이미지 수정 업데이트
	@Override
	public void modifyImage(ProductImageVO vo) {
		sqlSession.insert("mybatis.mapper.member.modifyPic", vo);		
	}

	// 상품 삭제
	@Override
	public void productDelete(String p_id) {
		sqlSession.delete("mybatis.mapper.member.productDelete1", p_id);
		sqlSession.delete("mybatis.mapper.member.productDelete",p_id);			
	}

	// 상품 이미지 정보 얻기
	@Override
	public List<ProductImageVO> getImageInfo(String p_id) {
		return sqlSession.selectList("mybatis.mapper.member.getImageInfo",p_id);
	}
	
}
