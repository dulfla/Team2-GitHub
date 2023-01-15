package spring.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import chat.service.ChatService;
import spring.vo.ChatMessageVo;
import spring.vo.ChattingRoomBringingCommand;
import spring.vo.MemberVo;

@Controller
public class ChatConnectionController {
	
	@RequestMapping("PD")
	public String pdpage() {
		return "product/productDetail";
	}
	
	@Autowired
	private ChatService chatService;
	
	@ResponseBody
	@PostMapping("SelectChatRoom")
	public JSONObject bringingChatRoomByPId(@RequestBody Map<String, String> map) {
		JSONObject json = new JSONObject();
		json.put("chattingRoomList", chatService.selectChatRoomInfoByPId(map.get("p_id")));
		return json;
	}
	
	@ResponseBody
	@PostMapping("ChatRoomCheck")
	public JSONObject bringingChatRoomInfo(@RequestBody Map<String, String> map, HttpSession session) {
//		MemberVo auth = new MemberVo();
//		auth.setEmail("hong@naver.com");
//		session.setAttribute("authInfo", auth);
		
		ChattingRoomBringingCommand crbc = new ChattingRoomBringingCommand();
		crbc.setP_id(map.get("p_id"));
		crbc.setEmail(map.get("email"));
		// "hong@naver.com" // ((MemberVo)session.getAttribute("authInfo")).getEmail()
		
		JSONObject json = new JSONObject();
		json.put("chattingRoomId", chatService.checkOutChattingRoom(crbc));
		
		// 클라이언트 생성
		
		return json;
	}
	
	@ResponseBody
	@PostMapping("ConnecteWithClientServer")
	public int openClientSoket(@RequestBody Map<String, String> map, HttpSession session) {
		chatService.connection(map.get("c_id"), map.get("email"));
		return 1;
	}
	
	@ResponseBody	
	@PostMapping("Chat")
	public JSONObject chattings(@RequestBody Map<String, String> map, HttpSession session) {
		JSONObject json = new JSONObject();
		json.put("productInfo", chatService.getProductInfo(map.get("c_id")));
		json.put("messages", chatService.getPreviousMessages(map.get("c_id")));
		json.put("me", map.get("email"));
		return json;
	}
	
	@ResponseBody
	@PostMapping("SendMessage")
	public void sendMessage(@RequestBody Map<String, String> map, HttpSession session) {
		System.out.println("메세지 보내기, 보낼 채팅방 아이디 : "+map.get("c_id"));
		System.out.println("메세지 보내기, 관련된 상품 아이디 : "+map.get("p_id"));
		System.out.println("메세지 보내기, 보내는 사람 이메일 : "+map.get("email"));
		System.out.println("메세지 보내기, 보낼 메세지 : "+map.get("message"));
		return;
	}

	@ResponseBody
	@PostMapping("BreakeOffClientServer")
	public int closeClientSoket(@RequestBody Map<String, String> map, HttpSession session) {
		chatService.close(map.get("c_id"), map.get("email"));
		return 1;
	}
	
}
