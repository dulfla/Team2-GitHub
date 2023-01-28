package spring.dao.product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import spring.vo.product.CategoryPagingVO;
import spring.vo.product.PagingInfoVO;
import spring.vo.product.ProductListVO;

public class ProductListDAO { //DAO 쿼리문으로 데이터 소환(담은걸 받아서 전달, 데이터베이스와 연결할 역할)

	private ProductListDAO() {}
	private static ProductListDAO dao = new ProductListDAO();
	
	// 7)
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
		return sqlSession.selectOne("mybatis.mapper.productList.countCategory",c);
	}
	
	
	
	
}

				
