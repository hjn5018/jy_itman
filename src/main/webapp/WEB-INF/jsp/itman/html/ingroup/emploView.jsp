<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<?php
    include "../_inc/dbconn.php";

    /**
     * 세션 체크
     */
	session_start();


	/**
	 * 전역 변수
	 */
	$group = $_SESSION['group'];
	$page_num_depth_01 = 2; 
	$emp_idx = $_GET['idx'];
	
	$sql = "SELECT * FROM ITM_EMPLOYE ie
	LEFT JOIN ITM_DIVISION id ON ie.DIV_IDX = id.DIV_IDX
	LEFT JOIN ITM_POSITION ip ON ie.POS_IDX  = ip.POS_IDX
	LEFT JOIN ITM_EMP_STATE ies ON ies.EMP_ST_IDX = ie.EMP_ST_IDX 
	WHERE ie.EMP_IDX = '{$emp_idx}' AND ie.DEL_YN = 'n'";

	$query= mysqli_query($dbconn, $sql);

	$asset_sql = "SELECT *,(SELECT ASS_CAT_NAME FROM ITM_ASSET_CATEGORY WHERE ASS_CAT_IDX = IA.ASS_CAT_IDX) ASS_CAT_NAME FROM ITM_ASSET IA
				  WHERE EMP_IDX = $emp_idx";
	$asset_query = mysqli_query($dbconn, $asset_sql);
	$asset_num =mysqli_num_rows($asset_query);
?>

<%
request.setAttribute("page_num_depth_01", "2");
%>

<!doctype html>
<html lang="ko">
 <head>
 <%@ include file="../_inc/title.jsp" %>
 </head>
<body>
<%@ include file="../_inc/header.jsp" %>

	<div id="contents">
		<div class="tit_search">
			<h2>직원 관리</h2>
		</div>
		
		<!-- 글삭제 -->
		<p class="delContent"><a onclick="window.open('../popup/employee/emploDel.do?empIdx=${vo.empIdx}', '삭제팝업', 'width=500, height=300')" href="#none"><img src="../../itman_html/_img/del_view.png"></a></p>

		<ul class="adminView">
		<?php 
            while($row = (mysqli_fetch_array($query))){
                ?>
			<li>
				<p class="tit v02">사번</p>
				<p class="cont">${vo.empNum }</p>
				<p class="edit"><a onclick="window.open('../popup/employee/emploFieldEdit.do?field=empNum&empIdx=${vo.empIdx}&empNum=${vo.empNum}', '수정팝업', 'width=500, height=335')" href="#none" class="edit">수정</a></p>
			</li>
			<li>
				<p class="tit v02">이름</p>
				<p class="cont">${vo.empName }</p>
				<p class="edit"><a onclick="window.open('../popup/employee/emploFieldEdit.do?field=empName&empIdx=${vo.empIdx}&empNum=${vo.empName}', '수정팝업', 'width=500, height=335')" href="#none" class="edit">수정</a></p>
			</li>
			<li>
				<p class="tit v02">이메일</p>
				<p class="cont">${vo.empMail }</p>
				<p class="edit"><a onclick="window.open('../popup/employee/emploFieldEdit.do?field=empMail&empIdx=${vo.empIdx}&empMail=${vo.empMail}', '수정팝업', 'width=500, height=335')" href="#none" class="edit">수정</a></p>
			</li>
			<li>
				<p class="tit v02">휴대폰</p>
				<p class="cont">${vo.empTel }</p>
				<p class="edit"><a onclick="window.open('../popup/employee/emploFieldEdit.do?field=empTel&empIdx=${vo.empIdx}&empTel=${vo.empTel}', '수정팝업', 'width=500, height=335')" href="#none" class="edit">수정</a></p>
			</li>
			<li>
				<p class="tit v02">부서</p>
				<p class="cont">${vo.divIdx }</p>
				<p class="edit"><a onclick="window.open('../popup/employee/emploFieldEdit.do?field=divIdx&empIdx=${vo.empIdx}&divIdx=${vo.divIdx}', '수정팝업', 'width=500, height=335')" href="#none" class="edit">수정</a></p>
			</li>
			<li>
				<p class="tit v02">직위</p>
				<p class="cont">${vo.posIdx }</p>
				<p class="edit"><a onclick="window.open('../popup/employee/emploFieldEdit.do?field=posIdx&empIdx=${vo.empIdx}&posIdx=${vo.posIdx}', '수정팝업', 'width=500, height=335')" href="#none" class="edit">수정</a></p>
			</li>
			<li>
				<p class="tit v02">상태</p>
				<p class="cont">${vo.empStIdx }</p>
				<p class="edit"><a onclick="window.open('../popup/employee/emploFieldEdit.do?field=empStIdx&empIdx=${vo.empIdx}&empStIdx=${vo.empStIdx}', '수정팝업', 'width=500, height=335')" href="#none" class="edit">수정</a></p>
			</li>
			<?php } ?>
		</ul>


		<h3>소유 자산</h3>
		<div class="Basic">
			<!-- 검색결과가 없을때
				<ul class="adminList">
					<li class="nocont">
					 검색 결과가 없습니다.
					</li>
				</ul>
			-->

			<ul class="adminList click img">
				<li class="tit">
					<p class="img">자산 이미지</p>
					<p class="num">일련번호</p>
					<p class="tit">자산명</p>
					<p class="cate">분류</p>
					<p class="date02">최초구매일</p>
					<p class="view"></p>
				</li>
				<!-- <?php if($asset_num == 0){?>
					<li class="nocont">
					 검색 결과가 없습니다.
					</li>
					<?php } ?>
					<?php
            while($row = (mysqli_fetch_array($asset_query))){
				?>
					<li onclick="location.href='assetsView.php?ASS_IDX=<?=$row['ASS_IDX']?>'">
						<p class="img"><span><img src="../upload/assetImg/<?= $row['IMAGE']?>" onerror = "this.src='../../sitman_html/_img/noimg.png'" alt="자산이미지 썸네일"/></span></p>
						<p class="num"><?=$row['ASS_ULID']?></p>
						<p class="tit"><?=$row['ASS_NAME']?></p>
						<p class="cate"><?=$row['ASS_CAT_NAME']?></p>
						<p class="date02"><?=$row['BUY_DATE']?></p>
						<p class="view"></p>
					</li>				
				<?php } ?> -->
			</ul>
		</div>
	</div>
	<%@ include file="../_inc/footer.jsp" %>
</body>
</html>
