<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<!-- Cookie가 비어있지 않을 때 checked 속성을 줌 -->
<c:if test="${not empty cookie.user_check}">
	<c:set value="checked" var="checked"/>
</c:if>
	
<script type="text/javascript">
$(document).ready(function() {
	
	//페이지 접속 시 아이디 입력창으로 포커스 이동
	$("#id").focus();

	//로그인 버튼 클릭 시, 
	$("#btnLogin").click(function() {
		
		console.debug("#btnLogin click 1")
		
		var id = $('#id').val();
		var pw = $('#pw').val();
		
		$.ajax({
			
			async : true	//비동기식
			,type : "POST"
			,url: "/member/loginCheck"
			,data : {
				id : id, 
				pw : pw
			}
			,dataType: "json"		
			
			,success: function(data) {
				console.debug("#btnLogin click 2")
				console.debug("data", data)
				
	
				if(data){
					console.debug("#btnLogin click 2-1")

				   	location.href = '/main';
				   	
				}else{
					console.debug("#btnLogin click 2-2")

					alert('잘못된 아이디이거나, 비밀번호가 틀렸습니다.');

				}
				
	      	}
			
			, error: function() {
				console.debug("#btnLogin click 3")
				console.log("AJAX 실패 : login")
			
			}
	  	});//ajax end
	  	
	  	
		console.debug("#btnLogin click 4")
	
	})//$("#btnLogin").click(function() end

	// 	취소버튼 클릭시 뒤로 가기
	$("#cancel").click(function() {
		history.go(-1)
		
	})

// 	커서를 아이디 입력창에 위치시킴
	$("#id").focus();
	
})//$(document).ready(function() end
</script>

<!-- ------------------------------------------------------------------------- -->
		
<script type="text/javascript"><!-- 카카오 로그인 관련 script -->
//발급받은 키 중 javascript키를 사용해준다.
Kakao.init('2328328693af820fd23180bbdcec1e85'); 

//sdk초기화여부판단
console.log(Kakao.isInitialized()); 

//카카오 로그인 진행
function kakaoLogin() {
	
	// 카카오 api로 이동하여 로그인을 진행하는 함수 호출
    Kakao.Auth.login({
    
    	success: function (response) {
    		console.log(response);
    		
    		// 카카오 api 함수 호출
      		Kakao.API.request({
          		
      			// 카카오 로그인 정보를 가져올 주소를 작성
      			url: '/v2/user/me',
          		
          		success: function (response) {
        	  		console.log(response)
        	  		
        	  		// 가져온 카카오 로그인 정보를 변수에 할당
        	  		var kakao_account = response.kakao_account;
					
        	  		console.log(kakao_account.email);
					console.log(kakao_account.profile.nickname);
					
					// 카카오 로그인 nickName 정보를 <form>에 입력한다.
					$('#form-social-login input[name=socialName]').val(kakao_account.profile.nickname);
					
					// 카카오 로그인 email 정보를 <form>에 입력한다.
					$('#form-social-login input[name=socialEmail]').val(kakao_account.email);
					
					var kakaoLoginType = 2;
					// 카카오 로그인 타입 정보를 <form>에 입력한다.
					$('#form-social-login input[name=loginType]').val(kakaoLoginType);
					
					// 사용자 정보가 포함된 <form>을 서버로 제출한다.
					document.querySelector('#form-social-login').submit();
          		},
          		
         		fail: function (error) {
         			console.log(error)
            		
            		alert('login success, but failed to request user information: ' + JSON.stringify(error))
         		},
         		
        	})//Kakao.API.request() end
        	
      	},//success: function (response) end
      	
      	fail: function (error) {
        	console.log(error)
        	
        	alert('failed to login: ' + JSON.stringify(err))
        },
    
    })//Kakao.Auth.login() end
    
}//function kakaoLogin() end
</script><!-- 카카오 로그인 관련 script end -->

<!-- ------------------------------------------------------------------------- -->

<script type="text/javascript"><!-- 카카오 로그아웃 관련 script -->
// function kakaoLogout() {
    
// 	if (Kakao.Auth.getAccessToken()) {	//카카오 로그인 상태라면
      	
// 		// 카카오 api 함수 호출
// 		Kakao.API.request({
        
// 			// 카카오 로그아웃을 진행하는 api 주소
// 			url: '/v1/user/unlink',

// 			success: function (response) {
//         		console.log(response)
        		
//         		//컨트롤러단으로 이동하여 session 초기화 진행(loginType 초기화)
//         		location.href="/member/logout" 
//         	},
//         	fail: function (error) {
//           		console.log(error)
//         	},
//       	})
      
//       	Kakao.Auth.setAccessToken(undefined)
// 	}
	
// }//function kakaoLogout() end 

