package spring.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import jdk.nashorn.internal.runtime.logging.Logger;
import spring.dao.MemberDao;
import spring.dao.MemberDaoImpl;
import spring.vo.CategoryVO;
import spring.vo.Product1VO;
import spring.vo.ProductVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDaoImpl dao;
	
	
	// 상품등록
	@Override
	public void productRegister(ProductVO vo, Product1VO vo1) {
		dao.productRegister(vo);
		vo1.setProductId(vo.getProductId());
		dao.productRegister1(vo1);
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
