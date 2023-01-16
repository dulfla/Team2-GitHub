package spring.service;

import java.util.List;



import javax.inject.Inject;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import jdk.nashorn.internal.runtime.logging.Logger;
import spring.controller.ProductController;
import spring.dao.MemberDao;
import spring.dao.MemberDaoImpl;
import spring.vo.CategoryVO;
import spring.vo.Product1VO;
import spring.vo.ProductImageVO;
import spring.vo.ProductVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired
	private MemberDaoImpl dao;
	
	
	// 상품등록
	@Override
	public void productRegister(ProductVO vo, Product1VO vo1) {
		dao.productRegister(vo);
		vo1.setProductId(vo.getProductId());
		dao.productRegister1(vo1);
		
		if(vo.getImageList() == null || vo.getImageList().size() <= 0) {
			return;
		}	
		//향상된 for문
		for(ProductImageVO attach : vo.getImageList()) {
			attach.setProductId(vo.getProductId());
			
			dao.imageRegister(attach);
		}
		
		
//		vo.getImageList().forEach(attach ->{
//			
//			dao.imageRegister(attach);
//		});
	}
	
	// 카테고리
	@Override
	public List<CategoryVO> category(){
		return dao.category();
	}
	

	// 상품 조회
	@Override
	public ProductVO productDetail(String p_id) {
		return dao.productDetail(p_id);
	}
	
	// 이미지 데이터 변환
	@Override
	public List<ProductImageVO> ProductImage(String p_id) {
		
		logger.info("getProductImage................" + p_id);
		
		return dao.ProductImage(p_id);
	}
	
	// 상품 수정
	@Override
	public void productModify(ProductVO vo) {
		 dao.productModify(vo);	
	}

	// 상품 삭제
	@Override
	public void productDelete(String p_id) {
		dao.productDelete(p_id);
	}









	
	
}
