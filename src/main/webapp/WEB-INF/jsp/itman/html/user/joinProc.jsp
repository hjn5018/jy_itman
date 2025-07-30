<!doctype html>
<html lang="ko">
    <body>
        <form action="join03.php" name="frm" id="frm" method="post">
            <input type="hidden" name="username" value=<?=$_POST['username'];?>>
        </form>
    </body>
    <script language="javascript">
    document.frm.submit();
    </script>
</html>

<?php

include("../_inc/dbconn.php");
include('./password.jsp');

$hashed = password_hash($_POST["userpw"], PASSWORD_DEFAULT);


$result = mysqli_query($dbconn,$sql);


if($result) {
    echo "<script>location.href='join03.php'</script>";
}else{
    echo "<script> alert('가입에 실패했습니다. 잠시 후 다시 시도해주세요.'); history.back();</script>";
}

?>