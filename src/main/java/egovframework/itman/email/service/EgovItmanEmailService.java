package egovframework.itman.email.service;

import egovframework.itman.member.service.EgovItmanMemberVO;

public interface EgovItmanEmailService {

	boolean verifyEmail(String memMail);

	EgovItmanEmailVO sendEmailCode(EgovItmanMemberVO vo, String mode);

}
