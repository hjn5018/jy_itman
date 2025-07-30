<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="_inc/title.jsp"%>
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css"
	rel="stylesheet">
</head>
<body>
	<header class="h_index">
		<div class="h_left">
			<h1 class="logo">
				<a href="#"><img src="itman_html/_img/itman_logo.png" alt="아이티맨" /></a>
			</h1>
		</div>
		<p class="h_right_index">
			<a href="./user/login.do">로그인</a> <a href="./html/user/join01.do"
				class="join">회원가입</a>
		</p>


	</header>

	<div id="contents" class="index">
		<p class="logo">
			<img src="itman_html/_img/itman_logo.png" alt="아이티맨" />
		</p>
		<p class="index_tt">
			개인과 기업이 할 수 있는 자산관리 시스템<span>자산 데이터와 코드 관리 전반에 활용할 수 있는 <br>제품과
				솔루션
			</span>
		</p>
		<ul class="index_service">
			<li><a href="group.do"><span>Service 01</span>자산 관리</li></a>
			<li><a href="group.do"><span>Service 02</span>직원 관리</li></a>
			<li><a href="group.do"><span>Service 03</span>부서 관리</li></a>
			<li><a href="group.do"><span>Service 04</span>직위 관리</li></a>
			<li><a href="group.do"><span>Service 05</span>구매처 관리</li></a>
			<li><a href="group.do"><span>Service 06</span>위치 관리</li></a>
		</ul>
		<p class="index_st">무료로 이용해보기</p>
		<p class="index_btn">
		<a href="group.do">그룹 생성하기</a>
		<a href="javascript:unready();">유로로 더 많은 기능 사용하기</a>
		</p>
	</div>
	
	<%@ include file="_inc/footer.jsp"%>

</body>
<script>
    function unready(){
        alert("아직 준비중입니다.");
    }

 </script>

</html>

