package spring.controller.search;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import oracle.jdbc.proxy.annotation.GetCreator;
import spring.dao.product.ProductDaoImp;
import spring.dao.product.ProductListDAO;
import spring.dao.search.SearchDao;
import spring.service.search.SearchService;
import spring.vo.product.CategoryVO;
import spring.vo.product.ProductListVO;
import spring.vo.search.Search;

@Controller
public class SearchController {
	
	
	@Autowired
	private ProductDaoImp daoip;
	
	
	@Autowired 
	private SearchDao searchDao;
	
	@Autowired
	private SearchService searchService;
	
	@GetMapping("search")
	public String search(Search searches, String c, String v, Model model) {
		
		List<CategoryVO> categoryList = daoip.category();
		//검색어 저장
		Search search = new Search(searches.getIdx(),
				searches.getKeyword(),searches.getEmail());
		searchService.PopularSearch(searches);
		
		List<ProductListVO> list = null;
		
		if(!c.equals("all")) { // 특정 카테고리를 지정했을 때
			int count = searchDao. cateNumberOfSearches(c,searches.getKeyword());
			
			if(v.equals("product")) {
				list = searchDao.selectByCategorySearch(c,searches.getKeyword()); // 전체상품 조회  // DAO에서 return한 데이터 (productList에 담김)
			}else if(v.equals("brandNew")){
				list = searchDao.selectByCategoryBrandNew(c,searches.getKeyword());
			}else if(v.equals("priceHigh")) {
				list = searchDao.selectByCategoryPriceHigh(c,searches.getKeyword());
			}else if(v.equals("priceLow")) {
				list = searchDao.selectByCategoryPriceLow(c,searches.getKeyword());
			}else if(v.equals("viewsLevel")) {
				list = searchDao.selectByCategoryViewsLevel(c,searches.getKeyword());
			}
			model.addAttribute("count",count);
			
		}else { // 특정 카테고리 지정 없이 전체 상품을 불러 올 때
			int count = searchDao.numberOfSearches(searches.getKeyword());
			if(v.equals("product")) {
				list = searchDao.searchAll(searches.getKeyword()); // 전체상품 조회  // DAO에서 return한 데이터 (productList에 담김)
			}else if(v.equals("brandNew")){
				list = searchDao.searchAllBrandNew(searches.getKeyword());
			}else if(v.equals("priceHigh")) {
				list = searchDao.searchAllPriceHigh(searches.getKeyword());
			}else if(v.equals("priceLow")) {
				list = searchDao.searchAllPriceLow(searches.getKeyword());
			}else if(v.equals("viewsLevel")) {
				list = searchDao.searchAllViewsLevel(searches.getKeyword());
			}
			model.addAttribute("count",count);
		}
		
		model.addAttribute("productModel", list);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("c", c);
		model.addAttribute("search",searches.getKeyword());
		return "search/products";
	}
	
}
