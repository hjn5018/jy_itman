<!doctype html>
<html lang="ko">
 <head>
  <? include "_inc/title.php"; ?>
  <link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
 </head>
<body>
	<header class="h_index">
		<div class="h_left">
			<h1 class="logo"><a href="#"><img src="_img/itman_logo.png" alt="아이티맨" /></a></h1>
		</div>
		
        <!-- 우측 상단바 -->
        <?php
        include "_inc/dbconn.php";
        session_start();
        $isLogin = FALSE;

        if( !$_SESSION["useremail"] || !$_SESSION["username"] ) {?>
            <!-- 로그인전 -->
            <p class="h_right_index">
                <a href="./user/login.php">로그인</a>
                <a href="./user/join01.php" class="join">회원가입</a>
            </p>
        <?php
        } else {
            $sql = "SELECT GRO_IDX FROM ITM_GROUP WHERE GRO_OWNER_IDX={$_SESSION['userIDX']} AND DEL_YN = 'N'";
            $result = mysqli_query($dbconn, $sql);
            $haveGroup = mysqli_num_rows($result);
        ?>
            <!-- 로그인후 -->
            <div class="h_right">
                <a href="#" class="hr_btn"><span></span><span></span><span></span></a>
                <p class="hr_box">
                    <span><?php echo $_SESSION["username"]; ?>님</span>
                    <a href="./user/mypage.php" class="btn mypage">마이페이지</a>
                    <a href="./user/logout_proc.php" class="btn logout">로그아웃</a>
                    <a href="group.php" class="btn group">전체그룹메인</a>
                       
                </p>
            </div>
        <?php
            $isLogin = TRUE;
        }
        ?>

	</header>
	<div id="contents" class="index">
		<p class="logo"><img src="_img/itman_logo.png" alt="아이티맨" /></p>
		<p class="index_tt">개인과 기업이 할 수 있는 자산관리 시스템<span>자산 데이터와 코드 관리 전반에 활용할 수 있는 <br>제품과 솔루션</span></p>
		<ul class="index_service">
			<li><a href="group.php"><span>Service 01</span>자산 관리</li></a>
			<li><a href="group.php"><span>Service 02</span>직원 관리</li></a>
			<li><a href="group.php"><span>Service 03</span>부서 관리</li></a>
			<li><a href="group.php"><span>Service 04</span>직위 관리</li></a>
			<li><a href="group.php"><span>Service 05</span>구매처 관리</li></a>
			<li><a href="group.php"><span>Service 06</span>위치 관리</li></a>
		</ul>
		<p class="index_st">무료로 이용해보기</p>
		<p class="index_btn">
        <?php 
        if( !$_SESSION["useremail"] || !$_SESSION["username"] ) {?>
            <!-- 로그인전 -->
            <a href="group.php">그룹 생성하기</a>
        <?php
        } else {
        ?>
            <!-- 로그인후 -->
            <a onclick="window.open('popup/addGroup.php', '그룹생성팝업', 'width=500, height=350')" href="#" class="addBox">그룹 생성하기</a>
        <?php
        }
        ?>
			<a href="javascript:unready();">유로로 더 많은 기능 사용하기</a>
		</p>
	</div>

	<? include "_inc/footer.php"; ?>
 </body>
 <script>
    function unready(){
        alert("아직 준비중입니다.");
    }

 </script>
</html>
