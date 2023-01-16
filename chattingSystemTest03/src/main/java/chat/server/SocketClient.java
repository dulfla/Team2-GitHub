package chat.server;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.Socket;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import chat.service.ChatService;
import spring.dao.ChatDao;
import spring.vo.ChatMessageVo;

public class SocketClient {

	private SocketServer chatServer;
	private Socket socket;
	DataInputStream dis;
	DataOutputStream dos;
	String clientIp; // 회원 이메일
	String chatName; // 회원 이름
	String chatRoom; // 채팅방 id
	
	@Autowired
	ChatService cs;
	
	public SocketClient(){}
	
	// 생성자
//	public SocketClient(SocketServer chatServer, Socket socket) {
//		try {
//			this.chatServer = chatServer;
//			this.socket = socket;
//			this.dis = new DataInputStream(socket.getInputStream());
//			this.dos = new DataOutputStream(socket.getOutputStream());
//			InetSocketAddress isa = (InetSocketAddress) socket.getRemoteSocketAddress();
//			this.clientIp = isa.getHostName();
//			receive();
//		}catch (IOException e) {
//			e.printStackTrace();
//		}
//	}
	
	
	public SocketServer getChatServer() {
		return chatServer;
	}
	public void setChatServer(SocketServer chatServer) {
		this.chatServer = chatServer;
	}
	public Socket getSocket() {
		return socket;
	}
	public void setSocket(Socket socket) {
		try {
			this.socket = socket;
			this.dis = new DataInputStream(socket.getInputStream());
			this.dos = new DataOutputStream(socket.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	
	// JSON 받기
	public void receive() {
		chatServer.threadPool.execute(() -> {
			try {
				while(true) {
					String receiveJson = dis.readUTF();
					
					JSONObject jsonObject = new JSONObject(receiveJson);
					String command = jsonObject.getString("command");
					
					InetSocketAddress isa = (InetSocketAddress) socket.getRemoteSocketAddress();
					this.clientIp = isa.getHostName();
					
					switch(command) {
					case "incoming":
						this.chatName = jsonObject.getString("who");
						this.chatRoom = jsonObject.getString("room");
						
						ChatMessageVo message = new ChatMessageVo();
						message.setMessage("들어오셨습니다.");
						message.setMessType("TEXT");
						chatServer.sendToAll(this, message);
						chatServer.addSocketClient(this);
						break;
					case "message":
						long idx = jsonObject.getLong("msgIdx");
						ChatMessageVo msg = cs.selectSendedMessage(idx);
						chatServer.sendToAll(this, msg);
					}
				}
			}catch (IOException e) {
				ChatMessageVo message = new ChatMessageVo();
				message.setMessage("나가셨습니다.");
				message.setMessType("TEXT");
				chatServer.sendToAll(this, message);
				chatServer.removeSocketClient(this);
			}
		});
	}

	// JSON 보내기
	public void send(String json) {
		try {
			dos.writeUTF(json);
			dos.flush();
		}catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 연결 종료
	public void close() {
		try {
			socket.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
