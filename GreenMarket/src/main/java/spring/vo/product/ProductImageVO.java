package spring.vo.product;

public class ProductImageVO {

	private String p_id;
	private String uploadPath;
	private String uuid;
	private String fileName;
	private String productId;
	
	public String getP_id() {
		return p_id;
	}
	public void setP_id(String p_id) {
		this.p_id = p_id;
	}
	public String getUploadPath() {
		return uploadPath;
	}
	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	@Override
	public String toString() {
		return "ProductImageVO [p_id=" + p_id + ", uploadPath=" + uploadPath + ", uuid=" + uuid + ", fileName="
				+ fileName + ", productId=" + productId + "]";
	}
	
}
