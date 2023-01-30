package chat.server;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.Collection;
import java.util.Date;

import org.json.JSONObject;

import spring.service.chat.ChatService;
import spring.vo.chat.ChatMessageVo;

public class SocketClient {

	private SocketServer chatServer;
	private Socket socket;
	private DataInputStream dis;
	private DataOutputStream dos;
	private String clientIp;
	private String chatName;
	private String chatRoom;
	private String clientNickname;
	
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
	
	public void receive(){
		chatServer.getThreadPool().execute(() -> {
			try {
				while(true) {
					String receiveJson = dis.readUTF();
					
					JSONObject jsonObject = new JSONObject(receiveJson);
					String command = jsonObject.getString("command");
					
					InetSocketAddress isa = (InetSocketAddress) socket.getRemoteSocketAddress();
					this.clientIp = isa.getHostName();
					
					ChatMessageVo message = new ChatMessageVo();
					
					switch(command) {
					case "incoming":
						this.clientNickname = jsonObject.getString("name");
						this.chatName = jsonObject.getString("who");
						this.chatRoom = jsonObject.getString("room");
						
						chatServer.addSocketClient(this);
						
						message.setMessType("READ");
						message.setSend_date(new Date());
						message.setC_id(chatRoom);
						message.setSender(chatName);
						try {
							cs.readMsg(message);
							chatServer.sendToAll(this, message);
						} catch (Exception e) {
							e.printStackTrace();
						}
						break;
					case "message":
						long idx = jsonObject.getLong("msgIdx");
						message = cs.selectSendedMessage(idx);
						try {
							chatServer.sendToAll(this, message);
						} catch (Exception e) {
							e.printStackTrace();
						}
						break;
					case "read":
						message = new ChatMessageVo();
						message.setMessType("READ");
						message.setIdx(jsonObject.getInt("msgIdx"));
						message.setC_id(chatRoom);
						message.setSender(chatName);
						try {
							cs.readMsg(message);
							chatServer.sendToAll(this, message);
						} catch (Exception e) {
							e.printStackTrace();
						}
						break;
					}
				}
			}catch (IOException e) {
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
	public String getClientNickname() {
		return clientNickname;
	}
	public void setClientNickname(String clientNickname) {
		this.clientNickname = clientNickname;
	}
	public void setCs(ChatService cs) {
		this.cs = cs;
	}
	public ChatService getCs() {
		return cs;
	}
	
}
