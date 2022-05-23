<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- daum 도로명주소 찾기 api --> 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">

//모든 공백 체크 정규식
var empJ = /\s/g; 

//아이디 정규식 
var idJ = /^[a-z][a-z0-9_\-]{4,19}$/;	// 5 ~ 20자의 영문 소문자, 숫자(첫글자는 반드시 영문)만 혼용 가능

//닉네임 정규식 
var nickJ = /^([a-zA-Z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]).{1,10}$/;	// 2 ~ 10자의 영문 대/소문자, 한글, 숫자만 혼용 가능 

//비밀번호 정규식 
var pwJ = /(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$/;	// 숫자, 특수문자 각 1회 이상, 영문 소/대문자 2개 이상 혼용하여 8자리 이상 입력 

//휴대폰 번호 정규식 
var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;

var duplChkId = 0;

var duplChkNick = 0;

var chkPhoneAuth = 0;

var oldPhone;

// ------------------------------------------------------------------------------------------------------

$(document).ready(function() {
	
	$("#btnCancel").click(function() {
		location.href = '/main'
	});
	
 	$("#id").focus();
	
//  -------------------------------------------------------------------------

	$("#id").focus(function(){
		$("#id_check").text(""); 	
	});
	
	$("#id").on("input change", function(){
		
		if( $("#id").val() == "" ) {	//id를 입력하지 않고, id 입력창 포커싱이 풀릴 경우,

			$("#id_check").text("아이디를 입력해주세요."); 
			$("#id_check").css("color", "red");
			
		} else if( idJ.test($("#id").val()) == false ) {	//id 유효성 검사를 통과하지 못했을 경우, 

			$("#id_check").text("아이디는 5 ~ 20자의 영문 소문자, 숫자(첫글자는 반드시 영문)만 혼용 가능합니다."); 
			$("#id_check").css("color", "red"); 

		} else{

			$("#id_check").text("유효한 아이디 입니다."); 
			$("#id_check").css("color", "green"); 	
		}
			
	});

	//id 입력창 포커싱이 풀릴 경우,
	$("#id").blur(function() {
	
		if( $("#id").val() == "" ) {	//id를 입력하지 않고, id 입력창 포커싱이 풀릴 경우,

			$("#id_check").text("아이디를 입력해주세요."); 
			$("#id_check").css("color", "red");
			
		} else if( idJ.test($("#id").val()) == false ) {	//id 유효성 검사를 통과하지 못했을 경우, 

			$("#id_check").text("아이디는 5 ~ 20자의 영문 소문자, 숫자(첫글자는 반드시 영문)만 혼용 가능합니다."); 
			$("#id_check").css("color", "red"); 

		} else {
		
			// Ajax를 사용하여 아이디 중복 확인
			$.ajax({ 
					
				async : true	//비동기식
				, type : "POST"
				, url : "/member/dupl_id" 
				, data: {
					id: $("#id").val()
				} 
				, dataType: "json" 
					
				, success : function(res) {		//사용 가능한 아이디일 경우, 
					console.debug("#Id blur 4")
					
					if(!res.duplChkId) {
						console.debug("#Id blur 4-1")
						
						$("#id_check").text("사용 가능한 아이디 입니다."); 
						$("#id_check").css("color", "green"); 
						duplChkId = 1;
				
					} else {
						console.debug("#Id blur 4-2")
						
						$("#id_check").text("중복된 아이디 입니다."); 
						$("#id_check").css("color", "red"); 
						duplChkId = 0;
						
					}
						
				}//success : function(data) end
	
				, error: function() {
					console.debug("#Id blur 5")
					console.log("AJAX 실패 : duplicate id")
				}
			});//ajax end
			console.debug("#Id blur 6")
		}
	});
	
	// ------------------------------------------------------------------------------------------------------
	
	$("#nick").focus(function(){
		$("#nick_check").text(""); 	
	});
	
	$("#nick").on("input change", function(){
		
		if( $("#nick").val() == "" ) {	//nick를 입력하지 않고, 닉네임 입력창 포커싱이 풀릴 경우,
			
			$("#nick_check").text("닉네임를 입력해주세요."); 
			$("#nick_check").css("color", "red");

		} else if( nickJ.test($("#nick").val()) == false ) {	//nick 유효성 검사를 통과하지 못했을 경우, 

			$("#nick_check").text("닉네임은 2 ~ 10자의 영문 대/소문자, 한글, 숫자만 혼용 가능합니다."); 
			$("#nick_check").css("color", "red"); 

		} else{
			
			$("#nick_check").text("유효한 닉네임 입니다."); 
			$("#nick_check").css("color", "green"); 	
			
		}
	});
	
	//닉네임 입력창 포커싱이 풀릴 경우,
	$("#nick").blur(function() {	
		
		if( $("#nick").val() == "" ) {	//nick를 입력하지 않고, 닉네임 입력창 포커싱이 풀릴 경우,
			
			$("#nick_check").text("닉네임를 입력해주세요."); 
			$("#nick_check").css("color", "red");

		} else if( nickJ.test($("#nick").val()) == false ) {	//nick 유효성 검사를 통과하지 못했을 경우, 

			$("#nick_check").text("닉네임은 2 ~ 10자의 영문 대/소문자, 한글, 숫자만 혼용 가능합니다."); 
			$("#nick_check").css("color", "red"); 

		} else{
			console.debug("#Nick blur 1")
			//Ajax를 사용하여 닉네임 중복확인 
			$.ajax({ 
					
				async : true	//비동기식
				, type : "POST"
				, url : "/member/dupl_nick" 
				, data: {
					nick: $("#nick").val()
				}
				, dataType: "json" 
				
				, success : function(res) {
					console.debug("#Nick blur 2")
		
					if(!res.duplChkNick) {	//사용가능한 닉네임일 경우,
						console.debug("#Nick blur 2-1")
						
						$("#nick_check").text("사용 가능한 닉네임 입니다."); 
						$("#nick_check").css("color", "green"); 
						duplChkNick = 1;
		
					} else {	//중복된 닉네임일 경우,
						console.debug("#Nick blur 2-2")
						
						$("#nick_check").text("중복된 닉네임 입니다."); 
						$("#nick_check").css("color", "red"); 
						duplChkNick = 0;
		
					}
						
				}//success : function(data) end
		
				, error: function() {
					console.debug("#Nick blur 3")
					console.log("AJAX 실패 : duplicate nick")	
				}
			});//ajax end
			console.debug("#Nick blur 4")
		}
	});//$("#nick").blur(function() end

	// ------------------------------------------------------------------------------------------------------

	$("form").on("submit",function() {		//<form>가 submit 될 경우, 유효성 검사를 진행

		var inval_Arr = new Array(8).fill(0);	
		
		//아이디 유효성 검사 진행
		if ( $("#id").val() != "" && idJ.test($("#id").val()) ) { 	//id 유효성 검사를 통과했을 경우,
			
			inval_Arr[0] = 1; 
		
		} else { 
			
			inval_Arr[0] = 0; 
			
			alert("아이디를 확인해주세요."); 
		
			return false; 
		}
		
		//아이디 중복 검사 진행
		if ( duplChkId === 1 ) { 	//검사 통과시,
			
			inval_Arr[1] = 1; 
		
		} else { 
			
			inval_Arr[1] = 0; 
			
			alert("중복된 아이디 입니다."); 
		
			return false; 
		}
		
		
		// 비밀번호 유효성 검사 && 입력된 각각의 비밀번호가 일치하는지 검사 진행 
		if ( ($("#pw").val() == ($("#check_pw").val() ) ) && pwJ.test($("#pw").val()) ) { 

			inval_Arr[2] = 1; 

		} else if ($("#pw").val() == "") {
			
			inval_Arr[2] = 0;
			
			console.log("false"); 
			
			alert("비밀번호를 확인해주세요."); 
			
			$("#pw_check").text("비밀번호를 입력해주세요."); 
			
			$("#pw_check").css("color", "red"); 
			
			return false;
			
		} else { 
		
			inval_Arr[2] = 0; 

			alert("비밀번호를 확인해주세요."); 

			return false; 

		} 

		// 닉네임 유효성 검사 진행
		if (nickJ.test($("#nick").val()) ) { 

			inval_Arr[3] = 1; 

		} else { 
		
			inval_Arr[3] = 0; 
			
			alert("닉네임을 확인해주세요."); 
			
			return false; 
		
		}
		
		//닉네임 중복 검사 진행
		if ( duplChkNick === 1 ) { 	//검사 통과시,
			
			inval_Arr[4] = 1; 
		
		} else { 
			
			inval_Arr[4] = 0; 
			
			alert("중복된 닉네임 입니다."); 
		
			return false; 
		}

		// 전화번호 유효성 검사 진행
		if (phoneJ.test($("#phone").val()) ) { 

			inval_Arr[5] = 1; 

		} else { 

			inval_Arr[5] = 0; 

			alert("휴대폰 번호를 확인해주세요."); 

			return false; 

		}

		//휴대폰 인증이 됐는지 확인
		if(chkPhoneAuth === 0) {	// 0 : 실제 동작, 1 : Test 용도 
			
			inval_Arr[6] = 0; 

			alert("휴대폰 인증을 진행해주세요."); 
		
			return false; 

		}else {
			
			inval_Arr[6] = 1;
		}
		
		//주소가 작성됐는지 확인
		if( $("#addr1").val() == "") { 

			inval_Arr[7] = 0; 

			alert("주소를 확인해주세요."); 
		
			return false; 

		}else inval_Arr[7] = 1; 

		//전체 유효성 검사 
		var validAll = 1; 

		for(var i = 0; i < inval_Arr.length; i++){ 

			if(inval_Arr[i] === 0) { 

				validAll = 0;
	 
			} 

		} 
		
		if(validAll === 1) { 	//유효성 검사 모두 통과 
			
			console.debug("회원가입 성공")
			alert("회원가입을 환영합니다!"); 

			return true; 

		} else { 
			
			console.debug("회원가입 실패")
			alert("입력하신 정보를 다시 확인해주세요.") 
			return false; 
			
		} 

	});//$("form").on("submit",function() end	
			
// ------------------------------------------------------------------------------
	
	//<form>이 submit 되기 전에 유효성 검사를 진행
	
	//패스워드 유효성 검사
	$("#pw").focus(function(){
		$("#pw_check").text(""); 	
	});
	
	$("#pw").on("input change", function(){
		
		if ($("#pw").val() == "") {

			$("#pw_check").text("비밀번호를 입력해주세요."); 
			$("#pw_check").css("color", "red"); 
			
		} else if( pwJ.test($("#pw").val()) == false ){

			$("#pw_check").text("숫자, 특수문자 각 1회 이상, 영문 대/소문자 2개 이상 혼용하여 8자리 이상 입력해주세요."); 
			$("#pw_check").css("color", "red"); 
		
		} else {

			$("#pw_check").text("유효한 비밀번호 입니다."); 
			$("#pw_check").css("color", "green"); 
			
		}
	});	
		
	$("#pw").blur(function() { 
		
		if (pwJ.test($("#pw").val()) ) { 

			$("#pw_check").text("유효한 비밀번호 입니다."); 
			$("#pw_check").css("color", "green"); 
		
		} else if ($("#pw").val() == "") {

			$("#pw_check").text("비밀번호를 입력해주세요."); 
			$("#pw_check").css("color", "red"); 
			
		} else { 

			$("#pw_check").text("숫자, 특수문자 각 1회 이상, 영문 대/소문자 2개 이상 혼용하여 8자리 이상 입력해주세요."); 
			$("#pw_check").css("color", "red"); 

		} 
	}); 
 
// 	-------------------------------------------------------------------------

	$("#check_pw").focus(function(){
		$("#pw_check2").text(""); 			
	});
	
	$("#check_pw").on("input change", function(){
		
		if ($("#pw").val() != $(this).val() ) { 

			$("#pw_check2").text("비밀번호가 일치하지 않습니다."); 
			$("#pw_check2").css("color", "red"); 

		}else { 
			
			$("#pw_check2").text("비밀번호가 일치합니다."); 
			$("#pw_check2").css("color", "green");
			
		} 
	});
	
	$("#check_pw").blur(function() { 
		
		if ($("#pw").val() != $(this).val() ) { 

			$("#pw_check2").text("비밀번호가 일치하지 않습니다."); 
			$("#pw_check2").css("color", "red"); 

		}else { 
			
			$("#pw_check2").text("비밀번호가 일치합니다."); 
			$("#pw_check2").css("color", "green"); 

		}
	}); 

	// 	----------------------------------------------------------------------

	//전화번호 유효성 검사
	$("#phone").focus(function(){
		$("#msg_phone_check").text(""); 	
	});
	
	$("#phone").on("input change", function(){
		
		if( $("#phone").val() != oldPhone ){
			
			$("#msg_send_PhoneAuthNum").text("");
			
			$("#phone_auth").text("");
		
			chkPhoneAuth = 0;
			
			$('#phoneAuthNum').val('');
			$("#btn_send_phone").attr("disabled", false);
			
			$("#msg_chk_member_by_phone").text("");
			
		}
// 		else if( $("#phone").val() == "" ) {	
			
// 			$("#msg_phone_check").text("휴대폰 번호를 입력해주세요."); 
// 			$("#msg_phone_check").css("color", "red");
	
// 		}else if(phoneJ.test($(this).val()) ) { 
	 
// 			$("#msg_phone_check").text("유효한 휴대폰 번호 입니다."); 
// 			$("#msg_email_check").css("color", "green");

// 		} else { 
	
// 			$("#msg_phone_check").text("휴대폰 번호를 확인해주세요."); 
// 			$("#msg_phone_check").css("color", "red"); 
		
// 		} 
	});
	
	$("#phone").blur(function() { 
	
		console.debug("#phone blur 1")

		$.ajax({ 
				
			async : true	//비동기식
			, type : "POST"
			, url : "/member/chk_member_by_phone" 
			, data: {
				phone: $("#phone").val()
			}
			, dataType: "json" 
			
			, success : function(resMap) {
				console.debug("#phone blur 2")

				if(resMap.chkPhone) {	//회원 존재O
					console.debug("#phone blur 2-1")
					
					$("#msg_phone_check").text("해당 휴대폰 번호로 이미 가입된 회원이 존재합니다.");				
					$("#msg_phone_check").css("color", "red");
// 					$("#btn_send_phone").attr("disabled", true);
					
				} else if(!resMap.chkPhone){	//회원 존재X
					
					console.debug("#phone blur 2-2")
					$("#btn_send_phone").attr("disabled", false);
				
				}		
			}//success : function(data) end

			, error: function() {
				console.debug("#phone blur 3")
				console.log("AJAX 실패 : chk_member_by_phone")
			}
		});//ajax end
		console.debug("#phone blur 4")
		
		if( $("#phone").val() == "" ) {	
			
			$("#msg_phone_check").text("휴대폰 번호를 입력해주세요."); 
			$("#msg_phone_check").css("color", "red");
	
		}else if(phoneJ.test($(this).val()) ) { 
	 
			$("#msg_phone_check").text("유효한 휴대폰 번호 입니다."); 
			$("#msg_phone_check").css("color", "green");

		} else { 
	
			$("#msg_phone_check").text("휴대폰 번호를 확인해주세요."); 
			$("#msg_phone_check").css("color", "red"); 
		
		} 
	
	});	
	
	$("#phonAuthNum").on("input change", function(){
		
		$("#phone_auth").text("");
		
	});
	
// 	---------------------------------------------------------------------------

	//휴대폰으로 인증번호 전송
	$("#btn_send_phone").click(function() {
		console.debug("#btn_send_phone click 1")

		$("#phone_auth").text("");
		$("#msg_send_PhoneAuthNum").text("");
		
		if ( phoneJ.test($("#phone").val()) ) { 
			console.debug("#btn_send_phone click 2")

			//Ajax를 사용하여 휴대폰 번호를 전송 -> 서버에서 인증번호 생성	
			$.ajax({
				
				async : true	//비동기식
				, type: "POST"
				, url: "/member/send_phoneAuthNum"
				, data:  {
					phone: $("#phone").val()
				}
				
				, success: function(res) {	
					console.debug("#btn_send_phone click 3")
					
					if(res){
						
						console.debug("#btn_send_phone click 3-1")
						console.log( "Ajax 성공 : send phone" )
						
						$("#msg_send_PhoneAuthNum").text("인증번호 전송 성공"); 
						$("#msg_send_PhoneAuthNum").css("color", "green"); 
						
						oldPhone = $("#phone").val();
						console.debug(oldPhone)
						
						$("#btn_auth_phone").attr("disabled", false);
						$('#phoneAuthNum').val('');
						$("#phone_auth").text(""); 
						
					}else{
						
						console.debug("#btn_send_phone click 3-2")
						console.log("Ajax 실패 : send phone")
						$("#msg_send_PhoneAuthNum").text("인증번호 전송 실패"); 
						$("#msg_send_PhoneAuthNum").css("color", "red"); 
						$("#btn_send_phone").attr("disabled", false);
						
					}
					
				}
				
				, error: function() {
					console.debug("#btn_send_phone click 4")
					console.log( "Ajax 실패 : send phone" )
				}
				
			});
			console.debug("#btn_send_phone click 5")
			
		}else{
			
			$("#msg_phone_check").text("인증번호 전송 실패"); 
			$("#msg_phone_check").css("color", "red");
			
		}

	});
	
// 	---------------------------------------------------------------------------
	
	//휴대폰 인증
	$("#btn_auth_phone").click(function() {
		console.debug("#btn_auth_phone click 1")
		
		//Ajax를 사용하여 인증번호를 전송 -> 서버에서 인증번호 검사
		$.ajax({
			
			async : true	//비동기식
			, type: "POST"
			, url: "/member/auth_phone"
			, data:  {
				phoneAuthNum: $("#phoneAuthNum").val(),
				phone : $("#phone").val()
			}
			
			, success: function( resMap ) {	
				console.debug("#btn_auth_phone click 2")
				console.log( "Ajax 성공 : send phoneAuthKey" )
				
				if (resMap.authChk) { 
					
					console.debug("#btn_auth_phone click 2-1")
					console.log( "휴대폰 인증 성공" )
					
					$("#phone_auth").text("인증 성공"); 
					$("#phone_auth").css("color", "green");
				
					$("#btn_auth_phone").attr("disabled", true);
					
					chkPhoneAuth = '1';
					
					console.debug(resMap.email)
					if(resMap.email != ""){
			
						$("#msg_chk_member_by_phone").text("해당 휴대폰 번호로 가입된 이메일 : resMap.email"); 
						$("#msg_chk_member_by_phone").css("color", "green"); 

					}
					
				} 
				
				else { 
					
					console.debug("#btn_auth_phone click 2-2")
					console.log( "휴대폰 인증 실패" )
					
					$("#phone_auth").text("인증 실패"); 
					$("#phone_auth").css("color", "red");
				
				}
				
			}
		
			, error: function() {
				console.debug("#btn_auth_phone click 3")
				console.log("AJAX 실패 : send phoneAuthKey")
			}
			
		});
		console.debug("#btn_auth_phone click 4")

	});
	
})//$(document).ready(function() end
</script>

<script type="text/javascript">
//우편번호 찾기 버튼 클릭시 발생 이벤트 
function execPostCode() { 

	new daum.Postcode({ 

		oncomplete: function(data) { 
			
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분. 

			// 도로명 주소의 노출 규칙에 따라 주소를 조합한다. 
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다. 
			var fullRoadAddr = data.roadAddress; // 도로명 주소 변수 
			var extraRoadAddr = " "; // 도로명 조합형 주소 변수 

			// 법정동명이 있을 경우 추가한다. (법정리는 제외) 
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다. 
			if(data.bname !== " " && /[동|로|가]$/g.test(data.bname)){ 
			
				extraRoadAddr += data.bname; 
			
			} 

			// 건물명이 있고, 공동주택일 경우 추가한다. 
			if(data.buildingName !== " " && data.apartment === "Y"){ 

				extraRoadAddr += (extraRoadAddr !== " " ? ", " + data.buildingName : data.buildingName); 

			} 

			// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다. 
			if(extraRoadAddr !== " ") { 

				extraRoadAddr = " (" + extraRoadAddr + ")"; 

			} 

			// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다. 
			if(fullRoadAddr !== " ") { 

				fullRoadAddr += extraRoadAddr; 

			} 

			// 우편번호와 주소 정보를 해당 필드에 넣는다. 
			console.log(data.zonecode); 
			console.log(fullRoadAddr); 

			$("[name=addr1]").val(data.zonecode); 
			$("[name=addr2]").val(fullRoadAddr); 

			document.getElementById("addr1").value = data.zonecode; //5자리 새우편번호 사용 
			document.getElementById("addr2").value = fullRoadAddr; 
			
		} 
	
	}).open(); 
}
</script>

<style type="text/css">
#btnJoin, #btnCancel {
	border: 0;
	border-radius: 5px;
	background: #FF792A;
	color: white;
	width: 80px;
	height: 30px;
	font-size: 15px;
}
</style>

