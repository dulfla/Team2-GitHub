package spring.vo;

public class AuthInfo { 
	
	private String email;
	private String name;
	private String nickname;
	
	public AuthInfo() {}

	public AuthInfo(String email, String name, String nickname) {
		this.email = email;
		this.name = name;
		this.nickname = nickname;
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

	public String getEmail() {
		return email;
	}

	public String getName() {
		return name;
	}

	public String getNickname() {
		return nickname;
	}
	
	
	
	
}
