package spring.controller.chat;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import chat.server.SocketServer;
import spring.vo.member.AuthInfo;

@Controller
public class ChatServerController {
	
	@Autowired
	private SocketServer ss;
	
	@RequestMapping("Server")
	public String server(HttpServletRequest request, HttpSession session, RedirectAttributes reda) {
		String referer = request.getHeader("Referer");
		AuthInfo who = (AuthInfo)session.getAttribute("authInfo");
		String errorMsg = null;
		if(who!=null) {
			if(who.getType().equalsIgnoreCase("M")) {
				return "chat/serverOnOff";
			}else { /* errorMsg = "관리자만 접속할 수 있는 페이지 입니다."; */ }
		}else { /* errorMsg = "로그인하셔야  접속할 수 있는 페이지 입니다."; */ }
		
		// reda.addFlashAttribute("errMsg", errorMsg);
		return "redirect:"+(referer!=null?referer:"index");
	}
	
	@GetMapping(value = {"ServerOpen", "ServerClose"})
	public String locationErr(HttpServletRequest request, RedirectAttributes reda) {
		String referer = request.getHeader("Referer");
		// String errorMsg = "접속할 수 없는 주소 입니다.";
		// reda.addFlashAttribute("errMsg", errorMsg);
	    return "redirect:"+(referer!=null?referer:"index");
	}
	
	@ResponseBody
	@PostMapping("ServerOpen")
	public void serverOpen(HttpServletRequest req) throws IOException {
		ss.start();
		ServletContext app = req.getServletContext();
		app.setAttribute("serverOption", "On");
	}

	@ResponseBody
	@PostMapping("ServerClose")
	public void serverClose(HttpServletRequest req) throws IOException {
		ss.stop();
		ServletContext app = req.getServletContext();
		app.setAttribute("serverOption", "Off");
	}
	
}
