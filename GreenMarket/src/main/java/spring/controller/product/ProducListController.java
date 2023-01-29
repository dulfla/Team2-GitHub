package spring.controller.product;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.dao.product.ProductDaoImp;
import spring.dao.product.ProductListDAO;
import spring.vo.member.AuthInfo;
import spring.vo.product.CategoryVO;
import spring.vo.product.PagingInfoVO;
import spring.vo.product.ProductListVO;

@Controller
public class ProducListController {

	@Autowired
	private ProductListDAO dao;

	@Autowired
	private ProductDaoImp daoip;
	
	@RequestMapping("productList")
	public String productList(PagingInfoVO data, Model model) {
		
		List<CategoryVO> categoryList = daoip.category();
		List<ProductListVO> list = null;
		int totalCnt = 0;
		
		if(!data.getC().equals("all")) {
			if(data.getV().equals("product")) {
				totalCnt = dao.selectCateNumboard(data.getC());
				list = dao.selectByCategory(data);
			}else if(data.getV().equals("brandNew")){
				totalCnt = dao.selectCateNumboard(data.getC());
				list = dao.selectByCategoryBrandNew(data);
			}else if(data.getV().equals("priceHigh")) {
				totalCnt = dao.selectCateNumboard(data.getC());
				list = dao.selectByCategoryPriceHigh(data);
			}else if(data.getV().equals("priceLow")) {
				totalCnt = dao.selectCateNumboard(data.getC());
				list = dao.selectByCategoryPriceLow(data);
			}else if(data.getV().equals("viewsLevel")) {
				totalCnt = dao.selectCateNumboard(data.getC());
				list = dao.selectByCategoryViewsLevel(data);
			}
		}else {
			if(data.getV().equals("product")) {
				totalCnt = dao.selectAllNumboard();
				list = dao.selectAllProduct(data);
			}else if(data.getV().equals("brandNew")){
				totalCnt = dao.selectAllNumboard();
				list = dao.selectAllBrandNew(data);
			}else if(data.getV().equals("priceHigh")) {
				totalCnt = dao.selectAllNumboard();
				list = dao.selectAllPriceHigh(data);
			}else if(data.getV().equals("priceLow")) {
				totalCnt = dao.selectAllNumboard();
				list = dao.selectAllPriceLow(data);
			}else if(data.getV().equals("viewsLevel")) {
				totalCnt = dao.selectAllNumboard();
				list = dao.selectAllViewsLevel(data);
			}
		}

		list = urlMapping(list);
		model.addAttribute("pageData", data);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("products", list);
		model.addAttribute("categorys", categoryList);
		
		return "product/productList";
	}

	@RequestMapping("myProduct")
	public String ProductBuyList(PagingInfoVO data, HttpSession session, Model model) {
		AuthInfo authInfo = (AuthInfo)session.getAttribute("authInfo");
		data.setEmail(authInfo.getEmail());
		
		int totalCnt = dao.selectMyProductNumboard(data.getEmail());
		
		List<ProductListVO> list = dao.selectAllProductBuyList(data);
		list = urlMapping(list);
		
		model.addAttribute("location", "myProduct");
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("products", list);
		model.addAttribute("pageData", data);	
		
		return "product/myProductList";
	}	
	
	@RequestMapping("unSelled")
	public String ProductUnSellList(PagingInfoVO data, HttpSession session, Model model) {
		System.out.println("unSelled getOip : "+data.getOip());
		
		AuthInfo authInfo = (AuthInfo)session.getAttribute("authInfo");
		data.setEmail(authInfo.getEmail());
		
		List<ProductListVO> list = dao.selectAllProductUnSellList(data);
		list = urlMapping(list);
		
		int totalCnt = dao.selectMyUnSellNumboard(data.getEmail());
		
		model.addAttribute("location", "unSelled");
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("products", list);
		model.addAttribute("pageDate", data);

		System.out.println("unSelled totalCnt : "+totalCnt);
		System.out.println("unSelled getOip : "+data.getOip());
		
		return "product/myProductList";
	}
	
	@RequestMapping("selled")
	public String ProductSellList(PagingInfoVO data, HttpSession session, Model model) {
		System.out.println("selled getOip : "+data.getOip());
		
		AuthInfo authInfo = (AuthInfo)session.getAttribute("authInfo");
		data.setEmail(authInfo.getEmail());
		
		List<ProductListVO> list = dao.selectAllProductSellList(data);
		list = urlMapping(list);
		
		int totalCnt = dao.selectMySellNumboard(data.getEmail());
		
		model.addAttribute("location", "selled");
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("products", list);
		model.addAttribute("pageDate", data);
		
		System.out.println("selled totalCnt : "+totalCnt);
		System.out.println("selled getOip : "+data.getOip());
		
		return "product/myProductList";
	}
	
	public List<ProductListVO> urlMapping(List<ProductListVO> pList){		
		List<ProductListVO> list = pList;
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getFileName()==null) {
				list.get(i).setImgurl(null);
			}else {
				String url = "";
				url += list.get(i).getUploadPath().substring(0, 4)+"%5C"+list.get(i).getUploadPath().substring(5, 7)+"%5C"+list.get(i).getUploadPath().substring(8);
				url += "%2Fs_"+list.get(i).getUuid()+"_"+list.get(i).getFileName();
				list.get(i).setImgurl(url);				
			}	
		}
		return list;
	}
}