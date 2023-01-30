package spring.dao.product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import spring.vo.product.PagingInfoVO;
import spring.vo.product.ProductListVO;

public class ProductListDAO {

	private SqlSession sqlSession;
	public ProductListDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<ProductListVO> selectAllProduct(PagingInfoVO pInfo){
		return sqlSession.selectList("mybatis.mapper.productList.selectAll", pInfo);
	}
	
	public List<ProductListVO> selectAllBrandNew(PagingInfoVO pInfo){
		return sqlSession.selectList("mybatis.mapper.productList.brandNew", pInfo);
	}
	
	public List<ProductListVO> selectAllViewsLevel(PagingInfoVO pInfo){
		return sqlSession.selectList("mybatis.mapper.productList.viewsLevel", pInfo);
	}

	public List<ProductListVO> selectAllPriceHigh(PagingInfoVO pInfo){
		return sqlSession.selectList("mybatis.mapper.productList.priceHigh",pInfo);
	}

	public List<ProductListVO> selectAllPriceLow(PagingInfoVO pInfo){
		return sqlSession.selectList("mybatis.mapper.productList.priceLow", pInfo);
	}
	
	public List<ProductListVO> selectByCategory(PagingInfoVO pInfo){
		return sqlSession.selectList("mybatis.mapper.productList.category", pInfo);
	}

	public List<ProductListVO> selectByCategoryBrandNew(PagingInfoVO pInfo) {
		return sqlSession.selectList("mybatis.mapper.productList.cateBrandNew", pInfo);
	}

	public List<ProductListVO> selectByCategoryPriceLow(PagingInfoVO pInfo) {
		return sqlSession.selectList("mybatis.mapper.productList.catePriceLow", pInfo);
	}

	public List<ProductListVO> selectByCategoryViewsLevel(PagingInfoVO pInfo) {
		return sqlSession.selectList("mybatis.mapper.productList.cateViewsLevel", pInfo);
	}

	public List<ProductListVO> selectByCategoryPriceHigh(PagingInfoVO pInfo) {
		return sqlSession.selectList("mybatis.mapper.productList.catePriceHigh", pInfo);
	}
	
	public int selectAllNumboard() {
		return sqlSession.selectOne("mybatis.mapper.productList.countProductNumber");
	}

	public int selectCateNumboard(String c) {
		return sqlSession.selectOne("mybatis.mapper.productList.countCategory", c);
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

	public int selectMyProductNumboard(String email) {
		return sqlSession.selectOne("mybatis.mapper.productList.countMyProductNumber", email);
	}
	
	public int selectMyUnSelledNumboard(String email) {
		return sqlSession.selectOne("mybatis.mapper.productList.countMyUnSelledNumber", email);
	}
	
	public int selectMySelledNumboard(String email) {
		return sqlSession.selectOne("mybatis.mapper.productList.countMySelledNumber", email);
	}
	
}

				
