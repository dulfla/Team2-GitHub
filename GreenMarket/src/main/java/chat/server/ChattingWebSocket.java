package chat.server;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class ChattingWebSocket extends TextWebSocketHandler{
    
	private static Map<String, Map<String, Collection<WebSocketSession>>> webSessions = Collections.synchronizedMap(new HashMap<>());
	
    @Autowired
    private SocketServer ss;
    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	System.out.println(session.getId()+", WebSocket 연결");
        Map<String, String> info = getURIInfos(session);
    	String key = info.get("email"); // +"@"+session.getId()
    	
    	saveThisWebsession(info, session);
    }

    private void saveThisWebsession(Map<String, String> info, WebSocketSession session) {
    	if(0<webSessions.size()) {
			if(webSessions.containsKey(info.get("c_id"))) {
				if(webSessions.get(info.get("c_id")).containsKey(info.get("email"))) {
					if(! webSessions.get(info.get("c_id")).get(info.get("email")).contains(session)) {
						webSessions.get(info.get("c_id")).get(info.get("email")).add(session);
					}
					return;
				}
				List<WebSocketSession> wscL = new ArrayList<>();
				wscL.add(session);
				webSessions.get(info.get("c_id")).put(info.get("email"), wscL);
				return;
			}
		}
		List<WebSocketSession> wscL = new ArrayList<>();
		wscL.add(session);
		Map<String, Collection<WebSocketSession>> map = new HashMap<>();
		map.put(info.get("email"), wscL);
		webSessions.put(info.get("c_id"), map);
	}

	@Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println(session.getId()+", WebSocket 분리");
    	Map<String, String> info = getURIInfos(session);
    	
        removeThisWebsession(info, session);
    }
    
    private void removeThisWebsession(Map<String, String> info, WebSocketSession session) {
    	String key = info.get("email");
		webSessions.get(info.get("c_id")).get(key).remove(session);
		if(webSessions.get(info.get("c_id")).get(key).size()==0) {
			webSessions.get(info.get("c_id")).remove(key);
		}
	}

	protected void sendMessage(WebSocketSession session, JSONObject root) throws Exception {
    	String msgPack = "";
    	if(root.getString("messType").equals("READ")) {
    		msgPack = "chatName:"+root.getString("chatName")+","
					+"room:"+root.getString("room")+","
					+"message:null,"
					+"messType:"+root.getString("messType")+","
					+"nickName:null,"
					+"msgIdx:"+root.getInt("msgIdx");
    	}else {
    		msgPack = "chatName:"+root.getString("chatName")+","
					+"room:"+root.getString("room")+","
					+"message:"+root.getString("message")+","
					+"messType:"+root.getString("messType")+","
					+"nickName:"+root.getString("clientNickname")+","
					+"msgIdx:"+root.getInt("msgIdx");
    	}
        session.sendMessage(new TextMessage(msgPack));
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

	public void sendMessageThisSession(String s, JSONObject root) {
		Collection<WebSocketSession> ws = webSessions.get(root.getString("room")).get(s);
		for(WebSocketSession w : ws) {
			try {
				sendMessage(w, root);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void closeAll() {
		Collection<Map<String, Collection<WebSocketSession>>> sLs = webSessions.values();
		for(int i=0; i<sLs.size(); i++) {
			Map<String, Collection<WebSocketSession>> sL = (Map<String, Collection<WebSocketSession>>) sLs.toArray()[i];
			for(int j=0; j<sL.size(); j++) {
				Collection<WebSocketSession> s = (Collection<WebSocketSession>)sL.values().toArray()[j];
				for(int l=s.size()-1; 0<s.size(); l--) {
					if(s.toArray()[l]!=null) {
						try {
							((WebSocketSession)s.toArray()[l]).close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
	}

	public boolean scCloseCheck(String chatRoom, String chatName) {
		if(0<webSessions.size()) {
			for(int i=0; i<webSessions.size(); i++) {
				if(webSessions.containsKey(chatRoom)) {
					if(webSessions.get(chatRoom).containsKey(chatName)) {
						if(0!=webSessions.get(chatRoom).get(chatName).size()) {
							return false;
						}
					}
				}
			}
		}
		return true;
	}
    
}
