package spring.vo;

import java.util.Date;

public class ChatMessageVo {

	private long idx;
	private String c_id;
	private String message;
	private String messType;
	private String sender;
	private String nickname;
	private char read;
	private Date send_date;
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public long getIdx() {
		return idx;
	}
	public void setIdx(long idx) {
		this.idx = idx;
	}
	public String getC_id() {
		return c_id;
	}
	public void setC_id(String c_id) {
		this.c_id = c_id;
	}
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
