package spring.controller.main;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.dao.admin.AdminDao;

@Controller
public class MainController {

	@Autowired
	private AdminDao adao;
	
	@RequestMapping({"/", "/index", "/main", "/Index", "Main"})
	public String moveToMain(Model model) {
		model.addAttribute("categoryList", adao.getAllCategory());
		
		
		return "index";
	}	
}
