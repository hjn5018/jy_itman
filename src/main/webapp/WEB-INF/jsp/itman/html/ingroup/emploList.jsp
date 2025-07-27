<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<?php
    include "../_inc/dbconn.php";

    /**
     * 세션 체크
     */
    session_start();
    $group_idx = $_SESSION['group'];

    /**
     * 직원 상세뷰 매핑 url 함수 
     */
    function empo_view_url($emp_idx){
        $empo_view_url = "emploView.php?idx=$emp_idx";
        return $empo_view_url;
    }

    /**
     *  option - select 함수
     */
    function selectCheck($value){
        $search = $_POST['search'];
            if($value == $search){
                echo "selected";
            }
    }


    /**
     * pagination
     * 일단 한페이지당 10개 씩 출력으로 설정 
     */
    $page_per_result = 10;
    $page = 1;
    if($_GET['page']){
        $page = $_GET['page'];
    }

    /**
     *  그룹별 직원 검색  
     */
    $sql = "SELECT * FROM ITM_EMPLOYE ie
        LEFT JOIN ITM_DIVISION id ON ie.DIV_IDX = id.DIV_IDX
        LEFT JOIN ITM_POSITION ip ON ie.POS_IDX  = ip.POS_IDX
        LEFT JOIN ITM_EMP_STATE ies ON ies.EMP_ST_IDX = ie.EMP_ST_IDX
        WHERE ie.GRO_IDX = $group_idx AND ie.DEL_YN = 'N'";
    $count = 0;


    if(empty($_POST['search'])){    
    /**
     * 검색 조건문  (처음 직원 관리 페이지 들어갈 경우)
     */
        $query_count = mysqli_query($dbconn, $sql);
        $count =mysqli_num_rows($query_count);

    }elseif($_POST['search']== 'all'){
    /**
     *  검색 조건문 (전체로 검색) - 사번 , 이름, 부서 
     */
        $like = $_POST['like'];
        $add = " AND (ie.EMP_NUM LIKE '%{$like}%' OR ie.EMP_NAME LIKE '%{$like}%' OR id.DIV_NAME LIKE '%{$like}%')";

        $sql = $sql.$add;

        $query_count = mysqli_query($dbconn, $sql);
        $count =mysqli_num_rows($query_count);

    }elseif($_POST['search']== 'emp'){
    /**
     *  검색 조건문 (사번으로 검색)
     */
        $like = $_POST['like'];
        $add = " AND ie.EMP_NUM LIKE '%{$like}%'";

        $sql = $sql.$add;

        $query_count = mysqli_query($dbconn, $sql);
        $count =mysqli_num_rows($query_count);

    }elseif($_POST['search']== 'name'){
    /**
     * 검색 조건문 (이름으로 검색)
     */
        $like = $_POST['like'];
        $add = " AND ie.EMP_NAME LIKE '%{$like}%'";

        $sql = $sql.$add;

        $query_count = mysqli_query($dbconn, $sql);
        $count =mysqli_num_rows($query_count);

    }elseif($_POST['search']== 'div'){
    /**
     * 검색 조건문 (부서로 검색)
     */
        $like = $_POST['like'];
        $add = " AND id.DIV_NAME LIKE '%{$like}%'";

        $sql = $sql.$add;

        $query_count = mysqli_query($dbconn, $sql);
        $count =mysqli_num_rows($query_count);       
    }       
    $total_page = ceil($count/$page_per_result);

	if($total_page == 0){
		$total_page = 1;
	}

    $page_start= ($page-1)*$page_per_result;

    $sql = $sql." ORDER BY EMP_IDX DESC LIMIT $page_start, $page_per_result";

    $query = mysqli_query($dbconn, $sql);
