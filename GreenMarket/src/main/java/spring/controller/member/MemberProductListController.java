package spring.controller.member;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.dao.product.MemberProductListDAO;
import spring.vo.member.AuthInfo;
import spring.vo.product.PagingInfoVO;
import spring.vo.product.ProductListVO;

@Controller
public class MemberProductListController {
	
	@Autowired
	private MemberProductListDAO pbdao;

	@RequestMapping("myProduct{sN}{pN}")
	public String ProductBuyList( String sN, String pN, HttpSession session, Model model) {
		AuthInfo authInfo = (AuthInfo)session.getAttribute("authInfo");
		String mplc = authInfo.getEmail();		
		
		int totalCnt = pbdao.selectMyProductNumboard(mplc);
		int section = Integer.parseInt((sN==null)?"1" : sN);
		int pageNum = Integer.parseInt((pN==null)?"1" : pN);
		
		PagingInfoVO pInfo = new PagingInfoVO();
		pInfo.setEmail(mplc);
		pInfo.setPageNum(pageNum);
		pInfo.setSection(section);
		List<ProductListVO> list = null;
		
//		if(!c.equals("all")) {
//			if(v.equals("myProduct")) {
//				list = pbdao.selectAllProductBuyList(pInfo);			
//			}else if(v.equals("unSell")) {
//				list = pbdao.selectAllProductUnSellList(pInfo);
//			}else if(v.equals("sell")) {
//				list = pbdao.selectAllProductSellList(pInfo);
//			}
//		}	
		
		list = pbdao.selectAllProductBuyList(pInfo);
		
		list = urlMapping(list);
		
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("productModel", list);
		model.addAttribute("section", section);
		model.addAttribute("page", pageNum);		
		
		return "product/myProductList";
	}	
	
	@RequestMapping("unSell{sN}{pN}")
	public String ProductUnSellList(String sN, String pN, HttpSession session, Model model) {
		AuthInfo who = (AuthInfo)session.getAttribute("authInfo");
		String mplc = who.getEmail();
		
		int totalCnt = pbdao.selectMyUnSellNumboard(mplc);
		int section = Integer.parseInt((sN==null)?"1" : sN);
		int pageNum = Integer.parseInt((pN==null)?"1" : pN);
		
		PagingInfoVO pInfo = new PagingInfoVO(); 
		pInfo.setEmail(mplc);
		pInfo.setPageNum(pageNum);
		pInfo.setSection(section);
		List<ProductListVO> list = null;
		
		list = pbdao.selectAllProductUnSellList(pInfo);
		
		list = urlMapping(list);			
				
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("productModel", list);
		model.addAttribute("section", section);
		model.addAttribute("page", pageNum);
		
		return "product/myProductList";
	}
	
	
	@RequestMapping("sell{sN}{pN}")
	public String ProductSellList( String sN, String pN, HttpSession session, Model model) {
		AuthInfo who = (AuthInfo)session.getAttribute("authInfo");
		String mplc = who.getEmail();
		
		int totalCnt = pbdao.selectMySellNumboard(mplc);
		int section = Integer.parseInt((sN==null)?"1" : sN);
		int pageNum = Integer.parseInt((pN==null)?"1" : pN);
		
		PagingInfoVO pInfo = new PagingInfoVO();
		pInfo.setEmail(mplc);
		pInfo.setPageNum(pageNum);
		pInfo.setSection(section);
		List<ProductListVO> list = null;
		
		list = pbdao.selectAllProductSellList(pInfo);
		
		list = urlMapping(list);
		
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("productModel", list);			
		model.addAttribute("section", section);
		model.addAttribute("page", pageNum);
		
		return "product/myProductList";
	}	
	
	public List<ProductListVO> urlMapping(List<ProductListVO> abc){
		List<ProductListVO> list = abc;
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


