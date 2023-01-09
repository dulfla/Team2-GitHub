package spring.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import jdk.nashorn.internal.runtime.logging.Logger;
import spring.dao.MemberDao;
import spring.vo.CategoryVO;
import spring.vo.ProductVO;

@Repository
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDao dao;
	
	
	@Override
	public void productRegister(ProductVO vo) {
		dao.productRegister(vo);
	}
	
	@Override
	public List<CategoryVO> category(){
		return dao.category();
	}
	
	
}
