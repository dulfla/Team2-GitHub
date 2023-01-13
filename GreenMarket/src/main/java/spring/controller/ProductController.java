package spring.controller;

import java.io.Console;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;

import spring.service.MemberService;
import spring.service.MemberServiceImpl;
import spring.vo.CategoryVO;
import spring.vo.Product1VO;
import spring.vo.ProductVO;

@Controller
public class ProductController {

	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

	@Autowired
	private MemberServiceImpl memberServiceImpl;

	// 카테고리
	@RequestMapping(value = "/product/register", method = RequestMethod.GET)
	public String registerProduct(Model model) throws Exception {

		List<CategoryVO> list = memberServiceImpl.category();

		model.addAttribute("category", list);

		return "product/productReg";
	}

	// 상품 등록
	@RequestMapping(value = "/product/register", method = RequestMethod.POST)
	public String registerProduct(ProductVO vo, Product1VO vo1) {
		;

		memberServiceImpl.productRegister(vo, vo1);

		return "redirect:/index";
	}

	// 상품 조회
	@RequestMapping(value = "/product/productDetail", method = RequestMethod.GET)
	public void productDetail(@RequestParam("p_id") String p_id, Model model) throws Exception {

		ProductVO product = memberServiceImpl.productDetail(p_id);
		model.addAttribute("product", product);
	}

	// 상품 수정
	@RequestMapping(value = "/product/productModify", method = RequestMethod.GET)
	public void getProductModify(@RequestParam("p_id") String p_id, Model model) throws Exception {

		List<CategoryVO> list = memberServiceImpl.category();

		ProductVO product = memberServiceImpl.productDetail(p_id);
		model.addAttribute("product", product);
		model.addAttribute("category", list);
	}

	@RequestMapping(value = "/product/productModify", method = RequestMethod.POST)
	public String postProductModify(ProductVO vo) throws Exception{

		 memberServiceImpl.productModify(vo);

		return "redirect:/index";
	}

	// 상품 삭제
	@RequestMapping(value = "/product/productDelete", method = RequestMethod.POST)
	public String deleteProduct(@RequestParam("p_id") String p_id) throws Exception {

		memberServiceImpl.productDelete(p_id);

		return "redirect:/index";
	}


}
