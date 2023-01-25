package spring.dao.product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import spring.vo.product.CategoryVO;
import spring.vo.product.Product1VO;
import spring.vo.product.ProductImageVO;
import spring.vo.product.ProductVO;

@Repository
public class ProductDaoImp implements ProductDao{
	
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(ProductDaoImp.class);

	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 상품등록
	@Override
	public void productRegister(ProductVO vo) {
		sqlSession.insert("mybatis.mapper.product.productReg", vo);
	}
	@Override
	public void productRegister1(Product1VO vo1) {
		sqlSession.insert("mybatis.mapper.product.product", vo1);
	}
	
	// 사진등록
	@Override
	public void imageRegister(ProductImageVO vo) {
		sqlSession.insert("mybatis.mapper.product.productPic", vo);		
	}

	// 카테고리
	@Override
	public List<CategoryVO> category() {		
		return sqlSession.selectList("mybatis.mapper.product.category");
	}

	// 조회수
	@Override
	public int modifyProductViews(String p_id) {
		return sqlSession.update("mybatis.mapper.product.modifyProductViews", p_id);
	}
	
	// 상품조회
	@Override
	public ProductVO productDetail(String p_id) {
		return sqlSession.selectOne("mybatis.mapper.product.productDetail", p_id);
	}
	
	// 이미지 데이터 변환
	@Override
	public List<ProductImageVO> getImageList(String p_id) {
		return sqlSession.selectList("mybatis.mapper.product.productImage", p_id);
	}
		
	// 상품수정
	@Override
	public void productModify(ProductVO vo) {
		logger.info("상품 수정 Dao..........................." + vo);
		sqlSession.update("mybatis.mapper.product.productModify", vo);
	}
	
	// 상품 이미지 삭제
	@Override
	public void deleteImage(String p_id) {
		sqlSession.delete("mybatis.mapper.product.deleteImage", p_id);		
	}
	// 상푸 이미지 수정 업데이트
	@Override
	public void modifyImage(ProductImageVO vo) {
		sqlSession.insert("mybatis.mapper.product.modifyPic", vo);		
	}

	// 상품 삭제
	@Override
	public void productDelete(String p_id) {
		sqlSession.delete("mybatis.mapper.product.productDelete1", p_id);
		sqlSession.delete("mybatis.mapper.product.productDelete",p_id);			
	}

	// 상품 이미지 정보 얻기
	@Override
	public List<ProductImageVO> getImageInfo(String p_id) {
		return sqlSession.selectList("mybatis.mapper.product.getImageInfo",p_id);
	}
	
}
