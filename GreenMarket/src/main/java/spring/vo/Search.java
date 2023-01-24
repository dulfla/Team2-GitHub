package spring.vo;

import java.util.Date;

public class Search {
	
	private long idx;
	private String keyward;
	private Date regdate;
	
	
	public long getIdx() {
		return idx;
	}
	public void setIdx(long idx) {
		this.idx = idx;
	}
	public String getKeyward() {
		return keyward;
	}
	public void setKeyward(String keyward) {
		this.keyward = keyward;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	
}
