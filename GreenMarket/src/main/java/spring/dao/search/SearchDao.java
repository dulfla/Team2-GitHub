package spring.dao.search;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.vo.product.CategoryVO;
import spring.vo.product.PagingInfoVO;
import spring.vo.product.ProductListVO;
import spring.vo.search.Search;

@Repository
public class SearchDao {

	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}


	public List<ProductListVO> searchAll(PagingInfoVO data) {
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.searchAll", data);
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


	public List<ProductListVO> searchAllBrandNew(PagingInfoVO data) {
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.brandNew", data);
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



	public List<ProductListVO> searchAllPriceHigh(PagingInfoVO data) {
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.priceHigh", data);
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



	public List<ProductListVO> searchAllPriceLow(PagingInfoVO data) {
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.priceLow", data);
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



	public List<ProductListVO> searchAllViewsLevel(PagingInfoVO data) {
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.viewsLevel", data);
		
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
	
	public List<ProductListVO> selectByCategorySearch(PagingInfoVO data) {
		
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.categorySearch",data);
		
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
	
	
	public List<ProductListVO> selectByCategoryBrandNew(PagingInfoVO data) {
		
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.cateBrandNew",data);
		
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


	public List<ProductListVO> selectByCategoryPriceHigh(PagingInfoVO data) {
		
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.catePriceHigh",data);
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


	public List<ProductListVO> selectByCategoryPriceLow(PagingInfoVO data) {
		
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.catePriceLow",data);
		
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


	public List<ProductListVO> selectByCategoryViewsLevel(PagingInfoVO data) {
		
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.search.cateViewsLevel",data);
		
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

	// 전체 검색건수
	public int numberOfSearches(String search) {
		return sqlSession.selectOne("mybatis.mapper.search.numberOfSearches",search);
		
	}

	// 카테고리 별 검색건수
	public int cateNumberOfSearches(String c, String search) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("search", search);
		map.put("category", c);
		
		return sqlSession.selectOne("mybatis.mapper.search.cateNumberOfSearches",map);
	}

	// 검색어 저장
	public void searchInsert(Search search) {
		sqlSession.insert("mybatis.mapper.search.searchInsert",search);
	}


	public List<Search> popSearchList() {
		List<Search>list = sqlSession.selectList("mybatis.mapper.search.popSearchList");
		return list;
	}
	
	
	
}
