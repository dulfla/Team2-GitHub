package spring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.HttpSessionRequiredException;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.business.AdminJsonParsing;
import spring.dao.AdminDao;
import spring.dao.ChatDao;
import spring.vo.ChatInfomationVo;
import spring.vo.CountVo;

@Controller
public class SampleController {

	@RequestMapping("PD")
	public String productDetatil() {
		return "product/productDetail";
	}
	
//--------------------------------------------------------------------------------------
	
	@Autowired
	private ChatDao c_dao;

	@RequestMapping("Chat")
	public String chat() {
		return "chat/chatting";
	}
	
	@RequestMapping("ChatRoom")
	public String chatRoom(HttpServletRequest request) {
		String email = request.getParameter("email");
		List<ChatInfomationVo> list = c_dao.selectAllChatRoomInfo(email);
		request.setAttribute("chatRoomList", list);
		return "chat/chattingRoom";
	}
	
//--------------------------------------------------------------------------------------
	
	@Autowired
	private AdminDao a_dao;
	
	@Autowired
	private AdminJsonParsing adminJsonParsing;
	
	@RequestMapping("MemberStatus")
	public String memberAdmin(HttpServletRequest request) {
		
		JSONObject json = adminJsonParsing.memverAdmin(a_dao);
		
		return "admin/memberStatus";
	}
	
	@RequestMapping("ProductStatus")
	public String productAdmin() {
		return "admin/productStatus";
	}
	
}
