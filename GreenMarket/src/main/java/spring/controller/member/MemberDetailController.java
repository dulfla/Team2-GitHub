package spring.controller.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import spring.dao.member.MemberDao;
import spring.exception.MemberNotFoundException;
import spring.vo.member.Member;

@Controller
public class MemberDetailController {
	
	@Autowired
	private MemberDao memberDao;
	
	
	
	@GetMapping("memberDetail{email}")
	public String memberDetail(String email, HttpSession session) {
		Member member = memberDao.selectByEmail(email);
		
		if(member == null) {
			throw new MemberNotFoundException();
		}
		session.setAttribute("member", member);
		return "member/memberDetail";
	}
	
	@GetMapping("changeMemberInfo")
	public String changeMemberInfo(String email) {
		return "edit/changeMemberInfo";
	}
	
	@GetMapping("changePassword")
	public String changePassword() {
		
		return "edit/changePassword";
	}
	
}
