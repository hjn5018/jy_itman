package egovframework.itman.email.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.itman.email.service.EgovItmanEmailVO;

@Repository("egovItmanEmailDAO")
public class EgovItmanEmailDAO extends EgovAbstractMapper{
	
	public int countEmail (String memMail) {
		
		return selectOne("countEmail", memMail);
	}

	public void insertEmailCode(EgovItmanEmailVO evo) {
		
		insert("insertEmailCode", evo);
	}

	public EgovItmanEmailVO selectRegDate(EgovItmanEmailVO emailVO) {
		
		return selectOne("selectRegDate", emailVO);
	}
	
}
