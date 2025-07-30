package egovframework.itman.member.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.itman.member.service.EgovItmanMemberService;
import egovframework.itman.member.service.EgovItmanLoginVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("egovItmanMemberService")
public class EgovItmanMemberServiceImpl implements EgovItmanMemberService {

	@Resource(name="egovItmanMemberDAO")
    private EgovItmanMemberDAO egovItmanMemberDAO;

	/**
	 * 일반 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    @Override
	public EgovItmanLoginVO actionLogin(EgovItmanLoginVO vo) throws Exception {
    	
    	// 1. 입력한 비밀번호를 암호화 (필요시)
    	// String enPassword = EgovFileScrty.encryptPassword(vo.getMemPw(), vo.getMemMail());
    	// vo.setMemPw(enPassword);
    	
    	// 2. 아이디와 암호화된 비밀번호로 회원 정보 조회
    	EgovItmanLoginVO loginVO = egovItmanMemberDAO.actionLogin(vo);
    	
    	// 3. 조회된 회원 정보가 없으면 null 반환
    	if (loginVO == null || loginVO.getMemIdx() == null || loginVO.getMemIdx().equals("")) {
    		loginVO = null;
    	}
    	
        return loginVO;
    }

}