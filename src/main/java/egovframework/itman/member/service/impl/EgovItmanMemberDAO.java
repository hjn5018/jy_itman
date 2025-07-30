package egovframework.itman.member.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.itman.member.service.EgovItmanLoginVO;
import egovframework.itman.member.service.EgovItmanMemberVO;

@Repository("egovItmanMemberDAO")
public class EgovItmanMemberDAO extends EgovAbstractMapper {

	/**
	 * 일반 로그인을 처리한다
	 * @param vo EgovItmanLoginVO
	 * @return EgovItmanLoginVO
	 * @exception Exception
	 */
    public EgovItmanLoginVO actionLogin(EgovItmanLoginVO vo) throws Exception {
        return (EgovItmanLoginVO) selectOne("memberDAO.actionLogin", vo);
    }

	/**
	 * 회원정보를 등록한다.
	 * @param vo EgovItmanMemberVO
	 * @return String
	 * @exception Exception
	 */
	public String insertMember(EgovItmanMemberVO vo) {
		return String.valueOf((int) insert("memberDAO.insertMember", vo));
	}

}