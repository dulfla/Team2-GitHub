package spring.vo.product;

public class PagingInfoVO {

	private String email;
	private int s = 1;
	private int p = 1;
	private int pis = 10;
	private int oip = 15;
	private String c;
	private String v;
	private String keyword;
	
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getS() {
		return s;
	}
	public void setS(String s) {
		if(s=="" || s==null) {
			return;
		}else {
			this.s = Integer.parseInt(s);
		}
	}
	public int getP() {
		return p;
	}
	public void setP(String p) {
		if(p=="" || p==null) {
			return;
		}else {
			this.p = Integer.parseInt(p);
		}
	}
	public int getPis() {
		return pis;
	}
	public void setPis(String pis) {
		if(pis=="" || pis==null) {
			return;
		}else {
			this.pis = Integer.parseInt(pis);
		}
	}
	public int getOip() {
		return oip;
	}
	public void setOip(String oip) {
		if(oip=="" || oip==null) {
			return;
		}else {
			this.oip = Integer.parseInt(oip);
		}
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
