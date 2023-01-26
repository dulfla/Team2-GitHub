package spring.controller.admin;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnails;
import spring.dao.admin.AdminDao;
import spring.service.admin.AdminJsonParsing;
import spring.service.admin.CategoryAdminService;
import spring.vo.admin.CategoryAdminVo;
import spring.vo.product.CategoryVO;

@Controller
public class AdminController {
	
	@Autowired
	private AdminJsonParsing adminJsonParsing;
	
	@Autowired
	private CategoryAdminService categoryAS;
	
	@Autowired
	private AdminDao dao;
		
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
	
	@RequestMapping("/CategoryAdmin")
	public String productAdmin(HttpServletRequest request, Model model, HttpSession session, RedirectAttributes reda) throws ParseException {
		String referer = request.getHeader("Referer");
		
		AuthInfo who = (AuthInfo)session.getAttribute("authInfo");
		String errorMsg = null;
		
		if(who!=null) {
			if(who.getType().equalsIgnoreCase("M")) {
				List<CategoryVO> categorys= dao.getAllCategory();
				model.addAttribute("categorys", categorys);
				return "admin/category";
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
	
	@RequestMapping("/CategoryAdmin")
	public String categoryAdmin(Model model) {
		List<CategoryVO> categorys= dao.getAllCategory();
		model.addAttribute("categorys", categorys);
		
		return "admin/category";
	}
	
	@ResponseBody
	@PostMapping("CategoryDelete")
	public int categoryDelete(@RequestBody Map<String, String> map) {
		categoryAS.deleteCategory(map);
		return 1;
	}
	
	@ResponseBody
	@PostMapping("CategoryTitleModify")
	public int categoryTitleModify(@RequestBody Map<String, String> map) {
		categoryAS.modifyCategoryTitle(map);
		return 1;
	}
	
	@ResponseBody
	@PostMapping("CategoryIconModify{c}{fileType}")
	public int categoryIconModify(MultipartFile file, String c, String fileType) {
		return categoryAS.modifyCategoryIcon(file, c, fileType);
	}
	
	@ResponseBody
	@PostMapping("CheckCategoryTitle")
	public boolean newCategoryTitleChecking(@RequestBody Map<String, String> map) {
		int result = dao.checkNewCategoryTitle(map.get("newC"));
		if(0!=result) {
			return false;
		}else {
			return true;
		}
	}
	
	@ResponseBody
	@RequestMapping("CategoryImage{fileName}")
	public ResponseEntity<byte[]> getFile(String fileName){
		return categoryAS.getImg(fileName);
	}
	
	@ResponseBody
	@PostMapping("CategoryRegister{c}{fileType}")
	public int categoryRegister(MultipartFile file, String c, String fileType) {
		return categoryAS.registerCategory(file, c, fileType);
	}
	
	@ResponseBody
	@PostMapping("CategoryList")
	public List<CategoryVO> reloadCategory() {
		return dao.getAllCategory();
	}
}
