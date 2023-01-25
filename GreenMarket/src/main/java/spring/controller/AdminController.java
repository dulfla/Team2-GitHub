package spring.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.HashMap;
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
import spring.business.AdminJsonParsing;
import spring.dao.AdminDao;
import spring.vo.CategoryAdminVo;
import spring.vo.CategoryVO;

@Controller
public class AdminController {
	
	@Autowired
	private AdminJsonParsing adminJsonParsing;
	
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
	@PostMapping("CategoryTitleModify")
	public int categoryTitleModify(@RequestBody Map<String, String> map) {
		System.out.println("카테고리 명칭 수정");
		dao.updateCategory(map);
		dao.updateProduct(map);
		return 1;
	}
	
	@ResponseBody
	@PostMapping("CategoryIconModify{c}{fileType}")
	public int categoryIconModify(MultipartFile file, String c, String fileType) {
		System.out.println("카테고리 아이콘 수정");
		
		String uploadFolder = "C:\\upload";
		File fileLocation = new File(uploadFolder, "category");
		
		if(fileLocation.exists() == false) {
			fileLocation.mkdirs();
		}
		
		String originFileName = dao.originFileName(c);
		System.out.println("originFileName : "+originFileName);
		String originFile = "C:\\upload\\category";
		File fileObj = new File(originFile, originFileName);
		if(fileObj.exists()) {
		    fileObj.delete();
		}
		
		String fileName = c+"."+fileType;
		File saveFile = new File(fileLocation, fileName);
		
		try {
			file.transferTo(saveFile);
			
			File thumbnailFile = new File(fileLocation, fileName);
			
			BufferedImage bo_image = ImageIO.read(saveFile);

			double ratio = 3;
			int width = (int) (bo_image.getWidth() / ratio);
			int height = (int) (bo_image.getHeight() / ratio);					
		
			Thumbnails.of(saveFile).size(width, height).toFile(thumbnailFile);
			
			CategoryAdminVo cvo = new CategoryAdminVo();
			cvo.setCategory(c);
			cvo.setIcon(fileName);
			dao.updateIcon(cvo);
		} catch (Exception e) {
			e.printStackTrace();
			return 2;
		}
		return 1;
	}
	
	@ResponseBody
	@PostMapping("CheckCategoryTitle")
	public boolean newCategoryTitleChecking(@RequestBody Map<String, String> map) {
		System.out.println("새 카테고리 명칭 확인");
		int result = dao.checkNewCategoryTitle(map.get("newC"));
		System.out.println(result);
		if(0<result) {
			return false;
		}else {
			return true;
		}
	}
	
	@ResponseBody
	@RequestMapping("CategoryImage{fileName}")
	public ResponseEntity<byte[]> getFile(String fileName){
		ResponseEntity<byte[]> img = null;
		File file = new File("c:\\upload\\category\\"+fileName);
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-type", Files.probeContentType(file.toPath()));
			img = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch (IOException e) {
			e.printStackTrace();
		}
		return img;
	}
	
	@ResponseBody
	@PostMapping("CategoryRegister{c}{fileType}")
	public int categoryRegister(MultipartFile file, String c, String fileType) {
		System.out.println("카테고리 등록");
		
		String uploadFolder = "C:\\upload";
		File fileLocation = new File(uploadFolder, "category");
		
		if(fileLocation.exists() == false) {
			fileLocation.mkdirs();
		}
		
		String fileName = c+"."+fileType;
		File saveFile = new File(fileLocation, fileName);
		
		try {
			file.transferTo(saveFile);
			
			File thumbnailFile = new File(fileLocation, fileName);
			
			BufferedImage bo_image = ImageIO.read(saveFile);

			double ratio = 3;
			int width = (int) (bo_image.getWidth() / ratio);
			int height = (int) (bo_image.getHeight() / ratio);					
		
			Thumbnails.of(saveFile).size(width, height).toFile(thumbnailFile);
			
			CategoryAdminVo cvo = new CategoryAdminVo();
			cvo.setCategory(c);
			cvo.setIcon(fileName);
			dao.addNewCategory(cvo);
		} catch (Exception e) {
			e.printStackTrace();
			return 2;
		}
		return 1;
	}
	
	@ResponseBody
	@PostMapping("CategoryList")
	public List<CategoryVO> reloadCategory() {
		return dao.getAllCategory();
	}
}
