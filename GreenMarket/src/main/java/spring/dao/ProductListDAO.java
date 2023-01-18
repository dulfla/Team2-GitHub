package spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import spring.vo.ProductListVO;

public class ProductListDAO { //DAO 쿼리문으로 데이터 소환(담은걸 받아서 전달, 데이터베이스와 연결할 역할)

	// 7)
	private SqlSession sqlSession;

	public ProductListDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<ProductListVO> selectAllProduct(){
		return sqlSession.selectList("mybatis.mapper.productList.selectAll");
	}
	
	public List<ProductListVO> selectAllBrandNew(){
		return sqlSession.selectList("mybatis.mapper.productList.brandNew");
	}
	
	public List<ProductListVO> selectAllViewsLevel(){
		return sqlSession.selectList("mybatis.mapper.productList.viewsLevel");
	}

	public List<ProductListVO> selectAllPriceHigh(){
		return sqlSession.selectList("mybatis.mapper.productList.priceHigh");
	}

	public List<ProductListVO> selectAllPriceLow(){
		return sqlSession.selectList("mybatis.mapper.productList.priceLow");
	}
	
	public List<ProductListVO> selectAllCategory(String category){
		return sqlSession.selectList("mybatis.mapper.productList.category", category);
	}

}

				
