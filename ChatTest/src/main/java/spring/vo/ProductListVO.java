package spring.vo;

import java.util.Date;

public class ProductListVO {
				// VO 데이터를 담는 그릇
	private String p_id;
	private String p_name;	
	private String category;
	private Date regdate;
	private long views;
	private long price;
	private String email;
	private String f_proxy_name;
	private String description;
	

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getF_proxy_name() {
		return f_proxy_name;
	}

	public void setF_proxy_name(String f_proxy_name) {
		this.f_proxy_name = f_proxy_name;
	}

	public String getP_id() {
		return p_id;
	}

	public void setP_id(String p_id) {
		this.p_id = p_id;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public long getViews() {
		return views;
	}

	public void setViews(long views) {
		this.views = views;
	}

	public long getPrice() {
		return price;
	}

	public void setPrice(long price) {
		this.price = price;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
}