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
import chat.server.SocketServer;
import spring.dao.ChatDao;
import spring.vo.ChatMessageVo;
import spring.vo.ChattingRoomBringingCommand;
import spring.vo.ChattingRoomInfoListVo;

@Service
public class ChatService {

	@Autowired
	private ChatDao cdao;
	
	private static Map<String, Map<String, ChatClient>> chatRoom = Collections.synchronizedMap(new HashMap<>());
	private JSONObject json;
	
	public String checkOutChattingRoom(ChattingRoomBringingCommand crbc) {
		String result =  cdao.selectChattingRoom(crbc);
		if(result==null) {
			result = cdao.insertNewChatRoomInfo(crbc);
		}
		return result;
	}

	public JSONArray getPreviousMessages(String c_id) {
		List<ChatMessageVo> messageList = cdao.selectAllMessagesInChatRoom(c_id);
		JSONArray arr = new JSONArray();
		for(int i=0; i<messageList.size(); i++) {
			JSONObject json = new JSONObject();
			json.put("message", messageList.get(i).getMessage());
			json.put("messType", messageList.get(i).getMessType());
			json.put("sender", messageList.get(i).getSender());
			json.put("read", messageList.get(i).getRead());
			json.put("send_date", messageList.get(i).getSend_date());
			arr.put(json);
		}
		return arr;
	}

	public void connection(ChatClient client, String c_id, String email) throws IOException {
		client.setChatRoom(c_id);
		client.setChatName(email);
		client.connect();
		
		json = new JSONObject();
		json.put("command", "incoming");
		json.put("who", email);
		json.put("room", c_id);
		String jsonStr = json.toString();
		client.send(jsonStr);
		
		System.out.println(System.currentTimeMillis()+" : "+email+", "+c_id+"에 연결 완료");
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
		System.out.println(System.currentTimeMillis()+" : "+email+", "+c_id+"에 연결 해제");
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
	
}