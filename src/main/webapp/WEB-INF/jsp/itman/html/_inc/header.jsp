<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<?php
    include("dbconn.jsp");
	include "/home/itman/public_html/html/_inc/loginTest.jsp";
    $group = $_SESSION['group'];
    // $smn_sql = "SELECT * FROM ITM_GROUP WHERE GRO_OWNER_IDX = '".$_SESSION['userIDX']."'";
	$smn_sql = "SELECT * FROM ITM_GROUP WHERE REG_IDX = '{$_SESSION['userIDX']}' AND DEL_YN = 'N'";
    $smn_result = mysqli_query($dbconn, $smn_sql);
	// $_SESSION['group'] = $_GET['group'];
	
	$GROUP_IMG_SQL = "SELECT GRO_IMG FROM ITM_GROUP WHERE GRO_IDX={$_SESSION['group']}";
	$GROUP_IMG_QUERY = mysqli_query($dbconn, $GROUP_IMG_SQL);
	$GROUP_IMG_RESULT = mysqli_fetch_array($GROUP_IMG_QUERY);
	

	$GROUP_IMG = $GROUP_IMG_RESULT['GRO_IMG'];

	if($GROUP_IMG == ""){
		$GROUP_IMG = "no_img.png";
	}

	$ITM_ASSET = "SELECT * FROM ITM_ASSET WHERE GRO_IDX={$_SESSION['group']} AND DEL_YN='N'";
    $ITM_ASSET_result = mysqli_query($dbconn, $ITM_ASSET);
	$ITM_ASSET_COUNT = mysqli_num_rows($ITM_ASSET_result);
	
    $ITM_EMPLOYEE = "SELECT * FROM ITM_EMPLOYE WHERE GRO_IDX={$_SESSION['group']} AND DEL_YN='N'";
    $ITM_EMPLOYEE_result = mysqli_query($dbconn, $ITM_EMPLOYEE);
	$ITM_EMPLOYEE_COUNT = mysqli_num_rows($ITM_EMPLOYEE_result);
	
    $ITM_DIVISION = "SELECT * FROM ITM_DIVISION WHERE GRO_IDX={$_SESSION['group']} AND DEL_YN='N'";
    $ITM_DIVISION_result = mysqli_query($dbconn, $ITM_DIVISION);
	$ITM_DIVISION_COUNT = mysqli_num_rows($ITM_DIVISION_result);
	
    $ITM_POSITION = "SELECT * FROM ITM_POSITION WHERE GRO_IDX={$_SESSION['group']} AND DEL_YN='N'";
    $ITM_POSITION_result = mysqli_query($dbconn, $ITM_POSITION);
	$ITM_POSITION_COUNT = mysqli_num_rows($ITM_POSITION_result);
	
    $ITM_SUPPLIER = "SELECT * FROM ITM_SUPPLIER WHERE GRO_IDX={$_SESSION['group']} AND DEL_YN='N'";
    $ITM_SUPPLIER_result = mysqli_query($dbconn, $ITM_SUPPLIER);
	$ITM_SUPPLIER_COUNT = mysqli_num_rows($ITM_SUPPLIER_result);
	
    $ITM_LOCATION = "SELECT * FROM ITM_LOCATION WHERE GRO_IDX={$_SESSION['group']} AND DEL_YN='N'";
    $ITM_LOCATION_result = mysqli_query($dbconn, $ITM_LOCATION);
	$ITM_LOCATION_COUNT = mysqli_num_rows($ITM_LOCATION_result);
	
    $ITM_STATE = "SELECT * FROM ITM_STATE WHERE GRO_IDX={$_SESSION['group']} AND DEL_YN='N'";
    $ITM_STATE_result = mysqli_query($dbconn, $ITM_STATE);
	$ITM_STATE_COUNT = mysqli_num_rows($ITM_STATE_result);
	
    $ITM_EMP_STATE = "SELECT * FROM ITM_EMP_STATE WHERE GRO_IDX={$_SESSION['group']} AND DEL_YN='N'";
    $ITM_EMP_STATE_result = mysqli_query($dbconn, $ITM_EMP_STATE);
	$ITM_EMP_STATE_COUNT = mysqli_num_rows($ITM_EMP_STATE_result);

    $ITM_ASSET_CATEGORY = "SELECT * FROM ITM_ASSET_CATEGORY WHERE GRO_IDX={$_SESSION['group']} AND DEL_YN='N'";
    $ITM_ASSET_CATEGORY_result = mysqli_query($dbconn, $ITM_ASSET_CATEGORY);
	$ITM_ASSET_CATEGORY_COUNT = mysqli_num_rows($ITM_ASSET_CATEGORY_result);
	
