package spring.service.admin;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnails;
import spring.dao.admin.AdminDao;
import spring.vo.admin.CategoryAdminVo;

@Service
public class CategoryAdminService {

	@Autowired
	private AdminDao dao;
	
	public void deleteCategory(Map<String, String> map) {
		String originFileName = dao.originFileName(map.get("category"));
		String originFile = "C:\\upload\\category";
		File fileObj = new File(originFile, originFileName);
		if(fileObj.exists()) {
		    fileObj.delete();
		}
		
		dao.updateProduct(map);
		dao.deleteCategory(map.get("category"));
	}

	public void modifyCategoryTitle(Map<String, String> map) {
		String originFileName = dao.originFileName(map.get("category"));
		String originFileType = originFileName.substring(originFileName.lastIndexOf(".")+1);
		String newFileName = map.get("data")+"."+originFileType;
		
		Path file = Paths.get("C:\\upload\\category\\"+originFileName);
        Path newFile = Paths.get("C:\\upload\\category\\"+newFileName);
 
        try {
            Path newFilePath = Files.move(file, newFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        map.put("icon", newFileName);
        
		dao.updateCategory(map);
		
        if(!map.get("data").equals(map.get("move"))) {
        	dao.updateProduct(map);
        }
	}

	public int modifyCategoryIcon(MultipartFile file, String c, String fileType) {
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

	public ResponseEntity<byte[]> getImg(String fileName) {
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

	public int registerCategory(MultipartFile file, String c, String fileType) {
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

	
	
}
