<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
 <head>
 <%@ include file="../_inc/title.jsp"%>
 </head>

<%
String nextPage = "";
String mode = (String) request.getAttribute("mode");

if ("회원가입".equals(mode)) {
	nextPage = "join_proc.do";
} else if ("비밀번호찾기".equals(mode)) {
	nextPage = "comPass.do";
}
request.setAttribute("nextPage", nextPage);
%>

<body>
<p>현재 모드: ${mode}</p>
<p>현재 nextPage: ${nextPage}</p>
<p>ecNum: ${egovItmanEmailVO.ecNum}</p>
<p>regDate: ${regDate.regDate}</p>
<p>memName: ${userVO.memName}</p>
<p>memMail: ${userVO.memMail}</p>
<p>memPw: ${userVO.memPw}</p>
<p>memTel: ${userVO.memTel}</p>

	<div id="contents">
		<div class="user_box join">
			<p class="tit"><a href="../index.jsp"><img src="${pageContext.request.contextPath }/itman_html/_img/itman_logo.png" alt="아이티맨" /></a></p>
			<p class="find_tit">
				이메일로<br/>
				전송된 인증 번호를<br/>
				입력해주세요.
			</p>
            <form action="${nextPage}" name="frm" id="frm" method="post">
			<ul class="mem">
				<li>
					<div><input type="text" id="verCode" name="verCode" placeholder="인증번호를 여기에 입력해 주세요."></div>
				</li>
			</ul>

			<input type="hidden" id="ecNum" name="ecNum" value="${egovItmanEmailVO.ecNum}">
            <input type="hidden" id="regDate" name="regDate" value="${regDate.regDate }">
            <input type="hidden" name="memName" value="${userVO.memName }">
            <input type="hidden" name="memMail" value="${userVO.memMail }">
            <input type="hidden" name="memPw" value="${userVO.memPw }">
            <input type="hidden" name="memTel" value="${userVO.memTel }">

			<p class="user_btn"><a href="javascript:fn_submit();">다음</a></p>
            </form>
		</div>
	</div>

	<%@ include file="../_inc/footer.jsp"%>
</body>

<script language="javascript">

function fn_submit(){

    var now = new Date();
    if(now < $("#verCode").val().trim()){
		alert("인증시간이 초과했습니다. 다시 입력해주세요");
		history.back();
		return false;
	}

    if($("#verCode").val().trim() == ""){
		alert("인증번호를 입력해주세요.");
		$("#verCode").focus();
		return false;
	}

    if($("#verCode").val().trim() != $("#ecNum").val().trim()) {
        alert('인증번호를 다시 확인해주세요.');
        $("#verCode").focus();
        return false;
    }

    frm.submit();
}

</script>
</html>
