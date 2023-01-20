package spring.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.dao.MemberDaoImpl;
import spring.dao.ProductListDAO;
import spring.vo.CategoryVO;
import spring.vo.ProductListVO;

// 1)
@Controller  // @어노테이션 @Controller -> 해당 어노테이션이 붙은 이 클래스를 컨트롤러로 사용한다는 선언문
public class ProductResultListController {

	@Autowired
	private ProductListDAO dao;

	@Autowired
	private MemberDaoImpl daoip;
	
	@RequestMapping("productList{c}{v}") // <- 이링크를 받아서 아래메소드 내용으로 처리하겠다
	public String productList(String c, String v, Model model) { // 10) command(웹페이지에서 입력된 정보를 백앤드로 불러올때)
											//  model(가져온 데이터를 웹페이지에 보여줄때)  
		//3)									// model(가져온 데이터를 담아서 보내주는 도구 ex : servlet -> request.setAttribute)
		List<CategoryVO> categoryList = daoip.category();
		
		List<ProductListVO> list = null;
		
		if(!c.equals("all")) { // 특정 카테고리를 지정했을 때
			if(v.equals("product")) {
				list = dao.selectByCategory(c); // 전체상품 조회  // DAO에서 return한 데이터 (productList에 담김)
			}else if(v.equals("brandNew")){
				list = dao.selectByCategoryBrandNew(c);
			}else if(v.equals("priceHigh")) {
				list = dao.selectByCategoryPriceHigh(c);
			}else if(v.equals("priceLow")) {
				list = dao.selectByCategoryPriceLow(c);
			}else if(v.equals("viewsLevel")) {
				list = dao.selectByCategoryViewsLevel(c);
			}
		}else { // 특정 카테고리 지정 없이 전체 상품을 불러 올 때
			if(v.equals("product")) {
				list = dao.selectAllProduct(); // 전체상품 조회  // DAO에서 return한 데이터 (productList에 담김)
			}else if(v.equals("brandNew")){
				list = dao.selectAllBrandNew();
			}else if(v.equals("priceHigh")) {
				list = dao.selectAllPriceHigh();
			}else if(v.equals("priceLow")) {
				list = dao.selectAllPriceLow();
			}else if(v.equals("viewsLevel")) {
				list = dao.selectAllViewsLevel();
			}
		}
		
		model.addAttribute("productModel", list);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("c", c);
		
		
		return "product/productList"; // 12)리턴으로 보낼 페이지 로 보냄
	}
	
}

//for(int i=0; i<viewsLevelList.size(); i++) {
//	System.out.println(viewsLevelList.get(i).getP_id());
//}	


//for(int i=0; i<productList.size(); i++) {
//	System.out.println(productList.get(i).getF_proxy_name());
//}	   

// f_proxy_name 사진관련 오류검색



