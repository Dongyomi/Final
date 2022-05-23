<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<html>

<head>

<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

</head>

<body>

<script type="text/javascript"><!-- 네이버 로그인 관련 script -->
var naver_id_login = new naver_id_login("W7Z4mrDSsCvokOeLLobe", "http://localhost:8088/member/callback");

// 접근 토큰 값 출력
alert(naver_id_login.oauthParams.access_token);

// 네이버 사용자 프로필 조회
naver_id_login.get_naver_userprofile("naverSignInCallback()");

//네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
function naverSignInCallback() {

	console.log('Name: ' + naver_id_login.getProfileData('name') );
  	console.log('Email: ' + naver_id_login.getProfileData('email') ); 
  	
  	//네이버 로그인 name 정보를 <form>에 입력한다.
	$('#form-social-login input[name=socialName]').val(naver_id_login.getProfileData('name') );
	
	//네이버 로그인 email 정보를 <form>에 입력한다.
	$('#form-social-login input[name=socialEmail]').val(naver_id_login.getProfileData('email') );
	
	var naverLoginType = 3;
	// 네이버 로그인 타입 정보를 <form>에 입력한다.
	$('#form-social-login input[name=loginType]').val(naverLoginType);
	
	//사용자 정보가 포함된 <form>을 서버로 제출한다.
	document.querySelector('#form-social-login').submit();
}
</script><!-- 네이버 로그인 관련 script end -->

<!-- ------------------------------------------------------------------------- -->
						
<!-- 네이버 로그인 시, 네이버에 등록돼있는 정보가 입력될 <form> -->			
<form id="form-social-login" method="post" action="/member/callback">
		<input type="hidden" name="socialName"/>
		<input type="hidden" name="socialEmail"/>
		<input type="hidden" name="loginType"/>
</form>
		
</body>
</html>