<?php
    	include "../../../_inc/dbconn.php";

        /** 세션 체크 */
        include "../../../_inc/loginTest.php";
        login_check();

        $MOD_IDX = $_SESSION['userIDX'];
        $EMP_IDX = $_POST['emp_idx'];
        $EMP_NUM = $_POST['emp_num'];

        /** 로직 */
        $itm_price_SQL = "UPDATE ITM_EMPLOYE
                            SET  EMP_NUM = '{$EMP_NUM}'
                            WHERE EMP_IDX = '{$EMP_IDX}'";
        echo($itm_price_SQL);
        $itm_price_query = mysqli_query($dbconn, $itm_price_SQL);

        if (!$itm_price_query) {
            echo"<script>alert(".mysqli_error($dbconn).");</script>";
        }

        //ITM_SYS_LOG 작성 필요

        echo "<script>alert('직원 사번이 성공적으로 변경되었습니다!');opener.parent.location.reload();window.close();</script>";
?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<script>
		alert('직원 사번이 성공적으로 변경되었습니다!');
		opener.parent.location.reload();
		window.close();
	</script>
</body>
</html>