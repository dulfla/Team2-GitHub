package spring.controller;

import java.io.IOException;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import chat.server.ChatClient;
import chat.server.SocketServer;
import spring.service.ChatService;
import spring.service.MemberServiceImpl;
import spring.vo.AuthInfo;
import spring.vo.ChattingRoomBringingCommand;
import spring.vo.ChattingRoomInfoListVo;
import spring.vo.ProductImageVO;

@Controller
public class ChatConnectionController {

	@Autowired
	private ChatService chatService;
	
	@GetMapping(value = {"SelectChatRoom", "SelectChatRooms", "ChatRoomCheck", "ConnecteWithClientServer", "Chat", "SendMessage", "BreakeOffClientServer", "GetProductImg"})
	public String locationErr(HttpServletRequest request, RedirectAttributes reda) {
		String referer = request.getHeader("Referer");
		String errorMsg = "접속할 수 없는 주소 입니다.";
		reda.addFlashAttribute("errMsg", errorMsg);
	    return "redirect:"+(referer!=null?referer:"index");
	}
	
	@ResponseBody
	@PostMapping("SelectChatRoom")
	public Collection<ChattingRoomInfoListVo> bringingChatRoomByPId(@RequestBody Map<String, String> map) {
		return chatService.selectChatRoomInfoByPId(map.get("p_id"));
	}
	
	@ResponseBody
	@PostMapping("GetProductImg")
	public String selectMainImgForChatting(@RequestBody Map<String, String> map) {
		return chatService.selectImgByPid(map.get("p_id"));
	}
	
	@ResponseBody
	@PostMapping("SelectChatRooms")
	public Map<String, Object> bringingChatRoomByType(HttpSession session) { // @RequestBody Map<String, String> map, 
		String email = ((AuthInfo)session.getAttribute("authInfo")).getEmail();
		Map<String, Object> data = new HashMap<>();
		data.put("person", email);
		data.put("data", chatService.selectChatRoomInfoByEmail(email)); // map.get("email")
		return data;
	}
	
	@ResponseBody
	@PostMapping("ChatRoomCheck")
	public String bringingChatRoomInfo(@RequestBody Map<String, String> map, HttpSession session) {
		ChattingRoomBringingCommand crbc = new ChattingRoomBringingCommand();
		crbc.setP_id(map.get("p_id"));
		crbc.setEmail(map.get("email")); // ((MemberVo)session.getAttribute("authInfo")).getEmail()
		
		return chatService.checkOutChattingRoom(crbc);
	}
	
	@ResponseBody
	@PostMapping("ConnecteWithClientServer")
	public int openClientSoket(@RequestBody Map<String, String> map, HttpSession session) throws IOException {
		ChatClient client = chatService.checkClient(map.get("c_id"), map.get("email"));
		chatService.connection(client, map.get("c_id"), map.get("email"), ((AuthInfo)session.getAttribute("authInfo")).getNickname());
		return 1;
	}
	
	@ResponseBody	
	@PostMapping("Chat")
	public Map<String, Object> chattings(@RequestBody Map<String, String> map, HttpSession session) {
		Map<String, Object> msgList = new HashMap<>();
		msgList.put("productInfo", chatService.productInfo(map.get("c_id"))); // chatService.getProductInfo(map.get("c_id"))
		msgList.put("messages", chatService.getPreviousMessages(map.get("c_id")));
		msgList.put("me", map.get("email"));
		return msgList;
	}
	
	@ResponseBody
	@PostMapping("SendMessage")
	public int sendMessage(@RequestBody Map<String, String> map, HttpSession session) throws IOException {
		ChatClient client = chatService.checkClient(map.get("c_id"), map.get("email"));
		chatService.sendMessage(client, map);
		return 1;
	}

	@ResponseBody
	@PostMapping("BreakeOffClientServer")
	public int closeClientSoket(@RequestBody Map<String, String> map, HttpSession session) throws IOException {
		ChatClient client = chatService.checkClient(map.get("c_id"), map.get("email"));
		chatService.close(client, map.get("c_id"), map.get("email"));
		return 1;
	}
	
}
