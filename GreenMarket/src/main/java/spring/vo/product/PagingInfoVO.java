package spring.vo.product;

public class PagingInfoVO {

	private String email;
	private int s = 1;
	private int p = 1;
	private int pis = 10;
	private int oip = 15;
	private String c;
	private String v;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getS() {
		return s;
	}
	public void setS(int s) {
		this.s = s;
	}
	public int getP() {
		return p;
	}
	public void setP(int p) {
		this.p = p;
	}
	public int getPis() {
		return pis;
	}
	public void setPis(int pis) {
		this.pis = pis;
	}
	public int getOip() {
		return oip;
	}
	public void setOip(int oip) {
		this.oip = oip;
	}
	public String getC() {
		return c;
	}
	public void setC(String c) {
		this.c = c;
	}
	public String getV() {
		return v;
	}
	public void setV(String v) {
		this.v = v;
	}

}
