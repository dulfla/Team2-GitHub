package spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import spring.vo.ProductListVO;
import spring.vo.ProductSellListVO;

public class MemberProductListDAO {

	private SqlSession sqlSession;
	
	public MemberProductListDAO(SqlSession sqlSession) {		
		this.sqlSession = sqlSession;
	}

	public List<ProductSellListVO> selectAllProductSellList(String mplc){
		return sqlSession.selectList("mybatis.mapper.productList.sellList",mplc);
	}
	
	public List<ProductListVO> selectAllProductBuyList(String mplc){
		return sqlSession.selectList("mybatis.mapper.productList.buyList",mplc);
	}
}
