package spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import spring.vo.ProductListVO;

public class ProductListDAO {

	private SqlSession sqlSession;

	public ProductListDAO(SqlSession sqlSession) {
	
		this.sqlSession = sqlSession;
	}
	
	public List<ProductListVO> selectAllProduct(){
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.productList.selectAll");
		
		return list;
	}
}
