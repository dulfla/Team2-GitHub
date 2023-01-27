package spring.service.member;

import java.util.List;


import org.springframework.stereotype.Service;

import spring.vo.product.CategoryVO;
import spring.vo.product.Product1VO;
import spring.vo.product.ProductImageVO;
import spring.vo.product.ProductVO;

public interface MemberService {

	// 상품등록
	public void productRegister(ProductVO vo, Product1VO vo1, List<ProductImageVO> imgs );
	
	// 카테고리
	public List<CategoryVO> category(); 
	
	// 상품조회
	public ProductVO productDetail(String p_id);
	
	// 이미지 데이터 변환
	public List<ProductImageVO> getImageList(String p_id);
	
	// 상품 수정
	public void productModify(ProductVO vo);
	
	// 상품 삭제
	public void productDelete(String p_id);
	
	// 상품 이미지 정보 얻기
	public List<ProductImageVO> getImageInfo(String p_id);
	
}
