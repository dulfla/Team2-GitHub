package chat.server;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.Scanner;

import org.json.JSONObject;

public class ChatClient {

	Socket socket;
	DataInputStream dis;
	DataOutputStream dos;
	String chatName;
	String chatRoom;
	
	public static void main(String[] args) {
		try {
			ChatClient chatClient = new ChatClient();
			chatClient.connect();
			
			Scanner scanner = new Scanner(System.in);
			System.out.print("대화명 입력 : ");
			chatClient.chatName = scanner.nextLine(); // 해당 회원 닉네임으로 자동 입력
			System.out.print("대화방 입력 : ");
			chatClient.chatRoom = scanner.nextLine(); // 채팅방 아이디 입력
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("command", "incoming");
			jsonObject.put("data", chatClient.chatName);
			jsonObject.put("room", chatClient.chatRoom);
			String json = jsonObject.toString();
			chatClient.send(json);
			
			chatClient.recive();
			
			System.out.println("-------------------------");
			System.out.println("보낼 메세지를 입력하고 enter");
			System.out.println("채팅을 종료하려면 q를 입력하고 enter");
			System.out.println("-------------------------");
			
			while(true) {
				String message = scanner.nextLine();
				if(message.toLowerCase().equals("q")) {
					break;
				}else {
					jsonObject = new JSONObject();
					jsonObject.put("command", "message");
					jsonObject.put("data", message);
					jsonObject.put("room", chatClient.chatRoom);
					json = jsonObject.toString();
					chatClient.send(json);
				}
			}
			scanner.close();
			chatClient.unconnect();
		}catch (IOException e) {
			System.out.println("[클라이언트] 서버 연결 안 됨");
		}
	}
	
	// 서버 연결
	public void connect() throws IOException{
		socket = new Socket("localhost", 12005);
		dis = new DataInputStream(socket.getInputStream());
		dos = new DataOutputStream(socket.getOutputStream());
		System.out.println("[클라이언트] 서버에 연결됨");
	}
	
	// JSON 받기
	public void recive() {
		Thread thread = new Thread(() -> {
			try {
				while(true) {
					String json = dis.readUTF();
					JSONObject root = new JSONObject(json);
					String clientIp = root.getString("clientIp");
					String chatName = root.getString("chatName");
					String message = root.getString("message");
					System.out.println("<"+chatName+"@"+clientIp+"> "+message);
				}
			}catch (IOException e) {
				System.out.println("[클라이언트] 서버 연결이 끊김");
				System.exit(0);
			}
		});
		thread.start();
	}
	
	// JSON 보내기
	public void send(String json) throws IOException{
		dos.writeUTF(json);
		dos.flush();
	}
	
	// 서버 연결 종료
	public void unconnect() throws IOException{
		socket.close();
	}
	
}