//카카오와의 연동을 끊기 위해서는,
//rest key를 이용하여 인가 코드와 토큰을 받은 후, 로그인 시 사용하고, 로그아웃 시, 인가 코드를 만료시켜야 한다.
//js로 인가코드를 만료시키는 방법을 찾아야 한다.

</script><!-- 카카오 로그아웃 관련 script end -->

<!-- ------------------------------------------------------------------------- -->

<style type="text/css">
form {
	width: 550px;
	margin: 0 auto;
}

#id, #pw {
	width: 280px;
}

/* #btnLogin, #btnCancel {	 */
/* 	width: ?px; */
/* 	height: ?px; */
/* 	border: ?px ? ?; */
/* 	color: ?; */
/* 	font-size: ?px; */
/* 	border-radius: ?px;  */
/* 	background: ?; */
/* 	padding-right: ?px; */
/* 	padding-left: ?px; */
/* 	font-color: ?; */
/* 	margin-bottom: ?px; */
/* 	margin-top: ?px; */
/* } */

#btnFindId {
	border: 0px;
	background: white;
	margin-right: 5px;
}

#btnFindPw {
	border: 0px;
	background: white;
	margin-left: 5px;
}

#btnJoin {
	border: 0px;
	background: white;
	margin-left: 5px;
}
</style>

<!-- ------------------------------------------------------------------------- -->	
		
<div class="container" style="height:830px;">

<div id="result"></div>

<br><br>

<form action="/member/login" id="loginForm" name="loginForm" method="post" class="form-horizontal"  onsubmit="return false;">

<div style="border: 1px solid #ccc; border-radius: 10px;">
	
	<h2 style="margin-left: 20px;">로그인</h2>
	
	<br>
	
	<div class="form-group" style="margin-left: 50px;">
		<label for="id" class="control-label col-xs-2"><b>아이디</b></label>
		<div class="col-xs-10">
			<input type="text" id="id" name="id" class="form-control">
		</div>
	</div>

	<div class="form-group" style="margin-left: 50px;">
		<label for="pw" class="control-label col-xs-2"><b>패스워드</b></label>
		<div class="col-xs-10">
			<input type="password" id="pw" name="pw" class="form-control">
		</div>
	</div>
	
	<div class="form-group" style="margin-left: 66px;">
		<input type="checkbox" id="remember_us" name="remember_userId" ${checked}> 아이디 기억하기
	</div>

	<div class="form-group text-center"> 
		<input type="submit" id="btnLogin" class="btn btn-primary" value="로그인" /> 
		<input type="reset" id="cancel" class="btn btn-danger" value="취소" />
	</div>
		
	<div class="form-group text-center">	
		<button type="button" id="btnFindId" onclick="location.href='<%=request.getContextPath() %>/member/idFind'">아이디 찾기</button> | 
		<button type="button" id="btnFindPw" onclick="location.href='<%=request.getContextPath() %>/member/pwFind'">비밀번호 찾기</button> |
		<button type="button" id="btnJoin" onclick="location.href='<%=request.getContextPath() %>/member/join'">회원가입</button>		
	</div>

</div>
		
</form>			

<br>

<!-- ------------------------------------------------------------------------- -->

<div class="form-group text-center"> 			
	<!-- kakao_login_btn -->
	<a href="javascript:kakaoLogin()"><img src="/resources/img/kakao_login.png" /></a>
</div>

<br>
<!-- ------------------------------------------------------------------------- -->

<!-- naver_login_btn 노출 영역 -->
<div id="naver_id_login" class="form-group text-center"></div>
<script type="text/javascript"><!-- 네이버 로그인 관련 script -->	
	var naver_id_login = new naver_id_login("W7Z4mrDSsCvokOeLLobe", "http://localhost:8088/member/callback");
	var state = naver_id_login.getUniqState();
	naver_id_login.setButton("white", 2,40);
	naver_id_login.setDomain("http://localhost:8088");
	naver_id_login.setState(state);
	naver_id_login.init_naver_id_login();
</script><!-- 네이버 로그인 관련 script end -->

<br>
<!-- ------------------------------------------------------------------------- -->

<div class="form-group text-center"> 	
<!-- google_login_btn -->
<div class="g-signin2" data-onsuccess="onSignIn"></div>
</div>

<!-- ------------------------------------------------------------------------- -->
				
<!-- 소셜 로그인 시, 소셜에 등록돼있는 정보가 입력될 <form> -->			
<form action="/member/login" id="form-social-login" method="post">
	<input type="hidden" name="socialName"/>
	<input type="hidden" name="socialEmail"/>
	<input type="hidden" name="loginType"/>
</form>

</div><!-- .container end -->

<c:import url="/WEB-INF/views/layout/footer.jsp" />

