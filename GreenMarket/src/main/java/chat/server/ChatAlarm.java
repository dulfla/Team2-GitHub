package chat.server;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import spring.service.chat.ChatService;

@Component
public class ChatAlarm extends TextWebSocketHandler{

	@Autowired
	private ChatService cs;
	
	private Map<String, Collection<WebSocketSession>> alarmSession = new HashMap<>();
	
	@Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		Map<String, String> info = getURIInfos(session);
    	String key = info.get("email");
    	
    	if(alarmSession.containsKey(key)) {
    		alarmSession.get(key).add(session);
    	}else {
    		List<WebSocketSession> list = new ArrayList<>();
    		list.add(session);
    		alarmSession.put(key, list);
    	}
    }
	
	@Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		Map<String, String> info = getURIInfos(session);
    	String key = info.get("email");
    	
    	alarmSession.get(key).remove(session);
    }
	
	private Map<String, String> getURIInfos(WebSocketSession session) {
    	Map<String, String> info = new HashMap<>();
    	String[] sources = session.getUri().toString().split("\\?")[1].split("&");
        for(int i=0; i<sources.length; i++) {
        	String[] str = sources[i].split("=");
        	info.put(str[0], str[1]);
        }
		return info;
	}
	
	protected void sendMessage(WebSocketSession session, String root) throws Exception {
        session.sendMessage(new TextMessage(root));
    }

	public void checkJoin(String c_id, String email) {
		List<String> member = cs.selectChatMemberInChatRoom(c_id);
		for(String e : member) {
			if(!e.equals(email)) {
				if(alarmSession.containsKey(email)) {
					Collection<WebSocketSession> aws = alarmSession.get(email);
					if(aws.size()!=0) {
						for(WebSocketSession w : aws) {
							try {
								sendMessage(w, c_id);
							} catch (Exception e1) {
								e1.printStackTrace();
							}
						}
					}
				}
			}
		}
	}
 
}
