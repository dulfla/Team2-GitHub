package spring.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.dao.MemberProductListDAO;
import spring.vo.ProductListVO;
import spring.vo.ProductSellListVO;

@Controller
public class MemberProductListController {
	
	@Autowired
	private MemberProductListDAO pbdao;

	@RequestMapping("buypage")
	public String ProductBuyList(HttpServletRequest req,Model model) {
		String mplc = req.getParameter("email");
		
		List<ProductListVO> productBuyList = new ArrayList<>();
		productBuyList = pbdao.selectAllProductBuyList(mplc);
		
		model.addAttribute("buyListModel",productBuyList);
		
		return "";
	}
	
	@RequestMapping("sellpage")
	public String ProductSellList(HttpServletRequest req,Model model) {
		String mplc = req.getParameter("email");
		
		List<ProductSellListVO> productSellList = new ArrayList<>();
		productSellList = pbdao.selectAllProductSellList(mplc);
				
		model.addAttribute("sellListModel",productSellList);
		
		return "";
	}
}


