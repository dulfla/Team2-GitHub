package spring.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.dao.MemberProductListDAO;
import spring.vo.AuthInfo;
import spring.vo.ProductListVO;

@Controller
public class MemberProductListController {
	
	@Autowired
	private MemberProductListDAO pbdao;

	@RequestMapping("myProduct")
	public String ProductBuyList(Model model,HttpSession session) {
		AuthInfo authInfo = (AuthInfo)session.getAttribute("authInfo");
		String mplc = authInfo.getEmail();
		
		List<ProductListVO> productList = new ArrayList<>();
		productList = pbdao.selectAllProductBuyList(mplc);
		
		model.addAttribute("productModel",productList);
		
		return "product/myProductList";
	}
	
	@RequestMapping("unSell")
	public String ProductUnSellList(HttpSession session,Model model) {
		AuthInfo who = (AuthInfo)session.getAttribute("authInfo");
		String mplc = who.getEmail();
		
		List<ProductListVO> productList = new ArrayList<>();
		productList = pbdao.selectAllProductUnSellList(mplc);
				
		model.addAttribute("productModel",productList);
		
		return "product/myProductList";
	}
	
	@RequestMapping("sell")
	public String ProductSellList(HttpSession session,Model model) {
		AuthInfo who = (AuthInfo)session.getAttribute("authInfo");
		String mplc = who.getEmail();
		
		List<ProductListVO> productList = new ArrayList<>();
		productList = pbdao.selectAllProductSellList(mplc);
				
		model.addAttribute("productModel",productList);
		
		return "product/myProductList";
	}	
}


