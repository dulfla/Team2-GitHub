package spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import spring.vo.ProductListVO;

public class MemberProductListDAO {

	private SqlSession sqlSession;
	
	public MemberProductListDAO(SqlSession sqlSession) {		
		this.sqlSession = sqlSession;
	}

	public List<ProductListVO> selectAllProductSellList(String mplc){
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.productList.sellList",mplc);
		for(int i=0;i<list.size();i++) {
			String url = "";
			url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
			url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
			list.get(i).setImgurl(url);			
		}
		return list;
	}
	
	public List<ProductListVO> selectAllProductUnSellList(String mplc){
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.productList.unSellList",mplc);
		for(int i=0;i<list.size();i++) {
			String url = "";
			url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
			url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
			list.get(i).setImgurl(url);			
		}
		return list;
	}
	
	public List<ProductListVO> selectAllProductBuyList(String mplc){
		List<ProductListVO> list = sqlSession.selectList("mybatis.mapper.productList.myProductList",mplc);
		for(int i=0;i<list.size();i++) {
			String url = "";
			url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
			url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
			list.get(i).setImgurl(url);
		}
		return list;
	}
}
