package chat.server;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.Socket;

import org.json.JSONObject;

import spring.service.ChatService;
import spring.vo.ChatMessageVo;

public class SocketClient {

	private SocketServer chatServer;
	private Socket socket;
	private DataInputStream dis;
	private DataOutputStream dos;
	private String clientIp;
	private String chatName;
	private String chatRoom;
	
	private ChatService cs;

	public SocketClient(SocketServer chatServer, Socket socket) {
		try {
			this.chatServer = chatServer;
			this.socket = socket;
			this.dis = new DataInputStream(socket.getInputStream());
			this.dos = new DataOutputStream(socket.getOutputStream());
			InetSocketAddress isa = (InetSocketAddress) socket.getRemoteSocketAddress();
			this.clientIp = isa.getHostName();
			receive();
		}catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void receive() {
		chatServer.getThreadPool().execute(() -> {
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
						chatServer.addSocketClient(this);
						chatServer.sendToAll(this, message);
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

	public void send(String jsonStr) {
		try {
			dos.writeUTF(jsonStr);
			dos.flush();
		}catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void close() {
		try {
			socket.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}


	public String getClientIp() {
		return clientIp;
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
	public void setCs(ChatService cs) {
		this.cs = cs;
	}
	public ChatService getCs() {
		return cs;
	}
	
}
