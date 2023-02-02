package spring.service.member;
import java.io.UnsupportedEncodingException;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import spring.dao.member.MemberDao;
import spring.exception.MemberNotFoundException;
import spring.vo.member.Member;

@Service
public class MailSendService {
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@Autowired
	private MemberDao dao;
	
	public static int key;
	
	
	public int getKey(int size) {
		Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111;
		System.out.println("인증번호 : " + checkNum);
		return checkNum;
	}
	
	public int sendAuthMail(String mail)  throws MessagingException{
		
		Member member = dao.selectByEmail(mail);
		if(member==null) {
			throw new MemberNotFoundException();
		}
		
        int authKey = getKey(6);
        key = authKey;
        System.out.println(authKey);
        MimeMessage mailMessage = mailSender.createMimeMessage();
        String mailContent = "인증번호:   "+authKey ;     //보낼 메시지 
            mailMessage.setSubject("그린마켓 인증메일", "utf-8"); 
            mailMessage.setText(mailContent, "utf-8", "html");  
            mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(mail));
            mailSender.send(mailMessage);
        
          return authKey;
    }
	
	
}
