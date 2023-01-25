package spring.vo.product;

public class Product1VO {

	private int idx;
	private String email;
	private String p_id;
	private String productId;
	
	
	
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
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	@Override
	public String toString() {
		return "Product1VO [idx=" + idx + ", email=" + email + ", p_id=" + p_id + "]";
	}
	
	
	

	
	
}
