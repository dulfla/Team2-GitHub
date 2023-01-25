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
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.productList.selectAll");
		for(int i=0;i<list.size();i++) {
			System.out.println(list.get(i).getFileName()==null);
			if(list.get(i).getFileName()==null) {
				list.get(i).setImgurl(null);
			}else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
				url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
				list.get(i).setImgurl(url);
			}
		}
//			String url = "";
//			url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
//			url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
//			list.get(i).setImgurl(url);
		return list;
	}
	
	public List<ProductListVO> selectAllBrandNew(){
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.productList.brandNew");
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getFileName()==null) {
				list.get(i).setImgurl(null);
			}else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
				url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
				list.get(i).setImgurl(url);
			}	
		}
		return list;
	}
	
	public List<ProductListVO> selectAllViewsLevel(){
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.productList.viewsLevel");
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getFileName()==null) {
				list.get(i).setImgurl(null);
			}else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
				url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
				list.get(i).setImgurl(url);
			}
		}
		return list;		
	}

	public List<ProductListVO> selectAllPriceHigh(){
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.productList.priceHigh");
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getFileName()==null) {
				list.get(i).setImgurl(null);
			}else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
				url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
				list.get(i).setImgurl(url);
			}
		}
		return list;
				
	}

	public List<ProductListVO> selectAllPriceLow(){
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.productList.priceLow");
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getFileName()==null) {
				list.get(i).setImgurl(null);
			}else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
				url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
				list.get(i).setImgurl(url);
			}
		}
		return list;
	}
	
	public List<ProductListVO> selectByCategory(String category){
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.productList.category", category);
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getFileName()==null) {
				list.get(i).setImgurl(null);
			}else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
				url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
				list.get(i).setImgurl(url);
			}
		}
		return list;
	}

	public List<ProductListVO> selectByCategoryBrandNew(String c) {
		
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.productList.cateBrandNew", c);
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getFileName()==null) {
				list.get(i).setImgurl(null);
			}else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
				url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
				list.get(i).setImgurl(url);
			}
		}
		return list;
	}

	public List<ProductListVO> selectByCategoryPriceLow(String c) {
		
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.productList.catePriceLow", c);
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getFileName()==null) {
				list.get(i).setImgurl(null);
			}else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
				url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
				list.get(i).setImgurl(url);
			}
		}
		return list;
	}

	public List<ProductListVO> selectByCategoryViewsLevel(String c) {
		
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.productList.cateViewsLevel", c);
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getFileName()==null) {
				list.get(i).setImgurl(null);
			}else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
				url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
				list.get(i).setImgurl(url);
			}
		}
		return list;
	}

	public List<ProductListVO> selectByCategoryPriceHigh(String c) {
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.productList.catePriceHigh", c);
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getFileName()==null) {
				list.get(i).setImgurl(null);
			}else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
				url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
				list.get(i).setImgurl(url);
			}
		}
		return list;
	}

}

				
