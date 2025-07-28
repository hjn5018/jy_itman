package egovframework.itman.member.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.itman.email.service.EgovItmanEmailService;
import egovframework.itman.email.service.EgovItmanEmailVO;

@Controller
public class EgovItmanMemberController {

	@Resource(name = "egovItmanEmailService")
	private EgovItmanEmailService egovItmanEmailService;

	@RequestMapping("html/user/join01.do")
	public String signUp01() {

		return "itman/html/user/join01";
	}

	@RequestMapping("html/user/join02.do")
	public String signUp02() {

		return "itman/html/user/join02";
	}

	@PostMapping("/html/user/emailCheck.do")
	@ResponseBody
	public String idCheck(@RequestParam("email") String email) {
		if (email == null || email.trim().isEmpty())
			return "2"; // 입력 안 함
		if (!email.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"))
			return "2"; // 이메일 형식 오류

		boolean exists = egovItmanEmailService.verifyEmail(email);

		return exists ? "1" : "0"; // 1=중복, 0=사용 가능
	}
	
	@RequestMapping("/html/user/joinProc.do")
	public String joinProc() {
		
		return "itman/html/user/joinProc";
	}

}
