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
import java.util.Scanner;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

import spring.business.ChatService;
import spring.dao.ChatDao;
import spring.vo.ChatMessageVo;

public class SocketServer {
	
	private int max = 20;
	private ServerSocket serverSocket;
	private ExecutorService threadPool = Executors.newFixedThreadPool(max);
	private static Map<String, Map<String, SocketClient>> chatRoom = Collections.synchronizedMap(new HashMap<>());
	
	@Autowired
	private ChatService cs;
	
	public void start() throws IOException {
		serverSocket = new ServerSocket(12005);
		System.out.println("[서버] 시작됨");
		
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
	
	public void addSocketClient(SocketClient socketClient) {System.out.println("연결 : "+socketClient);
		String key = socketClient.getChatName()+"@"+socketClient.getClientIp();
		if(0<chatRoom.size()) {
			if(chatRoom.containsKey(socketClient.getChatName())) {
				chatRoom.get(socketClient.getChatName()).put(key, socketClient);
				return;
			}
		}
		Map<String, SocketClient> map = new HashMap<>();
		map.put(key, socketClient);
		chatRoom.put(socketClient.getChatName(), map);
	}
	
	public void removeSocketClient(SocketClient socketClient) {System.out.println("제거 : "+socketClient);
		String key = socketClient.getChatName()+"@"+socketClient.getClientIp();
		chatRoom.get(socketClient.getChatName()).remove(key, socketClient);
	}
	
	public void sendToAll(SocketClient sender, ChatMessageVo message) {System.out.println("전송 : "+sender);
		JSONObject root = new JSONObject();
		root.put("clientIp", sender.getClientIp());
		root.put("chatName", sender.getChatName());
		root.put("room", sender.getChatName());
		root.put("message", message.getMessage());
		root.put("messType", message.getMessType());
		String jsonStr = root.toString();
		
		System.out.println("<"+sender.getChatName()+"님 발신> "+message.getMessage());
		
		Map<String, SocketClient> roomClient = chatRoom.get(root.getString("room"));
		Collection<SocketClient> socketClients = roomClient.values();
		for(SocketClient sc : socketClients) {
			if(sc!=sender) {
				sc.send(jsonStr);
			}
		}
	}
	
	public void stop() {
		try {
			serverSocket.close();
			threadPool.shutdownNow();
			chatRoom.values().stream().forEach(crm -> crm.values().stream().forEach(sc -> sc.close()));
			System.out.println("[서버] 종료됨");
		}catch (IOException e) {
			e.printStackTrace();
		}
	}

	public ExecutorService getThreadPool() {
		return threadPool;
	}
	
}
