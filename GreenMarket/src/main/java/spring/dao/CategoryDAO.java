package spring.dao;

import java.util.List;

import spring.vo.CategoryVO;

public interface CategoryDAO {

	public List<CategoryVO> category() throws Exception;
	
}
