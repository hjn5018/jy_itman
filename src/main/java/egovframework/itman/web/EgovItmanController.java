package egovframework.itman.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EgovItmanController {

	@RequestMapping("/html.do")
	public String mainPage() {
		return "itman/html/html";
	}
}
