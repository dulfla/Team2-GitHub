package spring.vo;

public class LoginCommand { // 커맨드 객체 : 클라이언트의 데이터를 묶어서 서버(controller)로 보내주는 역할
	private String email;
	private String password;
	
	
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
	
	
}
