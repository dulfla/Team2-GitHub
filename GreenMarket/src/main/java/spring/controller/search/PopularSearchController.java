package spring.controller.search;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import spring.dao.search.SearchDao;
import spring.service.search.SearchService;
import spring.vo.search.Search;

@Controller
public class PopularSearchController {
	
	@Autowired
	SearchService searchService;
	
	@Autowired
	SearchDao searchDao;
	
	@GetMapping("popularSearch")
	public String popularSearch(Model model) {
		
		List<Search> popularSearchList = searchDao.popSearchList(); 
		
		model.addAttribute("list",popularSearchList);
		return "search/popularSearch";
	}
	
	
}
