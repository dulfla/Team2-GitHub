package spring.vo;

import java.util.Date;

public class AuthInfo { 
	
	private String email;
	private String name;
	private String nickname;
	private String type;
	private Date regdate;
	
	public AuthInfo() {}

	

	public AuthInfo setType(String type) {
		this.type = type;
		return this;
	}

	public AuthInfo setEmail(String email) {
		this.email = email;
		return this;
	}
	
	public AuthInfo setName(String name) {
		this.name = name;
		return this;
	}
	
	public AuthInfo setNickname(String nickname) {
		this.nickname = nickname;
		return this;
	}

	public Date getRegdate() {
		return regdate;
	}

	public String getEmail() {
		return email;
	}

	public String getName() {
		return name;
	}

	public String getNickname() {
		return nickname;
	}
	
	public String getType() {
		return type;
	}
	
	
}
