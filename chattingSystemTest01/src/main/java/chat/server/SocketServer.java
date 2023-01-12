package chat.server;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.json.JSONObject;

public class SocketServer {

	int max = 5;
	// 클라이언트의 연결 요청을 수락할 서버소켓
	ServerSocket serverSocket;
	// 몇개의 클라이언트가 동시에 채팅할 수 있도록 만들지 지정
	ExecutorService threadPool = Executors.newFixedThreadPool(max);
	// 통신용 소캣클라이언트를 관리하는 동기화된 map컬랙션
	Map<String, SocketClient> chatRoom = Collections.synchronizedMap(new HashMap<>());
	
	public static void main(String[] args) {
		try {
			SocketServer chatServer = new SocketServer();
			chatServer.start();
			
			System.out.println("-------------------------");
			System.out.println("서버를 종료하려면 q를 입력하고 enter");
			System.out.println("-------------------------");
			
			Scanner scanner = new Scanner(System.in);
			while(true) {
				String key = scanner.nextLine();
				if(key.equals("q")) {
					break;
				}
			}
			scanner.close();
			chatServer.stop();
		}catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 서버 시작
	public void start() throws IOException {
		serverSocket = new ServerSocket(12005);
		System.out.println("[서버] 시작됨");
		
		Thread thread = new Thread(() -> {
			try {
				while(true) {
					Socket socket = serverSocket.accept();
					SocketClient sc = new SocketClient(this, socket);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		});
		thread.start();
	}
	
	// 클라이언트 연결 시 SocketClient 생성 및 추가
	public void addSocketClient(SocketClient socketClient) {
		String key = socketClient.chatName+"@"+socketClient.clientIp;
		chatRoom.put(key, socketClient);
		System.out.println("입장 : "+key);
		System.out.println("현재 채팅자 수 : "+chatRoom.size()+"/"+max);
	}
	
	// 클라이언트 연결 종료시 SocketClient 제거
	public void removeSocketClient(SocketClient socketClient) {
		String key = socketClient.chatName+"@"+socketClient.clientIp;
		chatRoom.remove(key, socketClient);
		System.out.println("나감 : "+key);
		System.out.println("현재 채팅자 수 : "+chatRoom.size()+"/"+max);
	}
	
	// 모든 클라이언트에게 메세지 보냄
	public void sendToAll(SocketClient sender, String message) {
		JSONObject root = new JSONObject();
		root.put("clientIp", sender.clientIp);
		root.put("chatName", sender.chatName);
		root.put("room", sender.chatRoom);
		root.put("message", message);
		String json = root.toString();
		
		Collection<SocketClient> socketClients = chatRoom.values();
		for(SocketClient sc : socketClients) {
			if(sc.chatRoom.equals(root.getString("room")) && sc!=sender) {
				sc.send(json);
			}
		}
	}
	
	// 서버 종료
	public void stop() {
		try {
			serverSocket.close();
			threadPool.shutdownNow();
			chatRoom.values().stream().forEach(sc -> sc.close());
			System.out.println("[서버] 종료됨");
		}catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
