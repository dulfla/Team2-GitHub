package spring.dao.product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import spring.vo.member.AuthInfo;
import spring.vo.product.PagingInfoVO;
import spring.vo.product.ProductListVO;

public class MemberProductListDAO {

	private SqlSession sqlSession;
	
	public MemberProductListDAO(SqlSession sqlSession) {		
		this.sqlSession = sqlSession;
	}

	public List<ProductListVO> selectAllProductSellList(PagingInfoVO pInfo){
		return sqlSession.selectList("mybatis.mapper.productList.sellList", pInfo);
	}
	
	public List<ProductListVO> selectAllProductUnSellList(PagingInfoVO pInfo){
		return sqlSession.selectList("mybatis.mapper.productList.unSellList", pInfo);
	}
	
	public List<ProductListVO> selectAllProductBuyList(PagingInfoVO pInfo){
		return sqlSession.selectList("mybatis.mapper.productList.myProductList", pInfo);
		
	}	

	public int selectMyProductNumboard(String mplc) {
		return sqlSession.selectOne("mybatis.mapper.productList.countMyProductNumber",mplc);
	}
	
	public int selectMyUnSellNumboard(String mplc) {
		return sqlSession.selectOne("mybatis.mapper.productList.countMyUnSellNumber",mplc);
	}
	
	public int selectMySellNumboard(String mplc) {
		return sqlSession.selectOne("mybatis.mapper.productList.countMySellNumber",mplc);
	}

	
}
