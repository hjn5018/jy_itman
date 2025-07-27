<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<!doctype html>
	<html lang="ko">
	<!-- 회원가입 프로세스
    join01 - join02 - send_email_proc - certPass - join_proc - join03 
-->

	<head>
		<%@ include file="../_inc/dbconn.jsp" %>
		<%@ include file="../_inc/title.jsp" %>
	</head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<body>
		<div id="contents">
			<div class="user_box join">
				<p class="tit"><a href="/html.do"><img src="${pageContext.request.contextPath }/itman_html/_img/itman_logo.png" alt="아이티맨" /></a></p>
				<ul class="step">
					<li class="comp"><span>1</span></li>
					<li class="on"><span>2</span>가입 정보 입력 및 인증</li>
					<li><span>3</span></li>
				</ul>
				<form action="${pageContext.request.contextPath}/user/sendEmailProc.do" name="frm" id="frm" method="post">
					<ul class="mem">
                    <li>
                        <p>사용자 이름</p>
                        <div><input type="text" id="memName" name="memName" placeholder="홍길동" /></div>
                    </li>
                    <li>
                        <p>이메일</p>
                        <div>
                            <input type="text" class="fadeInfirst" name="memMail" id="id" placeholder="example@example.com" required />
                            <div id="emailCheck"></div>
                        </div>
                    </li>
                    <li>
                        <p>비밀번호</p>
                        <div><input type="password" id="memPw" name="memPw" /></div>
                    </li>
                    <li>
                        <p>비밀번호 확인</p>
                        <div><input type="password" id="userpw_ch" name="userpw_ch" /></div>
                    </li>
                    <li>
                        <p>휴대폰</p>
                        <div class="tel">
                            <p class="full">
                                <select id="userphone1" name="userphone1">
                                    <option value="010">010</option>
                                    <option value="011">011</option>
                                    <option value="012">012</option>
                                </select><span>&#8209;</span><input type="tel" id="userphone2" name="userphone2"/><span>&#8209;</span><input type="tel" id="userphone3" name="userphone3"/>
                                
                                
                            </p>
                        </div>
                    </li>
                </ul>
                <input type="hidden" name="mode" value="회원가입" />
                <p class="user_btn"><a href="javascript:fn_submit();">다음</a></p>
            </form>
        </div>
    </div>

    <%@ include file="../_inc/footer.jsp" %>

    <script type="text/javascript">
        $(document).ready(function(){
        	$(".fadeInfirst").on("keyup", function(){
        	    var email = $(this).val();
        	    $.post("${pageContext.request.contextPath}/itman/user/emailCheck.do", { email: email }, function(data){
        	        if(data == "0"){
        	            $("#emailCheck").html("<span class='true'>사용가능한 이메일입니다</span>");
        	        } else if(data == "1"){
        	            $("#emailCheck").html("<span class='false'>이미 존재하는 이메일입니다.</span>");
        	        } else if(data == "2"){
        	            $("#emailCheck").html("<span class='false'>이메일 형식에 맞게 입력해주세요.</span>");
        	        }
        	    });
        	});
        });

        function fn_submit(){
            if($("#memName").val().trim() == ""){ alert("이름을 입력해주세요."); $("#memName").focus(); return false; }
            var expNameText = /[가-힣]+$/;
            if(!expNameText.test($("#memName").val())){ alert("이름을 한글로 입력해주세요."); $("#memName").focus(); return false; }

            if($("#id").val().trim() == ""){ alert("이메일을 입력해주세요."); $("#id").focus(); return false; }
            var expEmailText = /^[A-Za-z0-9\.\-]+@[A-Za-z0-9\.\-]+\.[A-Za-z0-9\.\-]+$/;
            if(!expEmailText.test($("#id").val())){ alert("이메일 형식에 맞게 입력해주세요."); $("#id").focus(); return false; }

            if($("#memPw").val().trim() == ""){ alert("비밀번호를 입력해주세요."); $("#memPw").focus(); return false; }
            if($("#userpw_ch").val().trim() == ""){ alert("비밀번호 확인을 입력해주세요."); $("#userpw_ch").focus(); return false; }
            if($("#memPw").val().trim().length < 6 || $("#memPw").val().trim().length > 20){ alert("비밀번호는 6자 이상 20자 이하로 입력해주세요."); $("#memPw").focus(); return false; }
            if($("#memPw").val().trim() != $("#userpw_ch").val().trim()){ alert("비밀번호가 다릅니다. 다시 입력해주세요."); $("#userpw_ch").focus(); return false; }

            if($("#userphone2").val().trim() == ""){ alert("휴대폰 번호를 입력해주세요."); $("#userphone2").focus(); return false; }
            if($("#userphone3").val().trim() == ""){ alert("휴대폰 번호를 입력해주세요."); $("#userphone3").focus(); return false; }
            if($("#userphone2").val().trim().length > 4){ alert("휴대폰 형식을 확인해주세요."); $("#userphone2").focus(); return false; }
            if($("#userphone3").val().trim().length > 4){ alert("휴대폰 형식을 확인해주세요."); $("#userphone3").focus(); return false; }

            $("#frm").submit();
        }
    </script>
</body>
</html>
