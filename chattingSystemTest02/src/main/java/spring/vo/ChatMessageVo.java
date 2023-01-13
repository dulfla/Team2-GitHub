package spring.vo;

import java.util.Date;

public class ChatMessageVo {

	private String message;
	private String messType;
	private String sender;
	private char read;
	private Date send_date;
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getMessType() {
		return messType;
	}
	public void setMessType(String messType) {
		this.messType = messType;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public char getRead() {
		return read;
	}
	public void setRead(char read) {
		this.read = read;
	}
	public Date getSend_date() {
		return send_date;
	}
	public void setSend_date(Date send_date) {
		this.send_date = send_date;
	}
	
}
