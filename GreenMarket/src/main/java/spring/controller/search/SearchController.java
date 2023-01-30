package spring.controller.search;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import spring.dao.product.ProductDaoImp;
import spring.dao.search.SearchDao;
import spring.vo.product.CategoryVO;
import spring.vo.product.PagingInfoVO;
import spring.vo.product.ProductListVO;
import spring.vo.search.Search;

@Controller
public class SearchController {
	
	
	@Autowired
	private ProductDaoImp daoip;
	
	@Autowired 
	private SearchDao searchDao;
	
	@GetMapping("search")
	public String search(Search searches, PagingInfoVO p, Model model) {
		
		
		// 검색어 빈칸으로 입력했을때
		if(searches.getKeyword() == null ||
			searches.getKeyword().equals("")) {
			
			return "redirect:/index";
		}
		
		List<CategoryVO> categoryList = daoip.category();
		//검색어 저장
		Search search = new Search(searches.getIdx(),
				searches.getKeyword(),searches.getEmail());
		searchDao.searchInsert(search);	
		
		List<ProductListVO> list = null;
		
		if(!p.getC().equals("all")) { // 특정 카테고리를 지정했을 때
			int count = searchDao. cateNumberOfSearches(p.getC(), searches.getKeyword());
			System.out.println("count : "+count);
			if(p.getV().equals("product")) {
				list = searchDao.selectByCategorySearch(p); // 전체상품 조회  // DAO에서 return한 데이터 (productList에 담김)
			}else if(p.getV().equals("brandNew")){
				list = searchDao.selectByCategoryBrandNew(p);
			}else if(p.getV().equals("priceHigh")) {
				list = searchDao.selectByCategoryPriceHigh(p);
			}else if(p.getV().equals("priceLow")) {
				list = searchDao.selectByCategoryPriceLow(p);
			}else if(p.getV().equals("viewsLevel")) {
				list = searchDao.selectByCategoryViewsLevel(p);
			}
			model.addAttribute("count",count);
			
		}else { // 특정 카테고리 지정 없이 전체 상품을 불러 올 때
			int count = searchDao.numberOfSearches(searches.getKeyword());
			if(p.getV().equals("product")) {
				list = searchDao.searchAll(p); // 전체상품 조회  // DAO에서 return한 데이터 (productList에 담김)
			}else if(p.getV().equals("brandNew")){
				list = searchDao.searchAllBrandNew(p);
			}else if(p.getV().equals("priceHigh")) {
				list = searchDao.searchAllPriceHigh(p);
			}else if(p.getV().equals("priceLow")) {
				list = searchDao.searchAllPriceLow(p);
			}else if(p.getV().equals("viewsLevel")) {
				list = searchDao.searchAllViewsLevel(p);
			}
			model.addAttribute("count",count);
		}
		
		
		model.addAttribute("productModel", list);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("pageData", p);
		model.addAttribute("search",searches.getKeyword());
		return "search/products";
	}
	
	// 인기검색어
	@GetMapping("popularSearch")
	public String popularSearch(Model model) {
		
		List<Search> popularSearchList = searchDao.popSearchList(); 
		
		model.addAttribute("list",popularSearchList);
		return "search/popularSearch";
	}
}
