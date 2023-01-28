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

import spring.service.chat.ChatService;
import spring.vo.chat.ChatMessageVo;

public class SocketServer {
	
	private int max = 500;
	private ServerSocket serverSocket;
	private ExecutorService threadPool;
	private static Map<String, Map<String, SocketClient>> chatRoom = Collections.synchronizedMap(new HashMap<>());
	private static Map<String, Map<String, Collection<WebSocketSession>>> webSessions = Collections.synchronizedMap(new HashMap<>());
	
	@Autowired
	private ChatService cs;
	
	@Autowired
	private ChattingWebSocket cws;
	
	public void start() throws IOException {
		serverSocket = new ServerSocket(12005);
		threadPool = Executors.newFixedThreadPool(max);
		System.out.println("[server] 시작");
		Thread thread = new Thread(() -> {
			try {
				while(true) {
					Socket socket = serverSocket.accept();
					SocketClient sc = new SocketClient(this, socket);
					sc.setCs(cs);
				}
			} catch (IOException e) {
				System.out.println("[server] 종료");
				// e.printStackTrace();
			}
		});
		thread.start();
	}
	
	public void addSocketClient(SocketClient socketClient) {
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
	
	public void removeSocketClient(SocketClient sc) {
		String key = sc.getChatName()+"@"+sc.getClientIp();
		if(sc!=null) {
			if(0<webSessions.size()) {
				for(int i=0; i<webSessions.size(); i++) {
					if(webSessions.containsKey(sc.getChatRoom())) {
						if(webSessions.get(sc.getChatRoom()).containsKey(key)) {
							if(0!=webSessions.get(sc.getChatRoom()).get(key).size()) {
								return;
							}
						}
					}
				}
			}
			chatRoom.get(sc.getChatRoom()).remove(key, sc);
			sc.close();
		}
	}
	
	public void sendToAll(SocketClient sender, ChatMessageVo message) throws Exception {
		JSONObject root = new JSONObject();
		root.put("clientNickname", sender.getClientNickname());
		root.put("chatName", sender.getChatName());
		root.put("room", sender.getChatRoom());
		root.put("message", message.getMessage());
		root.put("messType", message.getMessType());
		String jsonStr = root.toString();
		
		Map<String, SocketClient> roomClient = chatRoom.get(root.getString("room"));
		Collection<SocketClient> socketClientList = roomClient.values();
		for(SocketClient sc : socketClientList) {
			sc.send(jsonStr);
		}
		Collection<Collection<WebSocketSession>> sessionList = webSessions.get(sender.getChatRoom()).values();
		for(Collection<WebSocketSession> sL : sessionList) {
			for(WebSocketSession s : sL) {
				cws.sendMessage(s, root);
			}
		}
	}
	
	public void stop() {
		try {
			Collection<Map<String, SocketClient>> roomClient = chatRoom.values();
			if(0<roomClient.size()) {
				for(Map<String, SocketClient> rc : roomClient) {
					Collection<SocketClient> socketClientList = rc.values();
					if(0<socketClientList.size()) {
						for(SocketClient sc : socketClientList) {
							if(sc!=null) {
								sc.close();
							}
						}
					}
				}
			}
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
			serverSocket.close();
			threadPool.shutdownNow();
		}catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void saveWebSession(Map<String, String> info, WebSocketSession session) {
		String key = info.get("email"); // +"@"+session.getId()
		if(0<webSessions.size()) {
			if(webSessions.containsKey(info.get("c_id"))) {
				if(webSessions.get(info.get("c_id")).containsKey(key)) {
					if(! webSessions.get(info.get("c_id")).get(key).contains(session)) {
						webSessions.get(info.get("c_id")).get(key).add(session);
					}
					return;
				}
				List<WebSocketSession> wscL = new ArrayList<>();
				wscL.add(session);
				webSessions.get(info.get("c_id")).put(key, wscL);
				return;
			}
		}
		List<WebSocketSession> wscL = new ArrayList<>();
		wscL.add(session);
		Map<String, Collection<WebSocketSession>> map = new HashMap<>();
		map.put(key, wscL);
		webSessions.put(info.get("c_id"), map);
	}

	public void removeWebSesseion(Map<String, String> info, WebSocketSession session) {
		String key = info.get("email"); // +"@"+session.getId()
		webSessions.get(info.get("c_id")).get(key).remove(session);
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
