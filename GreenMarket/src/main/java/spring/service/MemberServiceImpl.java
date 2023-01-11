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
import spring.vo.ProductVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDaoImpl dao;
	
	
	// 상품등록
	@Override
	public void productRegister(ProductVO vo) {
		dao.productRegister(vo);
	}
	
	// 카테고리
	@Override
	public List<CategoryVO> category(){
		return dao.category();
	}

	@Override
	public ProductVO productDetail(String p_id) {
		return dao.productDetail(p_id);
	}
	
	
}
