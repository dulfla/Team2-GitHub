package spring.service.search;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.dao.search.SearchDao;
import spring.vo.search.Search;

@Service
public class SearchService {
	
	@Autowired 
	private SearchDao searchDao;
	
	public void PopularSearch(Search searches) {
		Search search = new Search(searches.getIdx(),
				searches.getKeyword(),searches.getEmail());
		
		searchDao.searchInsert(search);	
	}

	public List<Search> popSearchList() {
		List<Search> list = new ArrayList<Search>();
		searchDao.popSearchList();
		return list;
	}

}
