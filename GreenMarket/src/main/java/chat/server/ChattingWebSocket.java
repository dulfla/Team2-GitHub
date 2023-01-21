package chat.server;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@RequestMapping("/server")
public class ChattingWebSocket extends TextWebSocketHandler{
    
    @Autowired
    private SocketServer ss;
    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception { System.out.println(session.getId()+", WebSocket 연결");
        Map<String, String> info = getURIInfos(session);
    	ss.saveWebSession(info, session);	
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception { System.out.println(session.getId()+", WebSocket 분리"); /* * 서버 종료, 새로고침시에만 작동 * */
    	Map<String, String> info = getURIInfos(session);
        ss.removeWebSesseion(info, session);
    }
    
    protected void sendMessage(WebSocketSession session, JSONObject root) throws Exception {
    	String msgPack = "chatName:"+root.getString("chatName")+","
    					+"room:"+root.getString("room")+","
    					+"message:"+root.getString("message")+","
    					+"messType:"+root.getString("messType")+","
    					+"nickName:"+root.getString("clientNickname");
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
    
}
