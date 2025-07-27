package egovframework.itman.employee.service;

import java.util.List;

public interface EgovItmanEmployeeService {

	List<EgovItmanEmployeeVO> selectEmployeeList();

	void insertEmployee(EgovItmanEmployeeVO vo);

	EgovItmanEmployeeVO selectEmployee(EgovItmanEmployeeVO vo);

	void deleteEmployee(EgovItmanEmployeeVO vo);

	void updateEmployeeField(EgovItmanEmployeeVO vo, String field);
}