?>

<header>
	<div class="h_left">
	<p class="ham"><a href="#none"><span></span><span></span><span></span></a></p>
		<!-- <h1><a href="dashboard.jsp"><img src="https://www.withsystem.com/with2019/_img/comn/logo2020.png" alt="위드시스템" /></a></h1> -->
		<h1><a href="dashboard.jsp"><img src="" alt="" /></a></h1>
<%-- 		<h1><a href="dashboard.jsp"><img src="<?="/html/groupImage/".$GROUP_IMG?>" alt="" /></a></h1> --%>
		<div class="tmn">
			<p class="m_tit"></p>
			<ul class="list">
				<li class="dash"><a href="dashboard.jsp">대시보드</a></li>
				<li><a href="assetsList.jsp">자산 관리<span></span></a></li>
				<li><a href="emploList.jsp" >직원 관리<span></span></a></li>
				<li><a href="departList.jsp" >부서 관리<span></span></a></li>
				<li><a href="spotList.jsp">직위 관리<span></span></a></li>
				<li><a href="buyList.jsp">구매처 관리<span></span></a></li>
				<li><a href="locList.jsp">위치 관리<span></span></a></li>
				<li><a href="assetCategory.jsp">자산 분류 관리<span></span></a></li>
				<li><a href="aStatList.jsp">자산 상태 관리<span></span></a></li>
				<li><a href="eStatList.jsp">직원 상태 관리<span></span></a></li>
				<li>
					<!-- <a href="ahistory.jsp">히스토리</a> -->
					<a href="ahistory.jsp">자산 히스토리</a>
					<!-- <p class="depth">
						<a href="ahistory.jsp" <?if($page_num_depth_01 == "9"){?>class="on"<?}?>>자산 히스토리</a>
						<a href="shistory.jsp" <?if($page_num_depth_01 == "10"){?>class="on"<?}?>>시스템 히스토리</a>
					</p> -->
				</li>
