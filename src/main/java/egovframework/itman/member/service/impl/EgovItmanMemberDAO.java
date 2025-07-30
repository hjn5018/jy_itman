package egovframework.itman.member.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.itman.member.service.LoginVO;

@Repository("egovItmanMemberDAO")
public class EgovItmanMemberDAO extends EgovAbstractMapper {

	/**
	 * 일반 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public LoginVO actionLogin(LoginVO vo) throws Exception {
        return (LoginVO) selectOne("actionLogin", vo);
    }

}