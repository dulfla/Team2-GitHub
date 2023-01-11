package spring.vo;

import java.util.Date;

public class AuthInfo { 
	
	private String email;
	private String name;
	private String nickname;
	private String type;
	private int birth;
	private String address;
	private String phone;
	private Date regdate;
	
	public AuthInfo() {}

	
	
	


	public AuthInfo(String email, String name, String nickname, String type, int birth, String address, String phone) {
		
		this.email = email;
		this.name = name;
		this.nickname = nickname;
		this.type = type;
		this.birth = birth;
		this.address = address;
		this.phone = phone;
	}



	
	public AuthInfo setAddress(String address) {
		this.address = address;
		return this;
	}
	public AuthInfo setBirth(int birth) {
		this.birth = birth;
		return this;
	}
	public AuthInfo setPhone(String phone) {
		this.phone = phone;
		return this;
	}

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
	
	
	public int getBirth() {
		return birth;
	}

	public String getAddress() {
		return address;
	}

	public String getPhone() {
		return phone;
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
