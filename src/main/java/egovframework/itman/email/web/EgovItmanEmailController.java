package egovframework.itman.email.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.itman.email.service.EgovItmanEmailService;
import egovframework.itman.email.service.EgovItmanEmailVO;
import egovframework.itman.member.service.EgovItmanMemberVO;

@Controller
public class EgovItmanEmailController {

	@Resource(name = "egovItmanEmailService")
	private EgovItmanEmailService egovItmanEmailService;

	@RequestMapping("/user/sendEmailProc.do")
	public String sendEmailProc(
			EgovItmanMemberVO vo,
			@RequestParam("mode") String mode,
			@RequestParam("userphone1") String userphone1, 
			@RequestParam("userphone2") String userphone2,
			@RequestParam("userphone3") String userphone3,
			Model model, 
			RedirectAttributes redirectAttributes) {

		if (vo.getMemTel() == null || vo.getMemTel().isEmpty()) {
			vo.setMemTel(userphone1 + userphone2 + userphone3);
		}

		if (egovItmanEmailService.verifyEmail(vo.getMemMail())) {
			model.addAttribute("errorMessage", "중복된 이메일입니다.");
			return "itman/html/user/join02";
		}

		EgovItmanEmailVO egovItmanEmailVO = egovItmanEmailService.sendEmailCode(vo, mode);

		redirectAttributes.addFlashAttribute("userVO", vo);
		redirectAttributes.addFlashAttribute("egovItmanEmailVO", egovItmanEmailVO);
		redirectAttributes.addFlashAttribute("mode", mode);

		return "redirect:/html/user/certPass.do";
	}

	@RequestMapping("html/user/certPass.do")
	public String certPass(Model model) {

		EgovItmanEmailVO emailVO = (EgovItmanEmailVO) model.getAttribute("egovItmanEmailVO");
		EgovItmanEmailVO regDate = egovItmanEmailService.selectRegDate(emailVO);

		model.addAttribute("regDate", regDate);

		return "itman/html/user/certPass";
	}

}
