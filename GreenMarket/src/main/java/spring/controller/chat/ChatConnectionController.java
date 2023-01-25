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
public class ChatConnectionController {

	@Autowired
	private ChatService chatService;
	
	@GetMapping(value = {"SelectChatRoom", "SelectChatRooms", "ChatRoomCheck", "ConnecteWithClientServer", "Chat", "SendMessage", "SendFile", "BreakeOffClientServer", "GetProductImg"})
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
	@PostMapping("SelectChatRooms{email}")
	public Map<String, Object> bringingChatRoomByType(HttpSession session, String email) { // @RequestBody Map<String, String> map, 
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
		chatService.connection(client, map.get("c_id"), map.get("email"), chatService.getNickName(map.get("email"))); // ((AuthInfo)session.getAttribute("authInfo")).getNickname()
		return 1;
	}
	
	@ResponseBody	
	@PostMapping("Chat")
	public Map<String, Object> chattings(@RequestBody Map<String, String> map) {
		Map<String, Object> msgList = new HashMap<>();
		msgList.put("productInfo", chatService.productInfo(map.get("c_id"))); // chatService.getProductInfo(map.get("c_id"))
		msgList.put("messages", chatService.getPreviousMessages(map.get("c_id")));
		msgList.put("me", map.get("email"));
		return msgList;
	}
	
	@ResponseBody
	@PostMapping("SendMessage")
	public int sendMessage(@RequestBody Map<String, String> map) throws IOException {
		ChatClient client = chatService.checkClient(map.get("c_id"), map.get("email"));
		chatService.sendMessage(client, map);
		return 1;
	}
	
	@ResponseBody
	@PostMapping("SendFile{c_id}{email}{name}")
	public int sendFile(MultipartFile file, String c_id, String email, String name) throws IOException {
		boolean save = chatService.saveFile(file, c_id, name);
		
		if(save) {
			Map<String, String> map = new HashMap<>();
			map.put("c_id", c_id);
			map.put("email", email);
			map.put("message", name);
			map.put("type", "IMG");
			
			ChatClient client = chatService.checkClient(c_id, email);
			chatService.sendMessage(client, map);
			
			return 1;
		}else {
			return 2;
		}
	}
	
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

	@ResponseBody
	@PostMapping("BreakeOffClientServer")
	public int closeClientSoket(@RequestBody Map<String, String> map) throws IOException {
		ChatClient client = chatService.checkClient(map.get("c_id"), map.get("email"));
		chatService.close(client, map.get("c_id"), map.get("email"));
		return 1;
	}
	
}
