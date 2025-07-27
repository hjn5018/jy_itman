<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<?php
    include "../../_inc/dbconn.php";

    /**
     * 세션 체크
     */
    include "../../_inc/loginTest.php";
    login_check();

    $EMP_IDX= $_GET['emp_idx'];
    $sql="SELECT * FROM ITM_EMPLOYE WHERE EMP_IDX = $EMP_IDX";
    
    $query = mysqli_query($dbconn, $sql);
    $result = mysqli_fetch_array($query);
   
    
?>
<!doctype html>
<html lang="ko">
 <head>
 <%@ include file="../../_inc/title.jsp" %>
 </head>
<body>

	<div id="popup">
		<div class="pop_tit">
			<p class="title">
			<c:choose>
                <c:when test="${field eq 'empNum'}">직원 사번</c:when>
                <c:when test="${field eq 'empName'}">이름</c:when>
                <c:when test="${field eq 'empMail'}">이메일</c:when>
                <c:when test="${field eq 'empTel'}">휴대폰</c:when>
                <c:when test="${field eq 'divIdx'}">부서</c:when>
                <c:when test="${field eq 'posIdx'}">직위</c:when>
                <c:when test="${field eq 'empStIdx'}">상태</c:when>
            </c:choose> 변경</p>
		</div>
		<div class="pop_cont">
            <form method="post" id="form" action="./emploFieldEditProc.do">
                <input type="hidden" name="empIdx" value="${vo.empIdx }">
                <input type="hidden" name="field" value="${field }">
			<ul class="contEdit">
    <li>
        <p class="tit">
            <c:choose>
                <c:when test="${field eq 'empNum'}">직원 사번</c:when>
                <c:when test="${field eq 'empName'}">이름</c:when>
                <c:when test="${field eq 'empMail'}">이메일</c:when>
                <c:when test="${field eq 'empTel'}">휴대폰</c:when>
                <c:when test="${field eq 'divIdx'}">부서</c:when>
                <c:when test="${field eq 'posIdx'}">직위</c:when>
                <c:when test="${field eq 'empStIdx'}">상태</c:when>
            </c:choose>
        </p>
        <p class="cont">
            <c:choose>
                <c:when test="${field eq 'empNum'}">
                    <input type="text" name="empNum" value="${vo.empNum}" placeholder="변경할 사번을 입력하세요.">
                </c:when>
                <c:when test="${field eq 'empName'}">
                    <input type="text" name="empName" value="${vo.empName}" placeholder="변경할 이름을 입력하세요.">
                </c:when>
                <c:when test="${field eq 'empMail'}">
                    <input type="text" name="empMail" value="${vo.empMail}" placeholder="변경할 이메일을 입력하세요.">
                </c:when>
                <c:when test="${field eq 'empTel'}">
                    <input type="text" name="empTel" value="${vo.empTel}" placeholder="변경할 휴대폰 번호를 입력하세요.">
                </c:when>
                <c:when test="${field eq 'divIdx'}">
                    <input type="text" name="divIdx" value="${vo.divIdx}" placeholder="변경할 부서를 입력하세요.">
                </c:when>
                <c:when test="${field eq 'posIdx'}">
                    <input type="text" name="posIdx" value="${vo.posIdx}" placeholder="변경할 직위를 입력하세요.">
                </c:when>
                <c:when test="${field eq 'empStIdx'}">
                    <input type="text" name="empStIdx" value="${vo.empStIdx}" placeholder="변경할 상태를 입력하세요.">
                </c:when>
                <c:otherwise>
                    <input type="text" name="${field}" value="" placeholder="값을 입력하세요.">
                </c:otherwise>
            </c:choose>
        </p>
    </li>
</ul>
            </form>
			<p class="pop_btn"><a href="javascript:window.close();" class="del">취소</a><a href="javascript:formSubmit();" class="comp">수정</a></p>
		</div>
	</div>
<script>
    function formSubmit(){
        $("#form").submit();
    }
</script>
</body>
</html>
