package spring.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.dao.ProductListDAO;
import spring.vo.ProductListVO;

// 1)
@Controller  // @어노테이션 @Controller -> 해당 어노테이션이 붙은 이 클래스를 컨트롤러로 사용한다는 선언문
public class ProductResultListController {

	@Autowired
	private ProductListDAO dao;

	
	@RequestMapping("productResult") // <- 이링크를 받아서 아래메소드 내용으로 처리하겠다
	public String productList(HttpServletRequest req, Model model) { // 10) command(웹페이지에서 입력된 정보를 백앤드로 불러올때)
											//  model(가져온 데이터를 웹페이지에 보여줄때)  
		//3)									// model(가져온 데이터를 담아서 보내주는 도구 ex : servlet -> request.setAttribute)
		String gmpd = req.getParameter("command"); // productResult?command=asdf
		if(gmpd.equals("productList")) {
			List<ProductListVO> productList = new ArrayList<>();
			productList = dao.selectAllProduct(); // 전체상품 조회  // DAO에서 return한 데이터 (productList에 담김)
			
			model.addAttribute("productModel",productList);		
						
		}else if(gmpd.equals("categoryList")){
			List<ProductListVO> categoryList = new ArrayList<>();
			String gmpdd = req.getParameter("cate"); //?command=asdf&cate=카테고리명
			categoryList = dao.selectAllCategory(gmpdd);
			
			model.addAttribute("productModel",categoryList);
						
		}else if(gmpd.equals("brandNewList")){
			List<ProductListVO> brandNewList = new ArrayList<>();
			brandNewList = dao.selectAllBrandNew();
			
			model.addAttribute("productModel",brandNewList);
						
		}else if(gmpd.equals("priceHighList")) {
			List<ProductListVO> priceHighList = new ArrayList<>();
			priceHighList = dao.selectAllPriceHigh();
			
			model.addAttribute("productModel",priceHighList);
			
		}else if(gmpd.equals("priceLowList")) {
			List<ProductListVO> priceLowList = new ArrayList<>();
			priceLowList = dao.selectAllPriceLow();
			
			model.addAttribute("productModel",priceLowList);
			
		}else if(gmpd.equals("viewsLevelList")) {
			List<ProductListVO> viewsLevelList = new ArrayList<>();
			viewsLevelList = dao.selectAllViewsLevel();
			
			model.addAttribute("productModel",viewsLevelList);
		}			
		
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



