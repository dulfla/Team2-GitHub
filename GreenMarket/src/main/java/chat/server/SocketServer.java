package chat.server;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.WebSocketSession;

import spring.service.ChatService;
import spring.vo.ChatMessageVo;

public class SocketServer {
	
	private int max = 100;
	private ServerSocket serverSocket;
	private ExecutorService threadPool = Executors.newFixedThreadPool(max);
//	private static Map<String, Map<String, Collection<SocketClient>>> chatRoom = Collections.synchronizedMap(new HashMap<>());
	private static Map<String, Map<String, SocketClient>> chatRoom = Collections.synchronizedMap(new HashMap<>());
	private static Map<String, Map<String, Collection<WebSocketSession>>> webSessions = Collections.synchronizedMap(new HashMap<>());
	
	@Autowired
	private ChatService cs;
	
	@Autowired
	private ChattingWebSocket cws;
	
	public void start() throws IOException {
		serverSocket = new ServerSocket(12005);
		System.out.println("[server] 시작");
		Thread thread = new Thread(() -> {
			try {
				while(true) {
					Socket socket = serverSocket.accept();
					SocketClient sc = new SocketClient(this, socket);
					sc.setCs(cs);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		});
		thread.start();
	}
	
	public void addSocketClient(SocketClient socketClient) {
//		String key = socketClient.getChatName()+"@"+socketClient.getClientIp();
//		if(0<chatRoom.size()) {
//			if(chatRoom.containsKey(socketClient.getChatRoom())) {
//				if(chatRoom.get(socketClient.getChatRoom()).containsKey(key)) {
//					chatRoom.get(socketClient.getChatRoom()).get(key).add(socketClient);
//					return;
//				}
//				List<SocketClient> scL = new ArrayList<>();
//				scL.add(socketClient);
//				chatRoom.get(socketClient.getChatRoom()).put(key, scL);
//				return;
//			}
//		}
//		List<SocketClient> scL = new ArrayList<>();
//		scL.add(socketClient);
//		Map<String, Collection<SocketClient>> map = new HashMap<>();
//		map.put(key, scL);
//		chatRoom.put(socketClient.getChatRoom(), map);
		String key = socketClient.getChatName()+"@"+socketClient.getClientIp();
		if(0<chatRoom.size()) {
			if(chatRoom.containsKey(socketClient.getChatRoom())) {
				chatRoom.get(socketClient.getChatRoom()).put(key, socketClient);
				return;
			}
		}
		Map<String, SocketClient> map = new HashMap<>();
		map.put(key, socketClient);
		chatRoom.put(socketClient.getChatRoom(), map);
	}
	
	public void removeSocketClient(SocketClient socketClient) {
//		String key = socketClient.getChatName()+"@"+socketClient.getClientIp();
//		chatRoom.get(socketClient.getChatRoom()).get(key).remove(socketClient);
//		if(chatRoom.get(socketClient.getChatRoom()).get(key).size()==0) {
//			chatRoom.get(socketClient.getChatRoom()).remove(key);
//		}
		String key = socketClient.getChatName()+"@"+socketClient.getClientIp();
		chatRoom.get(socketClient.getChatRoom()).remove(key, socketClient);
	}
	
	public void sendToAll(SocketClient sender, ChatMessageVo message) throws Exception {
		JSONObject root = new JSONObject();
		root.put("clientNickname", sender.getClientNickname());
		root.put("chatName", sender.getChatName());
		root.put("room", sender.getChatRoom());
		root.put("message", message.getMessage());
		root.put("messType", message.getMessType());
		String jsonStr = root.toString();
		
//		Map<String, Collection<SocketClient>> roomClient = chatRoom.get(root.getString("room"));
//		Collection<Collection<SocketClient>> socketClientList = roomClient.values();
//		for(Collection<SocketClient> scL : socketClientList) {
//			for(SocketClient sc : scL) {
//				sc.send(jsonStr);
//			}
//		}
		Map<String, SocketClient> roomClient = chatRoom.get(root.getString("room"));
		Collection<SocketClient> socketClientList = roomClient.values();
		for(SocketClient sc : socketClientList) {
			sc.send(jsonStr);
		}
		Collection<Collection<WebSocketSession>> sessionList = webSessions.get(sender.getChatRoom()).values();
		for(Collection<WebSocketSession> sL : sessionList) {
			for(WebSocketSession s : sL) { System.out.println(s.getId()+"에 메시지 전송");
				cws.sendMessage(s, root);
			}
		}
	}
	
	public void stop() {
		try {
			serverSocket.close();
			threadPool.shutdownNow();
//			chatRoom.values().stream().forEach(crm -> crm.values().stream().forEach(sc -> sc.forEach(c -> c.close())));
			chatRoom.values().stream().forEach(crm -> crm.values().stream().forEach(sc -> sc.close()));
			webSessions.values().stream().forEach(ws -> ws.values().stream().forEach(w -> w.forEach(s -> {
				try {
					s.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			})));
		}catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void saveWebSession(Map<String, String> info, WebSocketSession session) {// System.out.println("등록");
		String key = info.get("email"); // +"@"+session.getId()
		if(0<webSessions.size()) {
			if(webSessions.containsKey(info.get("c_id"))) {
				if(webSessions.get(info.get("c_id")).containsKey(key)) {
					if(! webSessions.get(info.get("c_id")).get(key).contains(session)) {
						webSessions.get(info.get("c_id")).get(key).add(session);
					}
//					System.out.println("[등록] 사용자 "+key+"에 종속된 web 소캣의 개수 : "+webSessions.get(info.get("c_id")).get(key).size());
					return;
				}
				List<WebSocketSession> wscL = new ArrayList<>();
				wscL.add(session);
				webSessions.get(info.get("c_id")).put(key, wscL);
//				System.out.println("[등록] 사용자 "+key+"에 종속된 web 소캣의 개수 : "+webSessions.get(info.get("c_id")).get(key).size());
				return;
			}
		}
		List<WebSocketSession> wscL = new ArrayList<>();
		wscL.add(session);
		Map<String, Collection<WebSocketSession>> map = new HashMap<>();
		map.put(key, wscL);
		webSessions.put(info.get("c_id"), map);
//		System.out.println("[등록] 사용자 "+key+"에 종속된 web 소캣의 개수 : "+webSessions.get(info.get("c_id")).get(key).size());
	}

	public void removeWebSesseion(Map<String, String> info, WebSocketSession session) {// System.out.println("제거");
		String key = info.get("email"); // +"@"+session.getId()
		webSessions.get(info.get("c_id")).get(key).remove(session);
//		System.out.println("[제거] 사용자 "+key+"에 종속된 web 소캣의 개수 : "+webSessions.get(info.get("c_id")).get(key).size());
		if(webSessions.get(info.get("c_id")).get(key).size()==0) {
			webSessions.get(info.get("c_id")).remove(key);
		}
	}

	public ExecutorService getThreadPool() {
		return threadPool;
	}
	public Map<String, Map<String, Collection<WebSocketSession>>> getWebSessions(){
		return webSessions;
	}
	
}
