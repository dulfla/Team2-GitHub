package spring.vo;

import java.util.Date;

public class ProductVO {

	// productDetail tbl
	private String p_id;
	private String p_name;
	private String description;
	private String category;
	private Date regdate;
	private int views;
	private int price;
	
	private String productId;
	private String email;
	
	
	
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "ProductVO [p_id=" + p_id + ", p_name=" + p_name + ", description=" + description + ", category="
				+ category + ", regdate=" + regdate + ", views=" + views + ", price=" + price + ", productId="
				+ productId + ", email=" + email + "]";
	}
	


		
		
}
