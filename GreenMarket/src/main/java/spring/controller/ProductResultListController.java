package spring.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.dao.ProductListDAO;
import spring.vo.ProductListVO;

@Controller
public class ProductResultListController {

	private ProductListDAO dao;
	public ProductResultListController(ProductListDAO dao) {
		this.dao = dao;
	}


	@RequestMapping("productResult")
	public String productList(Model model) {
		List<ProductListVO> productList = new ArrayList<>();
		productList = dao.selectAllProduct();
	
		model.addAttribute("productModel",productList);
		
		for(int i=0; i<productList.size(); i++) {
			String p_id = productList.get(i).getP_id();
			System.out.println(p_id);
		}
		
		return "";
	}
}