<!-- ------------------------------------------------------------- -->

<div class="container">

	<div class="page-header"> 

		<div class="col-md-6 col-md-offset-3"> 
			<h3>소셜회원 회원가입</h3> 
		</div> 
	
	</div> 
		
	<div class="col-sm-6 col-md-offset-3"> 
		<form action="/member/join" method="post" role="form" id="userCheck" name="member"> 
		
			<div class="form-group"> 
				<label for="id">아이디</label> 
				<input type="text" class="form-control" id="id" name="id" placeholder="ID..."> 
				<div class="check_font" id="id_check"></div> 
			</div> 
			
			<div class="form-group"> 
				<label for="pw">비밀번호</label> 
				<input type="password" class="form-control" id="pw" name="pw" placeholder="PASSWORD..."> 
				<div class="check_font" id="pw_check" style="width: 1000px;"></div> 
			</div> 
			
			<div class="form-group"> 
				<label for="check_pw">비밀번호 확인</label> 
				<input type="password" class="form-control" id="check_pw" name="check_pw" placeholder="Confirm Password"> 
				<div class="check_font" id="pw_check2"></div> 
			</div> 
			
			<div class="form-group"> 
				<label for="name">이름</label> 
				<input type="text" class="form-control" id="name" name="name" value="${name}" readonly="readonly"> 
				<div class="check_font" id="name_check"></div> 
			</div>
			
			<div class="form-group"> 
				<label for="nick">닉네임</label> 
				<input type="text" class="form-control" id="nick" name="nick" placeholder="Nick..."> 
				<div class="check_font" id="nick_check"></div> 
			</div>  
			
