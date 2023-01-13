package chat.service;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import chat.vo.ProductVo;
import spring.dao.ChatDao;
import spring.vo.ChatMessageVo;
import spring.vo.ChattingRoomBringingCommand;

@Service
public class ChatService {

	@Autowired
	private ChatDao cdao;
	
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

	public void connection(String email) {
		System.out.println(System.currentTimeMillis()+" : "+email+" 서버에 연결 완료");
	}

	public void close(String email) {
		System.out.println(System.currentTimeMillis()+" : "+email+" 서버와 연결 해제");
	}
	
}
