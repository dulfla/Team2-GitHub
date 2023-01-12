package chat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	public void getProductInfo(String c) {
		// productVo 반환
	}

	public List<ChatMessageVo> getPreviousMessages(String c_id) {
		return cdao.selectAllMessagesInChatRoom(c_id);
	}
	
}
