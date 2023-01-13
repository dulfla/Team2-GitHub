package chat.service;

import java.util.List;

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

	public List<ChatMessageVo> getPreviousMessages(String c_id) {
		return cdao.selectAllMessagesInChatRoom(c_id);
	}

	public void connection(String email) {
		System.out.println(System.currentTimeMillis()+" : "+email+" 서버에 연결 완료");
	}

	public void close(String email) {
		System.out.println(System.currentTimeMillis()+" : "+email+" 서버와 연결 해제");
	}
	
}
