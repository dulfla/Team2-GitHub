package spring.vo.member;

public class FindPasswordCommand {

	private String email;
	private String newPassword;
	private String newPassword2;
	private int authKey;
	
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
	public String getNewPassword() {
		return newPassword;
	}
	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	public String getNewPassword2() {
		return newPassword2;
	}
	public void setNewPassword2(String newPassword2) {
		this.newPassword2 = newPassword2;
	}
	
	
	
}
