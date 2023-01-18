package spring.controller;

import java.io.IOException;
import java.net.Socket;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
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

import chat.server.ChatClient;
import chat.server.SocketClient;
import chat.server.SocketServer;
import chat.service.ChatService;
import spring.vo.ChatMessageVo;
import spring.vo.ChattingRoomBringingCommand;
import spring.vo.MemberVo;

@Controller
public class ChatConnectionController {
	
	@Autowired
	private SocketServer ss;
	
	@RequestMapping("PD")
	public String pdpage() throws IOException {
		ss.start();
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
		ChattingRoomBringingCommand crbc = new ChattingRoomBringingCommand();
		crbc.setP_id(map.get("p_id"));
		crbc.setEmail(map.get("email")); // ((MemberVo)session.getAttribute("authInfo")).getEmail()
		
		JSONObject json = new JSONObject();
		json.put("chattingRoomId", chatService.checkOutChattingRoom(crbc));
		return json;
	}
	
	@ResponseBody
	@PostMapping("ConnecteWithClientServer")
	public int openClientSoket(@RequestBody Map<String, String> map, HttpSession session) throws IOException {
		ChatClient client = chatService.checkClient(map.get("c_id"), map.get("email"));
		chatService.connection(client, map.get("c_id"), map.get("email"));
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
