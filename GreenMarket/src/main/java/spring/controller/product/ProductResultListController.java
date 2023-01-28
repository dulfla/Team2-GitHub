package spring.controller.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.dao.product.ProductDaoImp;
import spring.dao.product.ProductListDAO;
import spring.vo.product.CategoryPagingVO;
import spring.vo.product.CategoryVO;
import spring.vo.product.PagingInfoVO;
import spring.vo.product.ProductListVO;


// 1)
@Controller  // @어노테이션 @Controller -> 해당 어노테이션이 붙은 이 클래스를 컨트롤러로 사용한다는 선언문
public class ProductResultListController {

	@Autowired
	private ProductListDAO dao;

	@Autowired
	private ProductDaoImp daoip;
	
	
	@RequestMapping("productList{c}{v}{sN}{pN}") // <- 이링크를 받아서 아래메소드 내용으로 처리하겠다
	public String productList(String c, String v, String sN, String pN, Model model) { // 10) command(웹페이지에서 입력된 정보를 백앤드로 불러올때)
											//  model(가져온 데이터를 웹페이지에 보여줄때)  
		//3)									// model(가져온 데이터를 담아서 보내주는 도구 ex : servlet -> request.setAttribute)
		List<CategoryVO> categoryList = daoip.category();		
		
		CategoryPagingVO cate = new CategoryPagingVO();
		cate.setCategory(c);
		
		int totalCnt = 0;		
//		System.out.println(sN+","+pN);
		int section = Integer.parseInt((sN==null)?"1" : sN);
		int pageNum = Integer.parseInt((pN==null)?"1" : pN);
		
		
//		List<ProductListVO> paging = dao.selectTargetBoards(section, pageNum);
		
		PagingInfoVO pInfo = new PagingInfoVO();
		pInfo.setCategory(c);
		pInfo.setPageNum(pageNum);
		pInfo.setSection(section);
//		System.out.println(pInfo.toString());
		List<ProductListVO> list = null;
		
		if(!c.equals("all")) { // 특정 카테고리를 지정했을 때
			if(v.equals("product")) {
				totalCnt = dao.selectCateNumboard(c);
				list = dao.selectByCategory(pInfo); // 전체상품 조회  // DAO에서 return한 데이터 (productList에 담김)
			}else if(v.equals("brandNew")){
				totalCnt = dao.selectCateNumboard(c);
				list = dao.selectByCategoryBrandNew(pInfo);
			}else if(v.equals("priceHigh")) {
				totalCnt = dao.selectCateNumboard(c);
				list = dao.selectByCategoryPriceHigh(pInfo);
			}else if(v.equals("priceLow")) {
				totalCnt = dao.selectCateNumboard(c);
				list = dao.selectByCategoryPriceLow(pInfo);
			}else if(v.equals("viewsLevel")) {
				totalCnt = dao.selectCateNumboard(c);
				list = dao.selectByCategoryViewsLevel(pInfo);
			}
		}else { // 특정 카테고리 지정 없이 전체 상품을 불러 올 때   selectCateNumboard
			if(v.equals("product")) {
				totalCnt = dao.selectAllNumboard();
				list = dao.selectAllProduct(pInfo); // 전체상품 조회  // DAO에서 return한 데이터 (productList에 담김)  selectAllNumboard
			}else if(v.equals("brandNew")){
				totalCnt = dao.selectAllNumboard();
				list = dao.selectAllBrandNew(pInfo);
			}else if(v.equals("priceHigh")) {
				totalCnt = dao.selectAllNumboard();
				list = dao.selectAllPriceHigh(pInfo);
			}else if(v.equals("priceLow")) {
				totalCnt = dao.selectAllNumboard();
				list = dao.selectAllPriceLow(pInfo);
			}else if(v.equals("viewsLevel")) {
				totalCnt = dao.selectAllNumboard();
				list = dao.selectAllViewsLevel(pInfo);
			}
		}
		
		list = urlMapping(list);		
		
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("productModel", list);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("c", c);
		model.addAttribute("v", v);
		model.addAttribute("section", section);
		model.addAttribute("page", pageNum);
		
		return "product/productList"; // 12)리턴으로 보낼 페이지 로 보냄
	}
	
//	public List<ProductListVO> urlMapping(List<ProductListVO> abc){
//		int totalCnt = dao.selectAllNumboard();
//		int pageCnt = 15;
//		int lastpage = (int)Math.ceil((double)totalCnt/pageCnt);
//		List<ProductListVO> list = abc;
//		for(int i=0;i<lastpage;i++) {
//			if(list.get(i).getFileName()==null) {
//				list.get(i).setImgurl(null);
//			}else {
//				String url = "";
//				url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
//				url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
//				list.get(i).setImgurl(url);
//				
//				System.out.println(i);
//			}	
//		}
//		return list;
//	}
	public List<ProductListVO> urlMapping(List<ProductListVO> abc){		
		List<ProductListVO> list = abc;
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

//for(int i=0; i<viewsLevelList.size(); i++) {
//	System.out.println(viewsLevelList.get(i).getP_id());
//}	


//for(int i=0; i<productList.size(); i++) {
//	System.out.println(productList.get(i).getF_proxy_name());
//}	   

// f_proxy_name 사진관련 오류검색



