package spring.controller.product;

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
import spring.dao.product.ProductDaoImp;
import spring.service.member.MemberService;
import spring.service.member.MemberServiceImpl;
import spring.vo.member.Member;
import spring.vo.product.CategoryVO;
import spring.vo.product.Product1VO;
import spring.vo.product.ProductImageVO;
import spring.vo.product.ProductVO;

@Controller
public class ProductController {

	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

	@Autowired
	private MemberServiceImpl memberServiceImpl;
	@Autowired
	private ProductDaoImp memberDaoImpl;

	// ????????????
	@RequestMapping(value = "productRegister", method = RequestMethod.GET)
	public String registerProduct(Model model) throws Exception {

		List<CategoryVO> list = memberServiceImpl.category();

		model.addAttribute("category", list);

		return "product/productReg";
	}

	// ?????? ??????
	@RequestMapping(value = "productRegister", method = RequestMethod.POST)
	public String registerProduct(ProductVO vo, Product1VO vo1) {		
		
		String[] uuids = vo.getImageList().get(0).getUuid().split(",");
		String[] fileNames = vo.getImageList().get(0).getFileName().split(",");
		String[] uploadPaths = vo.getImageList().get(0).getUploadPath().split(",");
		List<ProductImageVO> imgVoList = new ArrayList<>();
		for(int i=0; i<uuids.length; i++) {
			ProductImageVO img = new ProductImageVO();
			img.setFileName(fileNames[i]);
			img.setUploadPath(uploadPaths[i]);
			img.setUuid(uuids[i]);
			imgVoList.add(img);
		}
		
		memberServiceImpl.productRegister(vo, vo1, imgVoList);

		return "redirect:/productList?c=all&v=brandNew";
	}
	// ?????????
	@RequestMapping(value = "uploadAjaxAction",
			produces = MediaType.APPLICATION_JSON_VALUE ,method = RequestMethod.POST)
	public ResponseEntity<List<ProductImageVO>> uploadAjaxActionPOST(@RequestParam MultipartFile[] uploadFile) {		
		
		/* ????????? ?????? ?????? */
		for(MultipartFile multipartFile: uploadFile) {
			
			File checkfile = new File(multipartFile.getOriginalFilename());
			String type = null;
			
			try {
				type = Files.probeContentType(checkfile.toPath());
			} catch (IOException e) {
				e.printStackTrace();
			}
			if(!type.startsWith("image")) {
				
				List<ProductImageVO> list = null;
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
				
			}
			
		}
		
		String uploadFolder = "C:\\upload";
		
		// ?????? ?????? ??????
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		String datePath = str.replace("-", File.separator);
		
		// ?????? ??????
		File uploadPath = new File(uploadFolder, datePath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		// ????????? ?????? ?????? ??????
		List<ProductImageVO> list = new ArrayList();
		
		// ????????? for
				for(MultipartFile multipartFile : uploadFile) {		
					
					/* ????????? ?????? ?????? */
					ProductImageVO vo = new ProductImageVO();
					
					/* ?????? ?????? */
					String uploadFileName = multipartFile.getOriginalFilename();
					vo.setFileName(uploadFileName);
					vo.setUploadPath(datePath);
					
					/* uuid ?????? ?????? ?????? */
					String uuid = UUID.randomUUID().toString();
					vo.setUuid(uuid);
					
					uploadFileName = uuid + "_" + uploadFileName;
					
					/* ?????? ??????, ?????? ????????? ?????? File ?????? */
					File saveFile = new File(uploadPath, uploadFileName);
					
					/* ?????? ?????? */
					try {
						multipartFile.transferTo(saveFile);
						
						File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
						
						BufferedImage bo_image = ImageIO.read(saveFile);

						//?????? 
						double ratio = 3;
						//?????? ??????
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

	// ????????? ????????? 
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
	
	// ???????????????
	
	@RequestMapping(value = "deleteFile", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName){
		
		File file = null;
		
		try {
			// ????????? ????????? ??????
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			// ?????? ?????? ??????
			String originFileName = file.getAbsolutePath().replace("s_", "");			
			
			file = new File(originFileName);
			
			file.delete();
			
		}catch(Exception e) {
			e.printStackTrace();
			
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

	// ?????? ??????
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

	// ?????? ??????
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
	
		String[] uuids = vo.getImageList().get(0).getUuid().split(",");
		String[] fileNames = vo.getImageList().get(0).getFileName().split(",");
		String[] uploadPaths = vo.getImageList().get(0).getUploadPath().split(",");
		List<ProductImageVO> imgVoList = new ArrayList<>();
		for(int i=0; i<uuids.length; i++) {
			ProductImageVO img = new ProductImageVO();
			img.setFileName(fileNames[i]);
			img.setUploadPath(uploadPaths[i]);
			img.setUuid(uuids[i]);
			imgVoList.add(img);
		}

		memberServiceImpl.productModify(vo, imgVoList);

		
		return "redirect:/myProduct";
	}
	

	// ?????? ??????
	@RequestMapping(value = "productDelete", method = RequestMethod.POST)
	public String deleteProduct(@RequestParam("p_id") String p_id) throws Exception {
		
		List<ProductImageVO> fileList = memberServiceImpl.getImageInfo(p_id);
		
		if(fileList != null) {
			
			List<Path> pathList = new ArrayList();
			
			fileList.forEach(vo ->{
				// ?????? ?????????
				Path path = Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
				pathList.add(path);
				
				// ????????? ?????????
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
