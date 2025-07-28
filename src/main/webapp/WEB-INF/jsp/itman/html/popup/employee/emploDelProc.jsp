<!-- <?php -->
<!-- 	 include "../../../_inc/dbconn.php"; -->

<!-- 	 /** -->
<!-- 	  * 세션 체크 -->
<!-- 	  */ -->
<!-- 	 include "../../../_inc/loginTest.php"; -->
<!-- 	 login_check(); -->
 
<!-- 	 $EMP_IDX= $_GET['emp_idx']; -->

<!--     $delete_SQL = "UPDATE ITM_EMPLOYE -->
<!--                    SET DEL_YN = 'Y' -->
<!--                    WHERE EMP_IDX = '{$EMP_IDX}'"; -->
<!--     $delete_query = mysqli_query($dbconn, $delete_SQL); -->
    
<!--     if(mysqli_affected_rows($dbconn)==0){ -->
<!--         echo "<script>alert('직원 삭제에 실패하였습니다.');history.go(-1);</script>"; -->
<!--     }else{ -->
<!--         echo "<script>alert('직원을 성공적으로 삭제하였습니다.');opener.parent.location.href='/html/ingroup/emploList.php';window.close();</script>"; -->
<!--     } -->
<!-- ?> -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<script>
		alert('직원이 삭제되었습니다!');
		opener.location.href = "<c:url value='/html/ingroup/emploList.do' />";
		window.close();
	</script>
</body>
</html>