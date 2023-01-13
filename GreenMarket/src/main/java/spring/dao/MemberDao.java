package spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import spring.vo.CategoryVO;
import spring.vo.Product1VO;
import spring.vo.ProductVO;

public interface MemberDao {
		
	// 상품 등록
	public void productRegister(ProductVO vo);
	public void productRegister1(Product1VO vo1);
	
	// 카테고리
	public List<CategoryVO> category();
	
	// 상품 조회
	public ProductVO productDetail(String p_id);
	
	// 상품 수정
	public void productModify(ProductVO vo);
	
	// 상품 삭제
	public void productDelete(String p_id);
}
