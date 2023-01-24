package spring.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.vo.CategoryVO;
import spring.vo.ProductListVO;

@Repository
public class SearchDao {

	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}


	public List<ProductListVO> searchAll(String search) {
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.searchAll", search);
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i).getFileName() == null);
			if (list.get(i).getFileName() == null) {
				list.get(i).setImgurl(null);
			} else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4) + "%5C" + list.get(i).getUploadPath().substring(5, 7)
						+ "%5C" + list.get(i).getUploadPath().substring(8);
				url += "%2Fs_" + list.get(i).getUuid() + "_" + list.get(i).getFileName();
				list.get(i).setImgurl(url);
			}
		}
		return list;
	}


	public List<ProductListVO> searchAllBrandNew(String search) {
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.brandNew", search);
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i).getFileName() == null);
			if (list.get(i).getFileName() == null) {
				list.get(i).setImgurl(null);
			} else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4) + "%5C" + list.get(i).getUploadPath().substring(5, 7)
						+ "%5C" + list.get(i).getUploadPath().substring(8);
				url += "%2Fs_" + list.get(i).getUuid() + "_" + list.get(i).getFileName();
				list.get(i).setImgurl(url);
			}
		}
		return list;
	}



	public List<ProductListVO> searchAllPriceHigh(String search) {
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.priceHigh", search);
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i).getFileName() == null);
			if (list.get(i).getFileName() == null) {
				list.get(i).setImgurl(null);
			} else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4) + "%5C" + list.get(i).getUploadPath().substring(5, 7)
						+ "%5C" + list.get(i).getUploadPath().substring(8);
				url += "%2Fs_" + list.get(i).getUuid() + "_" + list.get(i).getFileName();
				list.get(i).setImgurl(url);
			}
		}
		return list;
	}



	public List<ProductListVO> searchAllPriceLow(String search) {
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.priceLow", search);
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i).getFileName() == null);
			if (list.get(i).getFileName() == null) {
				list.get(i).setImgurl(null);
			} else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4) + "%5C" + list.get(i).getUploadPath().substring(5, 7)
						+ "%5C" + list.get(i).getUploadPath().substring(8);
				url += "%2Fs_" + list.get(i).getUuid() + "_" + list.get(i).getFileName();
				list.get(i).setImgurl(url);
			}
		}
		return list;
	}



	public List<ProductListVO> searchAllViewsLevel(String search) {
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.viewsLevel", search);
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i).getFileName() == null);
			if (list.get(i).getFileName() == null) {
				list.get(i).setImgurl(null);
			} else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4) + "%5C" + list.get(i).getUploadPath().substring(5, 7)
						+ "%5C" + list.get(i).getUploadPath().substring(8);
				url += "%2Fs_" + list.get(i).getUuid() + "_" + list.get(i).getFileName();
				list.get(i).setImgurl(url);
			}
		}
		return list;
	}


	// 카테고리 검색
	
	public List<ProductListVO> selectByCategorySearch(String c, String search) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("search", search);
		map.put("category", c);
		
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.categorySearch",map);
		
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
	
	
	public List<ProductListVO> selectByCategoryBrandNew(String c, String search) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("search", search);
		map.put("category", c);
		
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.cateBrandNew",map);
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


	public List<ProductListVO> selectByCategoryPriceHigh(String c, String search) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("search", search);
		map.put("category", c);
		
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.catePriceHigh",map);
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


	public List<ProductListVO> selectByCategoryPriceLow(String c, String search) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("search", search);
		map.put("category", c);
		
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.catePriceLow",map);
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


	public List<ProductListVO> selectByCategoryViewsLevel(String c, String search) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("search", search);
		map.put("category", c);
		
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.cateViewsLevel",map);
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


	public int numberOfSearches(String search) {
		return sqlSession.selectOne("mybatis.mapper.search.numberOfSearches",search);
		
	}
	
	
	
}
