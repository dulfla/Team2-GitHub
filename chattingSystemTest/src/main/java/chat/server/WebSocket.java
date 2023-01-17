package chat.server;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class WebSocket extends TextWebSocketHandler {
	

	private static Map<String, List<WebSocketSession>> sessionList = Collections.synchronizedMap(new HashMap<>());
	
	private SocketServer ss;
	public void setSs(SocketServer ss) {
		this.ss = ss;
	}

	// 클라이언트가 서버로 연결 처리
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String key = "";
		if(0<sessionList.size()) {
			if(sessionList.containsKey(key)) {
				sessionList.get(key).add(session);
				return;
			}
		}
		List<WebSocketSession> clientSessions = new ArrayList<>();
		clientSessions.add(session);
		sessionList.put(key, clientSessions);
		
		for(int i = 0; i < sessionList.get(key).size(); i++) {
			WebSocketSession s = sessionList.get(key).get(i);
			s.sendMessage(new TextMessage(session.getId() + "님이 입장 했습니다."));
		}
	}

	// 클라이언트가 서버로 메세지 전송 처리
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String key = "";
		for(int i = 0; i < sessionList.get(key).size(); i++) {
			WebSocketSession s = sessionList.get(key).get(i);
			s.sendMessage(new TextMessage(session.getId() + " : " + message.getPayload()));
		}
	}

	// 클라이언트가 연결을 끊음 처리
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String key = "";
		sessionList.get(key).remove(session);

		for(int i = 0; i < sessionList.get(key).size(); i++) {
			WebSocketSession s = sessionList.get(key).get(i);
			s.sendMessage(new TextMessage(session.getId() + "님이 퇴장 했습니다."));
		}
	}
	
}