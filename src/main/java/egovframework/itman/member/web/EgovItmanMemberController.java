package egovframework.itman.member.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.itman.email.service.EgovItmanEmailService;
import egovframework.itman.member.service.EgovItmanMemberService;
import egovframework.itman.member.service.EgovItmanLoginVO;
import egovframework.itman.member.service.EgovItmanMemberVO;

@Controller
public class EgovItmanMemberController {

	@Resource(name = "egovItmanMemberService")
	private EgovItmanMemberService egovItmanMemberService;

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
	
	/**
	 * 회원가입을 처리한다.
	 * @param memberVO - 회원가입 정보
	 * @param redirectAttributes - RedirectAttributes
	 * @return String
	 * @throws Exception
	 */
	@PostMapping("/html/user/joinProc.do")
	public String joinProc(EgovItmanMemberVO memberVO, RedirectAttributes redirectAttributes) throws Exception {
		
		egovItmanMemberService.insertMember(memberVO);
		
		redirectAttributes.addFlashAttribute("message", "회원가입이 완료되었습니다. 로그인해주세요.");
		
		return "redirect:/html/user/login.do";
	}


	@RequestMapping("html/user/login.do")
	public String login() {
		
		return "itman/html/user/login";
	}

	/**
	 * 로그인 처리
	 * @param loginVO - 로그인 정보
	 * @param request - HttpServletRequest
	 * @param model - Model
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping("/html/user/loginProc.do")
	public String loginProc(EgovItmanLoginVO loginVO, HttpServletRequest request, RedirectAttributes redirectAttributes) throws Exception {
		
		// 1. 일반 로그인 처리
		EgovItmanLoginVO resultVO = egovItmanMemberService.actionLogin(loginVO);
		
		if (resultVO != null && resultVO.getMemIdx() != null && !resultVO.getMemIdx().equals("")) {
			request.getSession().setAttribute("loginVO", resultVO);
			
			return "redirect:/html.do"; // 로그인 성공 시 메인 페이지로 이동
		} else {
			redirectAttributes.addFlashAttribute("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
			
			return "redirect:/html/user/login.do"; // 로그인 실패 시 로그인 페이지로 리다이렉트
		}
	}
}
