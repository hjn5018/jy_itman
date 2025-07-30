<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html lang="ko">
 <head>
 <%@ include file="../_inc/title.jsp" %>
 </head>
<body>
	<div id="contents">
		<div class="user_box">
			<p class="tit"><a href="<c:url value='/html.do'/>"><img src="<c:url value='/itman_html/_img/itman_logo.png' />" alt="아이티맨" /></a></p>

<%--             <form action="<c:out value='/html/user/loginProc.do' />" name="frm" id="frm" method="post"> --%>
		<form action="${pageContext.request.contextPath }/html/user/loginProc.do" name="frm" id="frm" method="post">
			<ul class="mem">
				<li>
					<p>이메일</p>
					<div><input type="text" id="memMail" name="memMail"></div>
				</li>
				<li>
					<p>비밀번호</p>
					<div><input type="password" id="memPw" name="memPw"></div>
				</li>
			</ul>
			<p class="user_btn"><a href="javascript:fn_submit();">로그인</a></p>
</form>
			<p class="mam_btn"><a href="join01.do">회원가입</a><a href="findEmail.php">이메일 찾기</a><a href="findPass.php">비밀번호 찾기</a></p>
		</div>
	</div>
	<%@ include file="../_inc/footer.jsp" %>
</body>
<script language="javascript">
function fn_submit(){
    frm.submit();
}
</script>
<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>
</html>
