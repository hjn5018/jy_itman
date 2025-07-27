package egovframework.itman.email.service.impl;

import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.util.Random;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import egovframework.itman.email.service.EgovItmanEmailService;
import egovframework.itman.email.service.EgovItmanEmailVO;
import egovframework.itman.member.service.EgovItmanMemberVO;

@Service("egovItmanEmailService")
public class EgovItmanEmailServiceImpl implements EgovItmanEmailService {

	@Resource(name="egovItmanEmailDAO")
	private EgovItmanEmailDAO egovItmanEmailDAO;
	
	@Autowired
	private JavaMailSender mailSender;

	@Override
	public boolean verifyEmail(String memMail) {

		int count = egovItmanEmailDAO.countEmail(memMail);
		return count > 0;
	}
	
	@Override
	public EgovItmanEmailVO sendEmailCode(EgovItmanMemberVO vo, String mode) {
		
		String num = String.format("%04d", new Random().nextInt(10_000));
		
		EgovItmanEmailVO evo = new EgovItmanEmailVO();
		evo.setMemName(vo.getMemName());
		evo.setEmail(vo.getMemMail());
		evo.setEcNum(num);
		evo.setEcMode(mode);
		evo.setRegDate(LocalDateTime.now().toString());
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			
			helper.setTo(vo.getMemMail());
			helper.setSubject("ITMAN " + mode + " 인증번호");
			helper.setText("인증번호 : " + num); // HTML 사용 시 true
			helper.setFrom(new InternetAddress(System.getenv("SMTP_USERNAME"), "ITMANNN")); // 보내는 사람 이름 포함
			
			mailSender.send(message);
			
		} catch(MessagingException | UnsupportedEncodingException e) {
			
			e.printStackTrace();
			System.err.println("Exception message: " + e.getMessage());
		} catch(Exception e) {
			
			e.printStackTrace();
			System.err.println("Exception message: " + e.getMessage());
		}
		
		egovItmanEmailDAO.insertEmailCode(evo);
		return evo;
	}
}