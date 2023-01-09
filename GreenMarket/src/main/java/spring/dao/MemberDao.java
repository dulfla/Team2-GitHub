package spring.dao;

import java.util.List;

import spring.vo.CategoryVO;
import spring.vo.ProductVO;

public interface MemberDao {

	
	// 상품 등록
	public void productRegister(ProductVO vo);
	
	// 카테고리
	public List<CategoryVO> category();
}