<!-- 				<li class="dash"><a href="dashboard.jsp" <?if($page_num_depth_01 == "0"){?>class="on"<?}?>>대시보드</a></li> -->
<!-- 				<li><a href="assetsList.jsp" <?if($page_num_depth_01 == "1"){?>class="on"<?}?>>자산 관리<span><?= $ITM_ASSET_COUNT ?></span></a></li> -->
<!-- 				<li><a href="emploList.jsp" <?if($page_num_depth_01 == "2"){?>class="on"<?}?>>직원 관리<span><?= $ITM_EMPLOYEE_COUNT ?></span></a></li> -->
<!-- 				<li><a href="departList.jsp" <?if($page_num_depth_01 == "3"){?>class="on"<?}?>>부서 관리<span><?= $ITM_DIVISION_COUNT ?></span></a></li> -->
<!-- 				<li><a href="spotList.jsp" <?if($page_num_depth_01 == "4"){?>class="on"<?}?>>직위 관리<span><?= $ITM_POSITION_COUNT ?></span></a></li> -->
<!-- 				<li><a href="buyList.jsp" <?if($page_num_depth_01 == "5"){?>class="on"<?}?>>구매처 관리<span><?= $ITM_SUPPLIER_COUNT ?></span></a></li> -->
<!-- 				<li><a href="locList.jsp" <?if($page_num_depth_01 == "6"){?>class="on"<?}?>>위치 관리<span><?= $ITM_LOCATION_COUNT ?></span></a></li> -->
<!-- 				<li><a href="assetCategory.jsp" <?if($page_num_depth_01 == "11"){?>class="on"<?}?>>자산 분류 관리<span><?= $ITM_ASSET_CATEGORY_COUNT ?></span></a></li> -->
<!-- 				<li><a href="aStatList.jsp" <?if($page_num_depth_01 == "7"){?>class="on"<?}?>>자산 상태 관리<span><?= $ITM_STATE_COUNT ?></span></a></li> -->
<!-- 				<li><a href="eStatList.jsp" <?if($page_num_depth_01 == "8"){?>class="on"<?}?>>직원 상태 관리<span><?= $ITM_EMP_STATE_COUNT ?></span></a></li> -->
<!-- 				<li> -->
<!-- 					<a href="ahistory.jsp">히스토리</a> -->
<!-- 					<a href="ahistory.jsp" <?if($page_num_depth_01 == "9"){?>class="on"<?}?>>자산 히스토리</a> -->
<!-- 					<p class="depth">
<!-- 						<a href="ahistory.jsp" <?if($page_num_depth_01 == "9"){?>class="on"<?}?>>자산 히스토리</a> -->
<!-- 						<a href="shistory.jsp" <?if($page_num_depth_01 == "10"){?>class="on"<?}?>>시스템 히스토리</a> -->
<!-- 					</p> -->
<!-- 				</li> -->
			</ul>
		</div>
	</div>
	<div class="h_right">
		<a href="#" class="hr_btn"><span></span><span></span><span></span></a>
		<p class="hr_box">
			<span><?= $_SESSION['username']; ?>님</span>
			<a href="/html/user/mypage.jsp" class="mypage">마이페이지</a>
			<a href="/html/user/logout_proc.jsp" class="logout">로그아웃</a>
			<a href="/html/group.jsp" class="group">전체그룹메인</a>
		</p>
	</div>
</header>

<!-- 사이드메뉴 -->
<div class="smn">
	<ul class="smn_list">
		<li>
			<?php
				while(($smn_row = mysqli_fetch_array($smn_result))) {
			?>
				<li>
					<p><a href="#"><?= $smn_row['GRO_NAME']; ?></a></p>
					<ul>
                        <!-- post로 group_proc에 값보내기 -->
						<!-- <li><a href="javascript:movePage(<?= $smn_row['GRO_IDX']; ?>,0);">대시보드</a></li> -->
                        <li><a href="/html/group_proc.jsp?group=<?= $smn_row['GRO_IDX']; ?>&id=0">대시보드</a></li>
						<li><a href="/html/group_proc.jsp?group=<?= $smn_row['GRO_IDX']; ?>&id=1">자산 관리</a></li>
						<li><a href="/html/group_proc.jsp?group=<?= $smn_row['GRO_IDX']; ?>&id=2">직원 관리</a></li>
						<li><a href="/html/group_proc.jsp?group=<?= $smn_row['GRO_IDX']; ?>&id=3">부서 관리</a></li>
						<li><a href="/html/group_proc.jsp?group=<?= $smn_row['GRO_IDX']; ?>&id=4">직위 관리</a></li>
						<li><a href="/html/group_proc.jsp?group=<?= $smn_row['GRO_IDX']; ?>&id=5">구매처 관리</a></li>
						<li><a href="/html/group_proc.jsp?group=<?= $smn_row['GRO_IDX']; ?>&id=6">위치 관리</a></li>
					</ul>
				</li>
			<?php } ?>
		<li>

	</ul>
	<p class="go_itman"><a href="/html/index.jsp"><span><img src="/html/_img/_favicon/apple-icon-180x180.png"></span>아이티맨 메인으로가기</a></p>
</div>

<script>
    function movePage($groupIDX, $pageIDX){
		<?php echo "location.href='/html/group_proc.jsp?group=$groupIDX&id=$pageIDX'"; ?>
	};
</script>


<!-- 비고팝업 -->
<div class="more_layer">
	<div class="bg"></div>
	<div class="pop-layer">
		<div class="pop_tit">
			<p class="title">비고</p>
			<p class="close"><a class="cbtn" href="#none"><img src="/html/_img/close.png" alt="닫기" /></a></p>
		</div>
		<div class="pop_cont">
		</div>
	</div>
</div>
<!-- 비고팝업 끝 -->
