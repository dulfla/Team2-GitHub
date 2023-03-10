package spring.controller.chat;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import chat.server.ChatClient;
import net.coobird.thumbnailator.Thumbnails;
import spring.service.chat.ChatService;
import spring.vo.chat.ChattingRoomBringingCommand;
import spring.vo.chat.ChattingRoomInfoListVo;
import spring.vo.member.AuthInfo;

@Controller
public class ChattingController {

	@Autowired
	private ChatService chatService;
	
	@ResponseBody
	@RequestMapping("ChattingImage{c_id}{fileName}")
	public ResponseEntity<byte[]> getFile(String c_id, String fileName){
		ResponseEntity<byte[]> img = null;
		File file = new File("c:\\upload\\"+c_id+"\\"+fileName);
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-type", Files.probeContentType(file.toPath()));
			img = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch (IOException e) {
			e.printStackTrace();
		}
		return img;
	}
	
	@GetMapping(value = {"SelectChatRoom", "SelectChatRooms", "ChatRoomCheck", "ConnecteWithClientServer", "Chat", "SendMessage", "ReadMessage", "SendFile", "BreakeOffClientServer", "GetProductImg"})
	public String getTypeAccess(HttpServletRequest request, RedirectAttributes reda) {
		String referer = request.getHeader("Referer");
		// String errorMsg = "????????? ??? ?????? ?????? ?????????.";
		// reda.addFlashAttribute("errMsg", errorMsg);
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
	public Map<String, Object> bringingChatRoomByType(HttpSession session) {
		String email = ((AuthInfo)session.getAttribute("authInfo")).getEmail();
		
		Map<String, Object> data = new HashMap<>();
		data.put("person", email);
		data.put("data", chatService.selectChatRoomInfoByEmail(email));
		return data;
	}
	
	@ResponseBody
	@PostMapping("ChatRoomCheck")
	public String bringingChatRoomInfo(@RequestBody Map<String, String> map, HttpSession session) {
		map.put("email", ((AuthInfo)session.getAttribute("authInfo")).getEmail());
		
		ChattingRoomBringingCommand crbc = new ChattingRoomBringingCommand();
		crbc.setP_id(map.get("p_id"));
		crbc.setEmail(map.get("email"));
		
		return chatService.checkOutChattingRoom(crbc);
	}
	
	@ResponseBody
	@PostMapping("ConnecteWithClientServer")
	public int openClientSoket(@RequestBody Map<String, String> map, HttpSession session) throws IOException {
		map.put("email", ((AuthInfo)session.getAttribute("authInfo")).getEmail());
		map.put("nickName", ((AuthInfo)session.getAttribute("authInfo")).getNickname());
		
		ChatClient client = chatService.checkClient(map.get("c_id"), map.get("email"));
		chatService.connection(client, map.get("c_id"), map.get("email"), map.get("nickName"));
		return 1;
	}
	
	@ResponseBody	
	@PostMapping("Chat")
	public Map<String, Object> chattings(@RequestBody Map<String, String> map, HttpSession session) {
		map.put("email", ((AuthInfo)session.getAttribute("authInfo")).getEmail());
		
		Map<String, Object> msgList = new HashMap<>();
		msgList.put("productInfo", chatService.productInfo(map.get("c_id")));
		msgList.put("messages", chatService.getPreviousMessages(map.get("c_id")));
		msgList.put("me", map.get("email"));
		return msgList;
	}
	
	@ResponseBody
	@PostMapping("SendMessage")
	public int sendMessage(@RequestBody Map<String, String> map, HttpSession session) throws IOException {
		map.put("email", ((AuthInfo)session.getAttribute("authInfo")).getEmail());
		
		ChatClient client = chatService.checkClient(map.get("c_id"), map.get("email"));
		chatService.sendMessage(client, map);
		return 1;
	}
	
	@ResponseBody
	@PostMapping("ReadMessage")
	public int readMessage(@RequestBody Map<String, String> map, HttpSession session) throws IOException {
		map.put("email", ((AuthInfo)session.getAttribute("authInfo")).getEmail());
		
		ChatClient client = chatService.checkClient(map.get("c_id"), map.get("email"));
		chatService.readMessage(client, map);
		return 1;
	}
	
	@ResponseBody
	@PostMapping("SendFile{c_id}{name}")
	public int sendFile(MultipartFile file, String c_id, String name, HttpSession session) throws IOException {
		boolean save = chatService.saveFile(file, c_id, name);
		
		if(save) {
			Map<String, String> map = new HashMap<>();
			map.put("c_id", c_id);
			map.put("email", ((AuthInfo)session.getAttribute("authInfo")).getEmail());
			map.put("message", name);
			map.put("type", "IMG");
			
			ChatClient client = chatService.checkClient(c_id, map.get("email"));
			chatService.sendMessage(client, map);
			
			return 1;
		}else {
			return 2;
		}
	}

	@ResponseBody
	@PostMapping("BreakeOffClientServer")
	public int closeClientSoket(@RequestBody Map<String, String> map, HttpSession session) throws IOException {
		map.put("email", ((AuthInfo)session.getAttribute("authInfo")).getEmail());
		
		ChatClient client = chatService.checkClient(map.get("c_id"), map.get("email")); 
		if(!client.getSocket().isClosed()) {
			chatService.close(client, map.get("c_id"), map.get("email"));
		}else {
			return 2;
		}
		return 1;
	}
	
}
