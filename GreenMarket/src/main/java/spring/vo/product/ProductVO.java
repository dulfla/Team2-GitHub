package spring.vo.product;

import java.util.Date;

import java.util.List;

public class ProductVO {

	private String p_id;
	private String p_name;
	private String description;
	private String category;
	private Date regdate;
	private int views;
	private int price;
	private String trade;
	private String nickname;
	private String lat;
	private String lng;
	
	private List<ProductImageVO> imageList;
	
	private String productId;
	private String email;	
	
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	
	
	public List<ProductImageVO> getImageList() {
		return imageList;
	}
	public void setImageList(List<ProductImageVO> imageList) {
		this.imageList = imageList;
	}
	public String getTrade() {
		return trade;
	}
	public void setTrade(String trade) {
		this.trade = trade;
	}
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
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	@Override
	public String toString() {
		return "ProductVO [p_id=" + p_id + ", p_name=" + p_name + ", description=" + description + ", category="
				+ category + ", regdate=" + regdate + ", views=" + views + ", price=" + price + ", trade=" + trade
				+ ", nickname=" + nickname + ", lat=" + lat + ", lng=" + lng + ", productId=" + productId + ", email="
				+ email + ", imageList=" + imageList + "]";
	}
	
	
			
}
