package spring.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import spring.business.AdminJsonParsing;
import spring.vo.AuthInfo;

@Controller
public class AdminController {
	
	@Autowired
	private AdminJsonParsing adminJsonParsing;
		
/*	// 관리자가 아닌 일반 회원이 접속할 경우의 처리	
	@RequestMapping("/MemberStatus")
	public String memberAdmin(HttpServletRequest request, Model model, HttpSession session, RedirectAttributes reda) throws ParseException {
		String referer = request.getHeader("Referer");
		AuthInfo who = (AuthInfo)session.getAttribute("authInfo");
		String errorMsg = null;
		
		if(who!=null) {
			if(who.getType().equalsIgnoreCase("M")) {
				JSONObject json = adminJsonParsing.memverAdmin();
				model.addAttribute("memberAdmin", json);
				return "admin/memberStatus";
			}else { errorMsg = "관리자만 접속할 수 있는 페이지 입니다."; }
		}else { errorMsg = "로그인하셔야  접속할 수 있는 페이지 입니다."; }
		
		reda.addFlashAttribute("errMsg", errorMsg);
		return "redirect:"+(referer!=null?referer:"index");
	}
	
	@RequestMapping("/ProductStatus")
	public String productAdmin(HttpServletRequest request, Model model, HttpSession session, RedirectAttributes reda) throws ParseException {
		String referer = request.getHeader("Referer");
		
		AuthInfo who = (AuthInfo)session.getAttribute("authInfo");
		String errorMsg = null;
		
		if(who!=null) {
			if(who.getType().equalsIgnoreCase("M")) {
				JSONObject json = adminJsonParsing.productAdmin();
				model.addAttribute("productAdmin", json);
				return "admin/productStatus";
			}else { errorMsg = "관리자만 접속할 수 있는 페이지 입니다."; }
		}else { errorMsg = "로그인하셔야  접속할 수 있는 페이지 입니다."; }
		
		reda.addFlashAttribute("errMsg", errorMsg);
		return "redirect:"+(referer!=null?referer:"index");
	}
*/

	@RequestMapping("/MemberStatus")
	public String memberAdmin(Model model) throws ParseException {
		JSONObject json = adminJsonParsing.memverAdmin();
		model.addAttribute("memberAdmin", json);
		
		return "admin/memberStatus";
	}
	
	@RequestMapping("/ProductStatus")
	public String productAdmin(Model model) throws ParseException {
		JSONObject json = adminJsonParsing.productAdmin();
		model.addAttribute("productAdmin", json);
		
		return "admin/productStatus";
	}

}
