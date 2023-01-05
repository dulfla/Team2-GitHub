package spring.vo;

import java.util.Date;

public class Member {
	private String email;
	private String password;
	private int birth;
	private String address;
	private String phone;
	private String name;
	private String nickName;
	private String type;
	private Date regdate;
	
	
	public Member() {} 
	
	public Member(String email, String password, int birth, String address, String phone, String name,
			String nickName) {
		super();
		this.email = email;
		this.password = password;
		this.birth = birth;
		this.address = address;
		this.phone = phone;
		this.name = name;
		this.nickName = nickName;
	}


	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getBirth() {
		return birth;
	}
	public void setBirth(int birth) {
		this.birth = birth;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	
}
