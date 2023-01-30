package chat.server;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.Scanner;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketSession;

public class ChatClient {

	private Socket socket;
	private DataInputStream dis;
	private DataOutputStream dos;
	private String clientNickname;
	private String chatName;
	private String chatRoom;
	private SocketServer ss;
	private ChattingWebSocket cws;

	public void connect() throws IOException{
		socket = new Socket("localhost", 12005);
		dis = new DataInputStream(socket.getInputStream());
		dos = new DataOutputStream(socket.getOutputStream());
	}
	
	public void send(String jsonStr) throws IOException{
		dos.writeUTF(jsonStr);
		dos.flush();
	}
	
	public void unconnect() throws IOException{
		socket.close();
	}
	
	
	public void setSs(SocketServer ss) {
		this.ss = ss;
	}
	public void setCws(ChattingWebSocket cws) {
		this.cws = cws;
	}
	public String getClientNickname() {
		return clientNickname;
	}
	public void setClientNickname(String clientNickname) {
		this.clientNickname = clientNickname;
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
	public Socket getSocket() {
		return socket;
	}
	
}
