package spring.service;

import java.util.List;

import org.springframework.stereotype.Service;

import spring.vo.CategoryVO;
import spring.vo.ProductVO;

public interface MemberService {

	// 상품등록
	public void productRegister(ProductVO product);
	
	// 카테고리
	public List<CategoryVO> category(); 
}
