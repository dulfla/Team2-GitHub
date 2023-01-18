package spring.vo;

import java.util.Date;

import spring.exception.IdPasswordNotMatchingException;

public class Member {
	private String email;
	private String password;
	private int birth;
	private String address;
	private String phone;
	private String name;
	private String nickname;
	private String type;
	private Date regdate;
	
	
	public Member() {} 
	
	public Member(String email, String password, int birth, String address, String phone, String name,
			String nickname) {
		
		this.email = email;
		this.password = password;
		this.birth = birth;
		this.address = address;
		this.phone = phone;
		this.name = name;
		this.nickname = nickname;
	}
	
	

	
	// 회원수정 객체
	public Member(String email, int birth, String address, String phone, String name, String nickname) {
		this.email = email;
		this.birth = birth;
		this.address = address;
		this.phone = phone;
		this.name = name;
		this.nickname = nickname;
	}
	
	// 비밀번호 변경객체
	public void changePassword(String oldPassword, String newPassword) {
		if(!this.password.equals(oldPassword)) {
			throw new IdPasswordNotMatchingException();
		}
		this.password = newPassword;
		
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
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	
}
