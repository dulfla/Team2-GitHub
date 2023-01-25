package spring.vo.member;

public class MailAuthCommand {
	private String email;
	private int authKey;
	private String isAuth;
	private String password;
	
	
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	
	public int getAuthKey() {
		return authKey;
	}
	public void setAuthKey(int authKey) {
		this.authKey = authKey;
	}
	
	public String getIsAuth() {
		return isAuth;
	}
	public void setIsAuth(String isAuth) {
		this.isAuth = isAuth;
	}
	
}
