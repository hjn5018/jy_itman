<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<?php
	 include "../../_inc/dbconn.php";

	 /**
	  * 세션 체크
	  */
	 include "../../_inc/loginTest.php";
	 login_check();
 
	 $EMP_IDX= $_GET['emp_idx'];
?>
<!doctype html>
<html lang="ko">
<head>
<%@ include file="../../_inc/title.jsp"%>
</head>
<body>

	<div id="popup">
		<div class="pop_tit">
			<p class="title">직원을 삭제하시겠습니까?</p>
		</div>
		<div class="pop_cont">
			<form method="post" id="form" action="./emploDelProc.do">
				<input type="hidden" name="empIdx" value="${vo.empIdx }">
				<ul class="contEdit">
					<li>
						<p class="tit">비고</p>
						<p class="cont">
							<input name="sl_no" type="text" />
						</p>
					</li>
				</ul>
				<p class="pop_btn">
					<a href="javascript:window.close();" class="del">취소</a><a
						href="javascript:formSubmit();" class="comp">삭제</a>
				</p>
			</form>
		</div>
	</div>
	<script>
		function formSubmit() {
			$("#form").submit();
		}
	</script>
</body>
</html>
