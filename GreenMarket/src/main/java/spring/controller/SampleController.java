package spring.controller;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SampleController {
	
	@RequestMapping("PD")
	public String productDetatil() {
		return "product/productDetail";
	}
	
	@RequestMapping("Chat")
	public String chat() {
		return "chat/chatting";
	}
	
	@RequestMapping("Chatting")
	public JSONObject chatting() {
		
		
		return null;
	}
	
}
