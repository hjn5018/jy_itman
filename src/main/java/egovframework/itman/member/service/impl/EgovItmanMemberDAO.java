package egovframework.itman.member.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.itman.member.service.EgovItmanLoginVO;

@Repository("egovItmanMemberDAO")
public class EgovItmanMemberDAO extends EgovAbstractMapper {

	/**
	 * 일반 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public EgovItmanLoginVO actionLogin(EgovItmanLoginVO vo) throws Exception {
        return (EgovItmanLoginVO) selectOne("actionLogin", vo);
    }

}