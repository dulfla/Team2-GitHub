package spring.controller;

import java.util.List;

import javax.inject.Inject;

import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.databind.ObjectMapper;

import spring.service.MemberService;
import spring.vo.CategoryVO;

@Controller
@RequestMapping
public class ProductController {

	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	
	@Autowired
	private MemberService memberService;
	
	
	@RequestMapping(value="/product/register", method = RequestMethod.GET)
	public void registerProduct(Model model) throws Exception {
		logger.info("product register");
		
		ObjectMapper objm = new ObjectMapper();
		
		List list = memberService.category();
		
		String category = objm.writeValueAsString(list);
		
		model.addAttribute("category", category);
	
		
	}
}
