package egovframework.itman.employee.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.itman.employee.service.EgovItmanEmployeeVO;

@Repository("egovItmanEmployeeDAO")
public class EgovItmanEmployeeDAO extends EgovAbstractMapper{

	public List<EgovItmanEmployeeVO> selectEmployeeList(EgovItmanEmployeeVO vo) {
		return selectList("selectEmployeeList", vo);
	}

	public void insertEmployee(EgovItmanEmployeeVO vo) {
		insert("insertEmployee", vo);
	}

	public EgovItmanEmployeeVO selectEmployee(EgovItmanEmployeeVO vo) {
		return selectOne("selectEmployee", vo);
	}

	public void deleteEmployee(EgovItmanEmployeeVO vo) {
		update("deleteEmployee", vo);
	}

	public void updateEmployee(EgovItmanEmployeeVO vo, String field) {
		Map<String, Object> param = new HashMap<>();
		param.put("field", field);
		param.put("vo", vo);
		update("updateEmployee", param);
	}
}
