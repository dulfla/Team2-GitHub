package chat.service;

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
import chat.vo.ProductVo;
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

	public ProductVo getProductInfo(String c) {
		return null;
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
		client.recive();
	}

	public void close(ChatClient client, String c_id, String email) throws IOException {
		if(client!=null) {
			client.unconnect();
			chatRoom.get(c_id).remove(email);
		}
		// 근데 이걸 그냥 이렇게만 해도 되나 싶긴 한데,,. 여러사람이 쓰거나, 한사람이 어려개의 client를 만들 경우는 어떻게 될지 확인 해야 함
		// 알아서 잘 구분 하는 듯. 한 이메일로 두개 들어가서 하나씩 연결 해제 해 봤는데, 둘다 알아서 잘 인식해서 끊김
		// 놉! 1번 연결하고 2번 연결 한 다음 2번을 끊을 때는 잘 되지만, 1번 연결 -> 2번 연결 후 1번을 끊을 때는 1번이 아니라 2번이 끊김
		System.out.println(System.currentTimeMillis()+" : "+email+", "+c_id+"에 연결 해제");
	}

	public Collection<ChattingRoomInfoListVo> selectChatRoomInfoByPId(String p_id) {
		return cdao.selectChattingRoomByPId(p_id);
	}

	public ChatClient checkClient(String c_id, String email) {
		Collection<String> cr = chatRoom.keySet();System.out.println(cr.size());
		if(0<cr.size()) {System.out.println("cr : 뭐가 됐든 있긴 있음");
			for(String id : cr) {
				if(id.equals(c_id)) {System.out.println("c_id : 해당 채팅방 있음");
					Collection<Map<String, ChatClient>> clients = chatRoom.values();
					for(Map<String, ChatClient> cl : clients) {System.out.println("cl : 해당 클라이언트가 이미 존재함");
						Collection<String> emails = cl.keySet();
						for(String e : emails) {
							if(e.equals(email)) {
								return cl.get(email);
							}
						}System.out.println("cl : 클라이언트 생성");
						ChatClient client = new ChatClient();
						cl.put(email, client);
						return client;
					}
				}else {System.out.println("c_id : 채팅방부터 만듦");
					Map<String, ChatClient> list = Collections.synchronizedMap(new HashMap<>());
					ChatClient client = new ChatClient();
					list.put(email, client);
					chatRoom.put(c_id, list);
					return client;
				}
			}
		}else {System.out.println("cr : 아예 아무것도 없음");
			Map<String, ChatClient> list = Collections.synchronizedMap(new HashMap<>());
			ChatClient client = new ChatClient();
			list.put(email, client);
			chatRoom.put(c_id, list);
			return client;
		}
		return null;
	}

	public ChatMessageVo selectSendedMessage(long idx) {
		return cdao.selectSendedMessage(idx);
	}
	
}
