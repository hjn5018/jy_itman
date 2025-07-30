package egovframework.itman.member.service;

public interface EgovItmanMemberService {

	/**
	 * 일반 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
	EgovItmanLoginVO actionLogin(EgovItmanLoginVO vo) throws Exception;

	/**
	 * 회원가입을 처리한다
	 * @param vo EgovItmanMemberVO
	 * @return String
	 * @exception Exception
	 */
	String insertMember(EgovItmanMemberVO vo) throws Exception;

}