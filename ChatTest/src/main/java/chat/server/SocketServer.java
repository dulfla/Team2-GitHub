package chat.server;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
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
	private static Map<String, Map<String, SocketClient>> chatRoom = Collections.synchronizedMap(new HashMap<>());
	private static Map<String, Map<String, WebSocketSession>> webSessions = Collections.synchronizedMap(new HashMap<>());
	
	@Autowired
	private ChatService cs;
	
	@Autowired
	private ChattingWebSocket cws;
	
	public void start() throws IOException {
		serverSocket = new ServerSocket(12005);
		
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
		String key = socketClient.getChatName()+"@"+socketClient.getClientIp();
		chatRoom.get(socketClient.getChatRoom()).remove(key, socketClient);
	}
	
	public void sendToAll(SocketClient sender, ChatMessageVo message) throws Exception {
		JSONObject root = new JSONObject();
		root.put("clientIp", sender.getClientIp());
		root.put("chatName", sender.getChatName());
		root.put("room", sender.getChatRoom());
		root.put("message", message.getMessage());
		root.put("messType", message.getMessType());
		String jsonStr = root.toString();
		
		Map<String, SocketClient> roomClient = chatRoom.get(root.getString("room"));
		Collection<SocketClient> socketClients = roomClient.values();
		for(SocketClient sc : socketClients) {
			if(sc!=sender) {
				sc.send(jsonStr);
			}
		}
		Collection<WebSocketSession> sessions = webSessions.get(sender.getChatRoom()).values();
		for(WebSocketSession s : sessions) {
			if(s!=webSessions.get(sender.getChatRoom()).get(sender.getChatName())) {
				cws.sendMessage(s, root);
			}
		}
	}
	
	public void stop() {
		try {
			serverSocket.close();
			threadPool.shutdownNow();
			chatRoom.values().stream().forEach(crm -> crm.values().stream().forEach(sc -> sc.close()));
		}catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void saveWebSession(Map<String, String> info, WebSocketSession session) {
		String key = info.get("email"); // +"@"+session.getId()
		if(0<webSessions.size()) {
			if(webSessions.containsKey(info.get("c_id"))) {
				webSessions.get(info.get("c_id")).put(key, session);
				return;
			}
		}
		Map<String, WebSocketSession> map = new HashMap<>();
		map.put(key, session);
		webSessions.put(info.get("c_id"), map);
	}

	public void removeWebSesseion(Map<String, String> info, WebSocketSession session) {
		String key = info.get("email"); // +"@"+session.getId()
		webSessions.get(info.get("c_id")).remove(key, session);
	}

	public ExecutorService getThreadPool() {
		return threadPool;
	}
	public Map<String, Map<String, WebSocketSession>> getWebSessions(){
		return webSessions;
	}
	
}