<!-- 			<div class="form-group">  -->
<!-- 				<label for="birth">생년월일</label>  -->
<!-- 				<input type="tel" class="form-control" id="birth" name="birth" placeholder="Ex) 19990505">  -->
<!-- 				<div class="check_font" id="birth_check"></div>  -->
<!-- 			</div>  -->
			
			<div class="form-group"> 
				<label for="email">이메일</label> 
				<input type="email" class="form-control" id="email" name="email" value="${email}" readonly="readonly"> 
				<div class="check_font" id="msg_email_check"></div> 
			</div> 

			<div class="form-group"> 
				<label for="phone">휴대폰 번호('-'없이 번호만 입력해주세요)</label> 
				<input type="tel" class="form-control" id="phone" name="phone" placeholder="Phone-Number...">
				<div class="check_font" id="msg_phone_check"></div>
			</div> 	
			 
			<div class="form-group">	
				<button type="button" class="form-control" id="btn_send_phone" style="width: 125px;">인증 번호 전송</button>		
				<div class="check_font" id="msg_send_PhoneAuthNum"></div>		
			</div> 
			
			<div class="form-group"> 	
				<label for="phoneAuthNum">휴대폰 인증 번호 입력</label>
				<input type="text" id="phoneAuthNum" name="phoneAuthNum" value=""  class="form-control" style="width: 125px;">
			</div>
	
			<div class="form-group"> 	
				<button type="button" class="btn btn-default" id="btn_auth_phone">인증</button> 
				<div class="check_font" id="phone_auth"></div>
				<div class="check_font" id="msg_chk_member_by_phone"></div>
			</div> 
			
<!-- 			<div class="form-group">  -->
<!-- 				<label for="gender">성별 </label>  -->
<!-- 				<input type="checkbox" id="gender" name="gender" value="남">남  -->
<!-- 				<input type="checkbox" id="gender" name="gender" value="여">여  -->
<!-- 			</div>  -->
			
			<div class="form-group"> 
				<div>
					<label for="addr1">주소</label>
				</div>
	
				<input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="addr1" id="addr1" type="text" readonly="readonly" > 
				<button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button> 
			</div> 
					
			<div class="form-group"> 
				<input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="addr2" id="addr2" type="text" readonly="readonly" /> 
			</div> 
			
			<div class="form-group"> 
				<input class="form-control" placeholder="상세주소" name="addr3" id="addr3" type="text" /> 
			</div> 
			
			<div class="form-group text-center"> 
				<button type="submit" id="btnJoin" name="btnJoin" >회원가입</button>
				<input type="button" id="btnCancel" name="btnCancel" value="취소"/>
			</div> 
				
		</form> 
	</div>

</div><!-- .container end -->

<c:import url="/WEB-INF/views/layout/footer.jsp" />





