package egovframework.itman.member.service;

import java.io.Serializable;

public class LoginVO implements Serializable {

	private static final long serialVersionUID = -8274004534207618049L;

	private String memIdx;
	private String memMail;
	private String memPw;
	private String memName;

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getMemIdx() {
		return memIdx;
	}

	public void setMemIdx(String memIdx) {
		this.memIdx = memIdx;
	}

	public String getMemPw() {
		return memPw;
	}

	public void setMemPw(String memPw) {
		this.memPw = memPw;
	}

	public String getMemMail() {
		return memMail;
	}

	public void setMemMail(String memMail) {
		this.memMail = memMail;
	}
}
