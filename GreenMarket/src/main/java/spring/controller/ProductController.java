package spring.controller;

import java.awt.Graphics2D;


import java.awt.image.BufferedImage;
import java.io.Console;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.inject.Inject;

import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;

import net.coobird.thumbnailator.Thumbnails;
import spring.dao.MemberDaoImpl;
import spring.service.MemberService;
import spring.service.MemberServiceImpl;
import spring.vo.CategoryVO;
import spring.vo.Member;
import spring.vo.Product1VO;
import spring.vo.ProductImageVO;
import spring.vo.ProductVO;

@Controller
public class ProductController {

	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

	@Autowired
	private MemberServiceImpl memberServiceImpl;
	@Autowired
	private MemberDaoImpl memberDaoImpl;

	// 카테고리
	@RequestMapping(value = "productRegister", method = RequestMethod.GET)
	public String registerProduct(Model model) throws Exception {

		List<CategoryVO> list = memberServiceImpl.category();

		model.addAttribute("category", list);

		return "product/productReg";
	}

	// 상품 등록
	@RequestMapping(value = "productRegister", method = RequestMethod.POST)
	public String registerProduct(ProductVO vo, Product1VO vo1) {
		logger.info("productRegisterPOST.........." + vo);
		
		memberServiceImpl.productRegister(vo, vo1);

		
		return "redirect:/productList?c=all&v=brandNew";
	}
	// 이미지
	@RequestMapping(value = "uploadAjaxAction",
			produces = MediaType.APPLICATION_JSON_VALUE ,method = RequestMethod.POST)
	public ResponseEntity<List<ProductImageVO>> uploadAjaxActionPOST(@RequestParam MultipartFile[] uploadFile) {
		
		logger.info("uploadAjaxActionPOST..........");
		
		/* 이미지 파일 체크 */
		for(MultipartFile multipartFile: uploadFile) {
			
			File checkfile = new File(multipartFile.getOriginalFilename());
			String type = null;
			
			try {
				type = Files.probeContentType(checkfile.toPath());
				logger.info("MIME TYPE : " + type);
			} catch (IOException e) {
				e.printStackTrace();
			}
			if(!type.startsWith("image")) {
				
				List<ProductImageVO> list = null;
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
				
			}
			
		}
		
		String uploadFolder = "C:\\upload";
		
		// 날짜 폴더 경로
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		String datePath = str.replace("-", File.separator);
		
		// 폴더 생성
		File uploadPath = new File(uploadFolder, datePath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		// 이미지 정보 담는 객체
		List<ProductImageVO> list = new ArrayList();
		
		// 향상된 for
				for(MultipartFile multipartFile : uploadFile) {		
					
					/* 이미지 정보 객체 */
					ProductImageVO vo = new ProductImageVO();
					
					/* 파일 이름 */
					String uploadFileName = multipartFile.getOriginalFilename();
					vo.setFileName(uploadFileName);
					vo.setUploadPath(datePath);
					
					/* uuid 적용 파일 이름 */
					String uuid = UUID.randomUUID().toString();
					vo.setUuid(uuid);
					
					uploadFileName = uuid + "_" + uploadFileName;
					
					/* 파일 위치, 파일 이름을 합친 File 객체 */
					File saveFile = new File(uploadPath, uploadFileName);
					
					/* 파일 저장 */
					try {
						multipartFile.transferTo(saveFile);
						
						File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
						
						BufferedImage bo_image = ImageIO.read(saveFile);

						//비율 
						double ratio = 3;
						//넓이 높이
						int width = (int) (bo_image.getWidth() / ratio);
						int height = (int) (bo_image.getHeight() / ratio);					
					
					
						Thumbnails.of(saveFile).
						size(width, height).
						toFile(thumbnailFile);
						
					} catch (Exception e) {
						e.printStackTrace();
					} 
					list.add(vo);
				}
				ResponseEntity<List<ProductImageVO>> result = new ResponseEntity<List<ProductImageVO>>(list, HttpStatus.OK);
				
				return result;
			}

	// 썸네일 이미지 
	@RequestMapping(value = "display", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getImage(String fileName){
		
		File file = new File("c:\\upload\\" + fileName);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 이미지삭제
	
	@RequestMapping(value = "deleteFile", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName){
		
		File file = null;
		
		try {
			// 썸네일 이미지 삭제
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			// 원본 파일 삭제
			String originFileName = file.getAbsolutePath().replace("s_", "");			
			
			file = new File(originFileName);
			
			file.delete();
			
		}catch(Exception e) {
			e.printStackTrace();
			
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

	// 상품 조회
	@RequestMapping(value = "productDetail", method = RequestMethod.GET)
	public String productDetail(@RequestParam("p_id") String p_id, Model model) throws Exception {

		ProductVO product = memberServiceImpl.productDetail(p_id);
		model.addAttribute("product", product);
		return "product/productDetail";
	}
	@GetMapping(value="getImageList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ProductImageVO>> getImageList(String p_id){
		
		return new ResponseEntity(memberDaoImpl.getImageList(p_id),HttpStatus.OK);	
	}

	// 상품 수정
	@RequestMapping(value = "productModify", method = RequestMethod.GET)
	public String getProductModify(@RequestParam("p_id") String p_id, Model model) throws Exception {

		List<CategoryVO> list = memberServiceImpl.category();

		ProductVO product = memberServiceImpl.productDetail(p_id);
		model.addAttribute("product", product);
		model.addAttribute("category", list);
		
		return "product/productModify";
	}

	@RequestMapping(value = "productModify", method = RequestMethod.POST)
	public String postProductModify(ProductVO vo) throws Exception{

		logger.info("상품 수정 controller.................." + vo);
		memberServiceImpl.productModify(vo);
	
		return "redirect:/productList?c=all&v=brandNew";
	}
	

	// 상품 삭제
	@RequestMapping(value = "productDelete", method = RequestMethod.POST)
	public String deleteProduct(@RequestParam("p_id") String p_id) throws Exception {
		
		List<ProductImageVO> fileList = memberServiceImpl.getImageInfo(p_id);
		
		if(fileList != null) {
			
			List<Path> pathList = new ArrayList();
			
			fileList.forEach(vo ->{
				// 원본 이미지
				Path path = Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
				pathList.add(path);
				
				// 섬네일 이미지
				path = Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid()+"_" + vo.getFileName());
				pathList.add(path);
			});
			
			pathList.forEach(path ->{
				path.toFile().delete();
			});
		}
		
		memberServiceImpl.productDelete(p_id);

		return "redirect:/productList?c=all&v=brandNew";
	}


}
