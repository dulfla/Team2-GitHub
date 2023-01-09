package spring.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.business.AdminJsonParsing;
import spring.dao.AdminDao;
import spring.dao.ChatDao;
import spring.vo.ChatInfomationVo;
import spring.vo.CountByYearVo;

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
	private AdminJsonParsing adminJsonParsing;
	
	@RequestMapping("MemberStatus")
	public String memberAdmin(HttpServletRequest request) throws ParseException {
		JSONObject json = adminJsonParsing.memverAdmin();
		request.setAttribute("memberAdmin", json);
		
		return "admin/memberStatus";
	}
	
	@RequestMapping("MemberStatus")
	public String productAdmin(HttpServletRequest request) throws ParseException {
		JSONObject json = adminJsonParsing.productAdmin();
		request.setAttribute("productAdmin", json);
		
		return "admin/productStatus";
	}
	
}
