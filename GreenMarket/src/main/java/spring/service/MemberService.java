package spring.service;

import java.util.List;

import org.springframework.stereotype.Service;

import spring.vo.CategoryVO;
import spring.vo.Product1VO;
import spring.vo.ProductVO;

public interface MemberService {

	// 상품등록
	public void productRegister(ProductVO vo, Product1VO vo1);
	// 카테고리
	public List<CategoryVO> category(); 
	
	// 상품조회
	public ProductVO productDetail(String p_id);
	
	// 상품 삭제
	public void productDelete(String p_id);
}
