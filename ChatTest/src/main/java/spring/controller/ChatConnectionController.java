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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import chat.server.ChatClient;
import chat.server.SocketServer;
import spring.service.ChatService;
import spring.vo.ChattingRoomBringingCommand;
import spring.vo.ChattingRoomInfoListVo;

@Controller
public class ChatConnectionController {
	
	@Autowired
	private SocketServer ss;
	
	@RequestMapping("Server")
	public String server() {
		return "chat/serverOnOff";
	}
	
	@ResponseBody
	@PostMapping("ServerOpen")
	public void serverOpen(HttpServletRequest req) throws IOException { System.out.println("연결 시도");
		ss.start();
		ServletContext app = req.getServletContext();
		app.setAttribute("serverOption", "On");
	}
	
	@ResponseBody
	@PostMapping("ServerClose")
	public void serverClose(HttpServletRequest req) throws IOException { System.out.println("종료 시도");
		ss.stop();
		ServletContext app = req.getServletContext();
		app.setAttribute("serverOption", "Off");
	}
	
	@Autowired
	private ChatService chatService;
	
//	@ResponseBody
//	@PostMapping("SelectChatRoom")
//	public JSONObject bringingChatRoomByPId(@RequestBody Map<String, String> map) {
//		JSONObject json = new JSONObject();
//		json.put("chattingRoomList", chatService.selectChatRoomInfoByPId(map.get("p_id")));
//		System.out.println(json);
//		return json;
//	}
	
	@ResponseBody
	@PostMapping("SelectChatRoom")
	public Collection<ChattingRoomInfoListVo> bringingChatRoomByPId(@RequestBody Map<String, String> map) {
		return chatService.selectChatRoomInfoByPId(map.get("p_id"));
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
		chatService.connection(client, map.get("c_id"), map.get("email"));
		return 1;
	}
	
	@ResponseBody	
	@PostMapping("Chat")
	public Map<String, Object> chattings(@RequestBody Map<String, String> map, HttpSession session) {
		Map<String, Object> msgList = new HashMap<>();
		msgList.put("productInfo", null); // chatService.getProductInfo(map.get("c_id"))
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
