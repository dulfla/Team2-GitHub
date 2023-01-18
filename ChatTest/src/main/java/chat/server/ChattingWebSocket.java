package chat.server;

import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@RequestMapping("/server")
public class ChattingWebSocket extends TextWebSocketHandler{
	//세션 리스트
    private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
    
    //클라이언트가 연결 되었을 때 실행
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // sessionList.add(session);
        
        Map<String, String> info = new HashMap<>();
        String[] sources = session.getUri().toString().split("\\?")[1].split("&");
        for(int i=0; i<sources.length; i++) {
        	String[] str = sources[i].split("=");
        	info.put(str[0], str[1]);
        }
    	System.out.println(info);
        System.out.printf("{%s} 연결됨 \n", session.getId());
        System.out.println(session);
    }
 
    //클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	System.out.printf("{%s}로 부터 {%s} 받음\n", session.getId(), message.getPayload());
        //모든 유저에게 메세지 출력
        for(WebSocketSession sess : sessionList){
            sess.sendMessage(new TextMessage(message.getPayload()));
            sess.sendMessage(new TextMessage("흐어어어"));
        }
    }
    //클라이언트 연결을 끊었을 때 실행
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessionList.remove(session);
        System.out.printf("{%s} 연결 끊김.", session.getId());
    }
}
