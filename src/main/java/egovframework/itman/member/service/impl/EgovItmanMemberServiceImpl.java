package egovframework.itman.member.service.impl;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import egovframework.itman.member.service.EgovItmanLoginVO;
import egovframework.itman.member.service.EgovItmanMemberService;
import egovframework.itman.member.service.EgovItmanMemberVO;

@Service("egovItmanMemberService")
public class EgovItmanMemberServiceImpl extends EgovAbstractServiceImpl implements EgovItmanMemberService {

	@Resource(name="egovItmanMemberDAO")
    private EgovItmanMemberDAO egovItmanMemberDAO;

	@Resource(name = "passwordEncoder")
	private BCryptPasswordEncoder passwordEncoder;

	/**
	 * 일반 로그인을 처리한다
	 * @param vo EgovItmanLoginVO
	 * @return EgovItmanLoginVO
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
    	} else {
			// 4. DB에서 조회한 암호화된 비밀번호와 사용자가 입력한 비밀번호를 비교
			if (!passwordEncoder.matches(vo.getMemPw(), loginVO.getMemPw())) {
				loginVO = null;
			}
		}
    	
        return loginVO;
    }

	@Override
	public String insertMember(EgovItmanMemberVO vo) throws Exception {
		// 1. 비밀번호를 암호화한다.
		String enPassword = passwordEncoder.encode(vo.getMemPw());
		vo.setMemPw(enPassword);

		// 2. 회원정보를 등록한다.
		return egovItmanMemberDAO.insertMember(vo);
	}

}