package spring.controller;

import java.util.List;
import java.util.Map;

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

	public static void main(String[] args) {
		// server는 기본적으로 자동 실행
		
		// 채팅하기를 눌러서 채팅방을 열 때까지의 과정
		
		/* 1. 선택한 물건의 채팅방 목록 확인하기 :: bringingChatRoomInfo()
		
			기본적으로 채팅하기 버튼을 누르면 javascript에서 해당 상품의 p_id와 내 로그인 정보의 email을 ajax로 넘겨서
			해당 p_id에 할당된 채팅방이 존재하는지, 해당 채팅방 중 내가 속한 채팅방이 존재하는지 확인 하고,
			내가 속한 c_id가 존재한다면 해당 c_id 반환, 없을 경우 새로운 c_id를 만들어서 반환하고, 해당 내용을 chatInfo~Tbl에 insert			   
		*/
	}
	
	@RequestMapping("PD")
	public String pdpage() {
		return "product/productDetail";
	}
	
	@Autowired
	private ChatService chatService;
	
	@ResponseBody
	@PostMapping("ChatRoomCheck")
	public JSONObject bringingChatRoomInfo(@RequestBody Map<String, String> map, HttpSession session) {
		ChattingRoomBringingCommand crbc = new ChattingRoomBringingCommand();
		crbc.setP_id(map.get("p_id"));
		crbc.setEmail("hong@naver.com"); // ((MemberVo)session.getAttribute("member")).getEmail()
		
		JSONObject json = new JSONObject();
		json.put("chattingRoomId", chatService.checkOutChattingRoom(crbc));
		
		// 클라이언트 생성
		
		return json;
	}
	
	@ResponseBody
	@PostMapping("ConnecteWithClientServer")
	public Object openClientSoket(@RequestBody Map<String, String> map, HttpSession session) {
		System.out.println(map.get("c_id")+"에 클라이언트 연결 실행");
		chatService.connection("hong@naver.com"); // ((MemberVo)session.getAttribute("AuthInfo")).getEmail()
		return null;
	}
	
	@ResponseBody	
	@PostMapping("Chat")
	public JSONObject chattings(@RequestBody Map<String, String> map, HttpSession session) {
		JSONObject json = new JSONObject();
		json.put("productInfo", chatService.getProductInfo(map.get("c_id")));
		json.put("messages", chatService.getPreviousMessages(map.get("c_id")));
		json.put("me", "hong@naver.com"); // ((MemberVo)session.getAttribute("member")).getEmail()
//		JSONArray list = (JSONArray)json.get("messages");
//		System.out.println(list);
//		for(int i=0; i<list.length(); i++) {
//			System.out.println(list.get(i));
//		}
		return json;
	}
	
	@ResponseBody
	@PostMapping("SendMessage")
	public void sendMessage(@RequestBody Map<String, String> map) {
		System.out.println(map.get("c_id"));
		System.out.println(map.get("p_id"));
		System.out.println(map.get("email"));
		System.out.println(map.get("message"));
		System.out.println("서버 안녕");
		return;
	}

	@ResponseBody
	@PostMapping("BreakeOffClientServer")
	public Object closeClientSoket(@RequestBody Map<String, String> map, HttpSession session) {
		System.out.println("클라이언트 연결 해제");
		chatService.close("hong@naver.com"); // ((MemberVo)session.getAttribute("AuthInfo")).getEmail()
		return null;
	}
	
}
