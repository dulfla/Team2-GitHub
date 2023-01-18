package spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import spring.vo.CategoryVO;
import spring.vo.Product1VO;
import spring.vo.ProductImageVO;
import spring.vo.ProductVO;

public interface MemberDaoInterface {
		
	// 상품 등록
	public void productRegister(ProductVO vo);
	public void productRegister1(Product1VO vo1);
	
	// 사진 등록
	public void imageRegister(ProductImageVO vo);
	
	// 카테고리
	public List<CategoryVO> category();
		
	// 상품 조회
	public ProductVO productDetail(String p_id);
	
	// 이미지 데이터 반환
	public List<ProductImageVO> getImageList(String p_id);
	
	// 상품 수정
	public void productModify(ProductVO vo);
	
	// 상품 이미지 삭제
	public void deleteImage(String p_id);
	
	// 상푸 이미지 수정 업데이트
	public void modifyImage(ProductImageVO vo);

	// 상품 삭제
	public void productDelete(String p_id);
	
	// 상품 이미지 정보 얻기
	public List<ProductImageVO> getImageInfo(String p_id);

}
