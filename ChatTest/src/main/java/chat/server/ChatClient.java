package chat.server;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.Scanner;

import org.json.JSONObject;
import org.springframework.stereotype.Component;

public class ChatClient {

	private Socket socket;
	private DataInputStream dis;
	private DataOutputStream dos;
	private String chatName;
	private String chatRoom;
	
	public void connect() throws IOException{
		socket = new Socket("localhost", 12005);
		dis = new DataInputStream(socket.getInputStream());
		dos = new DataOutputStream(socket.getOutputStream());
		// System.out.println("[클라이언트] 서버에 연결됨");
	}
	
	public void recive() {
		Thread thread = new Thread(() -> {
			try {
				while(true) {
					String json = dis.readUTF();
					JSONObject root = new JSONObject(json);
					String clientIp = root.getString("clientIp");
					String chatName = root.getString("chatName");
					String message = root.getString("message");
					// System.out.println("<"+chatName+"@"+clientIp+"> "+message);
					// 이 부분을 web front에 전달하는 걸로 바꿔야 함
				}
			}catch (IOException e) {
				// System.out.println("[클라이언트] 서버 연결이 끊김");
				System.exit(0);
			}
		});
		thread.start();
	}
	
	public void send(String jsonStr) throws IOException{
		dos.writeUTF(jsonStr);
		dos.flush();
	}
	
	public void unconnect() throws IOException{
		System.out.println(chatRoom+", "+chatName+"연결 해제");
		socket.close();
	}
	

	public String getChatName() {
		return chatName;
	}
	public void setChatName(String chatName) {
		this.chatName = chatName;
	}
	public String getChatRoom() {
		return chatRoom;
	}
	public void setChatRoom(String chatRoom) {
		this.chatRoom = chatRoom;
	}
	
}
