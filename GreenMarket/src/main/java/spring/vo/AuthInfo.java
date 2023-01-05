package spring.vo;

public class AuthInfo { 
	
	private Long id;
	private String email;
	private String name;
	
	public AuthInfo(Long id, String email, String name) {
		this.id = id;
		this.email = email;
		this.name = name;
	}
	
	public AuthInfo() {}
	
	public AuthInfo setId(Long id) {
		this.id = id;
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
	
	public Long getId() {
		return id;
	}
	public String getEmail() {
		return email;
	}
	public String getName() {
		return name;
	}
	
}
