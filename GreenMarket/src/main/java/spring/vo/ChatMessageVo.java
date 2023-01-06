package spring.vo;

import java.util.Date;

public class ChatMessageVo {
	private long idx;
	private String c_id;
	private String Message;
	private char read;
	private Date send_date;
	
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
		return Message;
	}
	public void setMessage(String message) {
		Message = message;
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
