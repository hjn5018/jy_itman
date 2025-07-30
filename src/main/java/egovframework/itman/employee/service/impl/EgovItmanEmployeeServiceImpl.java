package egovframework.itman.employee.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itman.employee.service.EgovItmanEmployeeService;
import egovframework.itman.employee.service.EgovItmanEmployeeVO;

@Service("egovItmanEmployeeService")
public class EgovItmanEmployeeServiceImpl implements EgovItmanEmployeeService{

	@Resource(name="egovItmanEmployeeDAO")
	private EgovItmanEmployeeDAO egovItmanEmployeeDAO;
	
	@Override
	public List<EgovItmanEmployeeVO> selectEmployeeList(EgovItmanEmployeeVO vo) {
		return egovItmanEmployeeDAO.selectEmployeeList(vo);
	}
	
	@Override
	public void insertEmployee(EgovItmanEmployeeVO vo) {
		egovItmanEmployeeDAO.insertEmployee(vo);
	}

	@Override
	public EgovItmanEmployeeVO selectEmployee(EgovItmanEmployeeVO vo) {
		return egovItmanEmployeeDAO.selectEmployee(vo);
	}

	@Override
	public void deleteEmployee(EgovItmanEmployeeVO vo) {
		egovItmanEmployeeDAO.deleteEmployee(vo);
	}

	@Override
	public void updateEmployeeField(EgovItmanEmployeeVO vo, String field) {
		egovItmanEmployeeDAO.updateEmployee(vo, field);
		
	}
}