?>

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
            <form id="search" method="post" action=<?=$action?>>
            <input type="hidden" name="page" id="page" value="<?=$_POST['page']=== null?"1":$_POST['page'];?>" />
			<p class="list_search">
				<select name="search">
					<option value="all" <?=selectCheck("all")?>>전체</option>
					<option value="emp" <?=selectCheck("emp")?> >사번</option>
					<option value="name" <?=selectCheck("name")?> >이름</option>
					<option value="div" <?=selectCheck("div")?> >부서</option>
				</select>
                <!-- <input name="like" type="text" placeholder="검색어를 입력해주세요."><a href="javascript:{}" onclick="document.getElementById('search').submit();">검색</a></input>-->
                <input name="like" type="text" value="<?=$_POST['like']?>" placeholder="검색어를 입력해주세요."><a href="javascript:search.submit()">검색</a></input> 
                
            
			</p>
            </form>
		</div>
    

		<div class="num_list">
			<p class="total">총 <span><?=$count?></span>건의 결과가 있습니다.</p>
		</div>
		
		<!-- 글쓰기 버튼-->
        <p class="addContent"><a href="/html/ingroup/emploWrite.do"><span></span><span></span><span></span></a></p>
		    <div class="Basic">
			<ul class="adminList click">

				 <li class="tit">
					<p class="num">사번</p>
					<p class="tit">이름</p>
					<p class="depart">부서</p>
					<p class="spot">직위</p>
					<p class="mail">이메일</p>
					<p class="tel">휴대폰</p>
					<p class="stat">상태</p>
				</li>
			
			<c:forEach var="vo" items="${employeeVOList }">
				<li onclick="location.href='/html/ingroup/emploView.do?empIdx=${vo.empIdx }'">
					<p>${vo.empNum }</p>
					<p>${vo.empName }</p>
					<div class="depSpot">
						<p>${vo.divIdx }</p>
						<p>${vo.posIdx }</p>
					</div>
					<div class="mailTel">
						<p>${vo.empMail }</p>
						<p>${vo.empTel }</p>
					</div>
					<p>${vo.empStIdx }</p>
				</li>
			</c:forEach>
			
            <?php 
            while($row = (mysqli_fetch_array($query))){
                ?>
                <li onclick="location.href='<?=empo_view_url($row['EMP_IDX'])?>'">
					<p class="num"><?=$row['EMP_NUM'] ?></p>
					<p class="tit"><?=$row['EMP_NAME']?></p>
					<div class="depSpot">
						<p class="depart"><?=$row['DIV_NAME']?></p>
						<p class="spot"><?=$row['POS_NAME']?></p>
					</div>
					<div class="mailTel">
						<p class="mail"><?=$row['EMP_MAIL']==""?"-":$row['EMP_MAIL'];?></p>
						<p class="tel"><?=$row['EMP_TEL']==""?"-":$row['EMP_TEL'];?></p>
					</div>
					<p class="stat"><?=$row['EMP_ST_NAME']?></p>
				</li>
                <?php } if($count == 0) { ?> 
                    <div style="text-align:center; margin-top:20px;">
                        일치하는 자료가 없습니다.
                    </div>    
                <?php }?>
			</ul>
		</div>

		<p class="paging">
                <a href="<?php echo $_SERVER["PHP_SELF"].'?page='.'1' ;?>" class="prev end"><img src='../_img/first.png' alt='맨처음'></a>
                <a href="<?php echo ($page <= 2) ? $_SERVER["PHP_SELF"].'?page=1': $_SERVER["PHP_SELF"].'?page='.($page-1) ;?>" class="prev"><img src='../_img/prev.png' alt='이전으로'></a>
                <?php for ($i = 1; $i <= $total_page ; $i++) {   ?>
                    <a class="<?php echo ($i == $page || ($page == null && $i ==1)) ? 'on' : '#' ?>" href="<?php echo $_SERVER["PHP_SELF"].'?page='.$i ;?>"><?=$i?></a>
                <?php  }?>
                <a href="<?= $total_page <= $page?$_SERVER["PHP_SELF"].'?page='.$total_page:$_SERVER["PHP_SELF"].'?page='.($page+1);?>" class="next"><img src='../_img/next.png' alt='다음으로'></a>
                <a href="<?php echo $_SERVER["PHP_SELF"].'?page='.$total_page ;?>" class="next end"><img src='../_img/last.png' alt='맨마지막'></a>
            </p>
	</div>
	<%@ include file="../_inc/footer.jsp" %>
    
</body>
<script language="javascript">
function fn_submit(){
    search.submit();
}
function changePage($page){
    $("#page").attr("value", $page);
    $("#search").submit();
}

// function changePage($page){
//     $("#page").attr("value", $page);
//     $("#search").submit();
// }
</script>
</html>
