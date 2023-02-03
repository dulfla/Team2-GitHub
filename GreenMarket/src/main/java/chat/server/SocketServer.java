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
	
	@Autowired
	private ChatService cs;
	
	@Autowired
	private ChattingWebSocket cws;
	
	public void start() throws IOException {
		serverSocket = new ServerSocket(12005);
		threadPool = Executors.newFixedThreadPool(max);
		// System.out.println("[server] 시작");
		Thread thread = new Thread(() -> {
			try {
				while(true) {
					Socket socket = serverSocket.accept();
					SocketClient sc = new SocketClient(this, socket);
					sc.setCs(cs);
				}
			} catch (IOException e) {
				// System.out.println("[server] 종료");
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
			if(cws.scCloseCheck(sc.getChatRoom(), sc.getChatName())) {
				return;
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
		root.put("msgIdx", message.getIdx());
		String jsonStr = root.toString();
		
		Map<String, SocketClient> roomClient = chatRoom.get(root.getString("room"));
		Collection<SocketClient> socketClientList = roomClient.values();
		for(SocketClient sc : socketClientList) {
			sc.send(jsonStr);
			cws.sendMessageThisSession(sc.getChatName(), root);
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
			cws.closeAll();

			serverSocket.close();
			threadPool.shutdownNow();
		}catch (IOException e) {
			e.printStackTrace();
		}
	}

	public ExecutorService getThreadPool() {
		return threadPool;
	}
	
}
