package spring.vo.search;

import java.util.Date;

public class Search {
	
	private long idx;
	private String keyword;
	private String email;
	private Date regdate;
	
	public Search() {}
	
	public Search(long idx, String keyword, String email) {
		this.idx = idx;
		this.keyword = keyword;
		this.email = email;
	}

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
	public long getIdx() {
		return idx;
	}
	public void setIdx(long idx) {
		this.idx = idx;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	
}
