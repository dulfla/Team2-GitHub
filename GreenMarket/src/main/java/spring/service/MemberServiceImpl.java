package spring.service;

import java.util.List;



import javax.inject.Inject;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Override
	public List<ProductImageVO> getImageList(String p_id) {	
		
		logger.info("getImageList");
		return dao.getImageList(p_id);
	}
	
	// 상품 수정
	@Override
	public void productModify(ProductVO vo) {		
		logger.info("상품 수정 service......................." + vo);
		
		dao.productModify(vo);
		
		if (vo.getImageList() != null && vo.getImageList().size() > 0) {
			
			dao.deleteImage(vo.getP_id());

			for(ProductImageVO attach : vo.getImageList()) {
			
				attach.setP_id(vo.getP_id());
				logger.info("deleteImageFor........" + attach);
				dao.modifyImage(attach);
			}	
		}
		
	}

	// 상품 삭제
	@Override
	public void productDelete(String p_id) {
		
		dao.deleteImage(p_id);		
		dao.productDelete(p_id);
	}
	// 상품 이미지 정보 얻기
	@Override
	public List<ProductImageVO> getImageInfo(String p_id) {
		logger.info("getImageInfo.............");
		return dao.getImageInfo(p_id);
	}
	
}
