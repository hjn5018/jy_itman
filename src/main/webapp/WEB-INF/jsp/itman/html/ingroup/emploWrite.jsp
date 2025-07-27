<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<?php 
	include "../_inc/dbconn.php";
	
    /**
     * 세션 체크
     */
	session_start();
	$group = $_SESSION['group'];

	/**
	 * 부서, 직위, 상태를 group 마다 option으로 뿌리기
	 */
	$div_sql = "SELECT divIdx, DIV_NAME FROM ITM_DIVISION WHERE GRO_IDX= $group AND DEL_YN = 'N' AND (DIV_YN = 'Y' OR DIV_YN = '사' )";
	$div_query = mysqli_query($dbconn, $div_sql);
	
	$pos_sql = "SELECT posIdx, POS_NAME FROM ITM_POSITION WHERE GRO_IDX= $group AND DEL_YN = 'N'";
	$pos_query = mysqli_query($dbconn, $pos_sql);

	$st_sql = "SELECT empStIdx, EMP_ST_NAME FROM ITM_EMP_STATE WHERE GRO_IDX = $group AND DEL_YN = 'N'";
	$st_query = mysqli_query($dbconn, $st_sql);

?>

<? $page_num_depth_01 = 2; ?>

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
		<form method="post" id='write' action="./emploWriteProc.do">
		<ul class="adminView Write">
			<li>
				<p class="tit">사번 <span>*</span></p>
				<p class="cont"><input id="empNum" name="empNum" type="text" placeholder="사번을 입력해주세요"></p>
			</li>
			<li>
				<p class="tit">이름 <span>*</span></p>
				<p class="cont"><input id="empName" name="empName" type="text" placeholder="이름을 입력해주세요"></p>
			</li>
			<li>
				<p class="tit">이메일 <span></span></p>
				<p class="cont"><input id="empMail" name="empMail" type="text" placeholder="이메일을 입력해주세요"></p>
			</li>
			<li>
				<p class="tit">휴대폰 <span></span></p>
				<p class="cont"><input id="empTel" name="empTel" type="text" placeholder="휴대폰번호를 입력해주세요"></p>
			</li>
			<li>
				<p class="tit">부서 <span>*</span></p>
				<p class="cont">
					<select id="divIdx" name="divIdx">
						<option value="0">부서를 선택해주세요.</option>
						<?php while($row = (mysqli_fetch_array($div_query))){?>
							<option value=<?=$row['divIdx']?>><?=$row['DIV_NAME']?></option>
						<?php }?>
					</select>
				</p>
                <p class="edit"><a onclick="window.open('../popup/employee/emploDivisionWrite.php', '자산분류등록팝업', 'width=500, height=335')" href="#none">부서 추가</a></p>
			</li>
			<li>
				<p class="tit">직위 <span>*</span></p>
				<p class="cont">
					<select id="posIdx" name="posIdx">
						<option value="0">직위를 선택해주세요.</option>
						<?php while($row = (mysqli_fetch_array($pos_query))){?>
							<option value=<?=$row['posIdx']?>><?=$row['POS_NAME']?></option>
						<?php }?>
					</select>
				</p>
				<p class="edit"><a onclick="window.open('../popup/employee/emploPositionWrite.php', '자산분류등록팝업', 'width=500, height=335')" href="#none">직위 추가</a></p>
			</li>
			<li>
				<p class="tit">상태 <span>*</span></p>
				<p class="cont">
					<select id="empStIdx" name="empStIdx">
						<option value="0">상태를 선택해주세요.</option>
						<?php while($row = (mysqli_fetch_array($st_query))){?>
							<option value=<?=$row['empStIdx']?>><?=$row['EMP_ST_NAME']?></option>
						<?php }?>
					</select>
				</p>
				<p class="edit"><a onclick="window.open('../popup/employee/emploStateWrite.php', '자산분류등록팝업', 'width=500, height=335')" href="#none">상태 추가</a></p>
			</li>
		</ul>
		</form>	
        
		<p class="pagebtn">
		<a href="/html/ingroup/emploList.do" class="del">취소</a>
		<a href="javascript:frm_submit1();" class="comp">등록</a>
		</p>
	</div>
	<%@ include file="../_inc/footer.jsp" %>

	<script>
		function frm_submit(){
			$emp_num_empty = $("#empNum").val().trim();
			$emp_name_empty = $("#empName").val().trim();
			$div_empty = $("#divIdx option:selected").val();
			$pos_empty = $("#posIdx option:selected").val();
			$emp_st_empty = $("#empStIdx option:selected").val();

			if(!$emp_num_empty || !$emp_name_empty || $pos_empty === '0' || $emp_st_empty === '0' || $div_empty === '0'){
				alert("필수 값을 입력(선택)해주세요!");
			}else{
				$("#write").submit();
			}
			$("#write").submit();
			
		}
		function frm_submit1(){
			$("#write").submit();
			
		}
	</script>

</body>
</html>
