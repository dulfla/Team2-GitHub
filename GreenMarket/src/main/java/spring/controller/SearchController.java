package spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import oracle.jdbc.proxy.annotation.GetCreator;
import spring.dao.MemberDaoImpl;
import spring.dao.ProductListDAO;
import spring.dao.SearchDao;
import spring.vo.CategoryVO;
import spring.vo.ProductListVO;

@Controller
public class SearchController {
	
	
	@Autowired
	private MemberDaoImpl daoip;
	
	
	@Autowired 
	private SearchDao searchDao;
	 
	
	@GetMapping("search")
	public String search(String search, String c, String v, Model model) {
		
		List<CategoryVO> categoryList = daoip.category();
		
		List<ProductListVO> list = null;
		
		
		if(!c.equals("all")) { // 특정 카테고리를 지정했을 때
			int count = searchDao.numberOfSearches(search);
			
			if(v.equals("product")) {
				list = searchDao.selectByCategorySearch(c,search); // 전체상품 조회  // DAO에서 return한 데이터 (productList에 담김)
			}else if(v.equals("brandNew")){
				list = searchDao.selectByCategoryBrandNew(c,search);
			}else if(v.equals("priceHigh")) {
				list = searchDao.selectByCategoryPriceHigh(c,search);
			}else if(v.equals("priceLow")) {
				list = searchDao.selectByCategoryPriceLow(c,search);
			}else if(v.equals("viewsLevel")) {
				list = searchDao.selectByCategoryViewsLevel(c,search);
			}
			model.addAttribute("count",count);
			
		}else { // 특정 카테고리 지정 없이 전체 상품을 불러 올 때
			int count = searchDao.numberOfSearches(search);
			
			if(v.equals("product")) {
				list = searchDao.searchAll(search); // 전체상품 조회  // DAO에서 return한 데이터 (productList에 담김)
			}else if(v.equals("brandNew")){
				list = searchDao.searchAllBrandNew(search);
			}else if(v.equals("priceHigh")) {
				list = searchDao.searchAllPriceHigh(search);
			}else if(v.equals("priceLow")) {
				list = searchDao.searchAllPriceLow(search);
			}else if(v.equals("viewsLevel")) {
				list = searchDao.searchAllViewsLevel(search);
			}
			model.addAttribute("count",count);
		}
		
		model.addAttribute("productModel", list);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("c", c);
		model.addAttribute("search",search);
		return "search/products";
	}
	
}
