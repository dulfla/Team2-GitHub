package spring.service;

import java.io.IOException;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import chat.server.ChatClient;
import chat.server.ChattingWebSocket;
import chat.server.SocketServer;
import oracle.net.aso.c;
import spring.dao.ChatDao;
import spring.vo.ChatMessageVo;
import spring.vo.ChatProductInfoVo;
import spring.vo.ChattingRoomBringingCommand;
import spring.vo.ChattingRoomInfoListVo;
import spring.vo.ProductImageVO;

@Service
public class ChatService {

	@Autowired
	private ChatDao cdao;
	
	@Autowired
	private SocketServer ss;
	
	@Autowired
	private ChattingWebSocket cws;
	
	private static Map<String, Map<String, ChatClient>> chatRoom = Collections.synchronizedMap(new HashMap<>());
	private JSONObject json;
	
	public String checkOutChattingRoom(ChattingRoomBringingCommand crbc) {
		String result =  cdao.selectChattingRoom(crbc);
		if(result==null) {
			result = cdao.insertNewChatRoomInfo(crbc);
		}
		return result;
	}

	public List<ChatMessageVo> getPreviousMessages(String c_id) {
		return cdao.selectAllMessagesInChatRoom(c_id);
	}

	public void connection(ChatClient client, String c_id, String email, String name) throws IOException {
		client.setSs(ss);
		client.setCws(cws);
		client.setChatRoom(c_id);
		client.setChatName(email);
		client.setClientNickname(name);
		client.connect();
		
		json = new JSONObject();
		json.put("command", "incoming");
		json.put("name", name);
		json.put("who", email);
		json.put("room", c_id);
		String jsonStr = json.toString();
		client.send(jsonStr);
	}

	public void sendMessage(ChatClient client, Map<String, String> map) throws IOException {
		ChatMessageVo msgVo = new ChatMessageVo();
		msgVo.setSender(map.get("email"));
		msgVo.setMessage(map.get("message"));
		msgVo.setMessType("TEXT");
		msgVo.setC_id(map.get("c_id"));
		cdao.insertMessage(msgVo);
		
		json = new JSONObject();
		json.put("command", "message");
		json.put("msgIdx", msgVo.getIdx());
		json.put("room", msgVo.getC_id());
		json.put("who", msgVo.getSender());
		String jsonStr = json.toString();
		client.send(jsonStr);
	}

	public void close(ChatClient client, String c_id, String email) throws IOException {
		if(client!=null) {
			client.unconnect();
			chatRoom.get(c_id).remove(email, client);
		}
	}

	public Collection<ChattingRoomInfoListVo> selectChatRoomInfoByPId(String p_id) {
		return cdao.selectChattingRoomByPId(p_id);
	}

	public ChatClient checkClient(String c_id, String email) {
		Collection<String> cr = chatRoom.keySet();
		if(0<cr.size()) {
			for(String id : cr) {
				if(id.equals(c_id)) {
					Collection<Map<String, ChatClient>> clients = chatRoom.values();
					for(Map<String, ChatClient> cl : clients) {
						Collection<String> emails = cl.keySet();
						for(String e : emails) {
							if(e.equals(email)) {
								return cl.get(email);
							}
						}
						ChatClient client = new ChatClient();
						cl.put(email, client);
						return client;
					}
				}
			}
		}
		Map<String, ChatClient> list = Collections.synchronizedMap(new HashMap<>());
		ChatClient client = new ChatClient();
		list.put(email, client);
		chatRoom.put(c_id, list);
		return client;
	}

	public ChatMessageVo selectSendedMessage(long idx) {
		return cdao.selectSendedMessage(idx);
	}

	public Collection<ChattingRoomInfoListVo> selectChatRoomInfoByEmail(String email) {
		return cdao.selectChattingRoomByEmail(email);
	}

	public ChatProductInfoVo productInfo(String c_id) {
		return cdao.selectProductByChatRoomId(c_id);
	}

	public String selectImgByPid(String p_id) {
		ProductImageVO pdImgInfo = cdao.selectProductImg(p_id);
		String imgUrl = "";
		if(pdImgInfo!=null) {
			imgUrl += pdImgInfo.getUploadPath().substring(0, 4)+"%5C"+pdImgInfo.getUploadPath().substring(5, 7)+"%5C"+pdImgInfo.getUploadPath().substring(8);
			imgUrl += "%2Fs_"+pdImgInfo.getUuid()+"_"+pdImgInfo.getFileName();
		}else {
			imgUrl = null;
		}
		return imgUrl;
	}
	
}
