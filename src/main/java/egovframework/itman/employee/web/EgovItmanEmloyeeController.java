package egovframework.itman.employee.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.itman.employee.service.EgovItmanEmployeeService;
import egovframework.itman.employee.service.EgovItmanEmployeeVO;

@Controller
public class EgovItmanEmloyeeController {

	@Resource(name = "egovItmanEmployeeService")
	private EgovItmanEmployeeService egovItmanEmployeeService;
	
	@RequestMapping("/html/ingroup/emploList.do")
	public String emploList(Model model) {
		
		List<EgovItmanEmployeeVO> employeeVOList = egovItmanEmployeeService.selectEmployeeList();
		model.addAttribute("employeeVOList", employeeVOList);
		
		return "itman/html/ingroup/emploList";
	}

	@RequestMapping("/html/ingroup/emploWrite.do")
	public String emploWrite(Model model) {
		
		return "itman/html/ingroup/emploWrite";
	}

	@RequestMapping("/html/ingroup/emploWriteProc.do")
	public String emploWriteProc(EgovItmanEmployeeVO vo, Model model) {

		egovItmanEmployeeService.insertEmployee(vo);
		
		return "redirect:/html/ingroup/emploList.do";
	}

	@RequestMapping("/html/ingroup/emploView.do")
	public String emploView(EgovItmanEmployeeVO vo, Model model) {

		EgovItmanEmployeeVO resultVO = egovItmanEmployeeService.selectEmployee(vo);
		model.addAttribute("vo", resultVO);
		
		return "itman/html/ingroup/emploView";
	}

	@RequestMapping("/html/popup/employee/emploFieldEdit.do")
	public String emploFieldEdit(@RequestParam String field, EgovItmanEmployeeVO vo, Model model) {

		model.addAttribute("vo", vo);
		model.addAttribute("field", field);
		
		return "itman/html/popup/employee/emploFieldEdit";
	}

	@RequestMapping("html/popup/employee/emploFieldEditProc.do")
	public String emploFieldEditProc(@RequestParam String field, EgovItmanEmployeeVO vo, Model model) {

		egovItmanEmployeeService.updateEmployeeField(vo, field);
		model.addAttribute("field", field);
		
		return "itman/html/popup/employee/emploFieldEditProc";
	}

	@RequestMapping("/html/popup/employee/emploDel.do")
	public String emploDel(EgovItmanEmployeeVO vo, Model model) {

		model.addAttribute("vo", vo);
		
		return "itman/html/popup/employee/emploDel";
	}

	@RequestMapping("/html/popup/employee/emploDelProc.do")
	public String emploDelProc(EgovItmanEmployeeVO vo) {

		egovItmanEmployeeService.deleteEmployee(vo);
		
		return "itman/html/popup/employee/emploDelProc";
	}
}
