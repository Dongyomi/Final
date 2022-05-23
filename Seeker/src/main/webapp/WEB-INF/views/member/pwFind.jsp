<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %>

<script type="text/javascript">
//아이디 정규식 
var idJ = /^[a-z][a-z0-9_\-]{4,19}$/;	// 5 ~ 20자의 영문 소문자, 숫자(첫글자는 반드시 영문)만 혼용 가능

//이메일 검사 정규식
var emailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; 

$(document).ready(function() {
	
	function press(f){ 
		if(f.keyCode == 13){ 
			authBtn.submit(); 
		}
	}
	
	$("#btnCancel").click(function() {
		history.go(-1)
	})
	
	$("#id").focus();
	
// 	---------------------------------------------

	$("#id").on("input change", function(){
		$("#btnFind").attr("disabled", true);

		if( $("#id").val() == "" ) {
		
			$("#id_check").text("아이디를 입력해주세요."); 
			$("#id_check").css("color", "red");

		}else if( idJ.test($("#id").val()) == false ) {	 
			
			$("#id_check").text("유효하지 않은 아이디 입니다."); 
			$("#id_check").css("color", "red"); 

		}else {
			
			$("#id_check").text("유효한 아이디 입니다."); 
			$("#id_check").css("color", "green"); 
			
			if(emailJ.test($("#email").val())){
				$("#btnFind").attr("disabled", false);
			}
		}
			
	});
	
	$("#email").on("input change", function(){
		$("#btnFind").attr("disabled", true);

		if( $("#email").val() == "" ) {	
			
			$("#email_check").text("이메일을 입력해주세요."); 
			$("#email_check").css("color", "red");

		}else if( emailJ.test($("#email").val()) == false ) {	 
			
			$("#email_check").text("유효하지 않은 이메일 입니다."); 
			$("#email_check").css("color", "red"); 

		}else {
			
			$("#email_check").text("유효한 이메일 입니다."); 
			$("#email_check").css("color", "green"); 
			
			if(idJ.test($("#id").val())){
				$("#btnFind").attr("disabled", false);
			}

		}
		
	});
	
	$("#id").blur(function() { 
		
		if ($("#id").val() == "") {

			$("#id_check").text("아이디를 입력해주세요."); 
			$("#id_check").css("color", "red"); 
			
			$("#btnFind").attr("disabled", true);
		
		}else if (idJ.test($("#id").val()) ) { 

			$("#btnFind").attr("disabled", false);
		
		} else { 

			$("#id_check").text("유효하지 않은 아이디 입니다."); 
			$("#id_check").css("color", "red"); 

			$("#btnFind").attr("disabled", true);
			
		} 

	}); 
 
	$("#email").blur(function() { 
		
		if ($("#email").val() == "") {

			$("#email_check").text("이메일을 입력해주세요."); 
			$("#email_check").css("color", "red"); 
			
			$("#btnFind").attr("disabled", true);
		
		}else if (emailJ.test($("#email").val()) ) { 

			$("#btnFind").attr("disabled", false);
		
		} else { 

			$("#email_check").text("유효하지 않은 이메일 입니다."); 
			$("#email_check").css("color", "red"); 

			$("#btnFind").attr("disabled", true);
			
		} 
		
	}); 
	
	$("#btnFind").click(function() {
		console.debug("#btnFind click 1")

		var id = $('#id').val();
		var email = $('#email').val();
			
		$.ajax({ 	
			async : true	//비동기식
			, type : "POST"
			, url : "/member/send_pwAuthNum" 
			, data: {
				id : id, 
				email : email
			}
			, dataType: "json" 
			
			, success : function(res) {
				console.debug("#btnFind click 2")
				console.log(res)
				
				if(res) {	
					
					console.debug("#btnFind click 2-1")
					alert("인증번호 전송에 성공했습니다.");
					location.href="/member/authPw" 
					return false;
				
				} else {	
					
					console.debug("#btnFind click 2-2")
					alert("등록된 회원이 아닙니다.");
					return false;
					
				}
	
			}//success : function(data) end

			, error: function() {
				
				console.debug("#btnAuth click 3")
				console.log("AJAX 실패 : authNum check");
				alert("인증에 실패했습니다.");	
				return false;
				
			}

		});//ajax end
		console.debug("#btnAuth click 4")
		
	});
	console.debug("#btnAuth click 5")
		
	
	
});
</script>

<style type="text/css">
#btnFind, #btnCancel {
	border: 0;
	border-radius: 5px;
	background: #FF792A;
	color: white;
	width: 80px;
	height: 30px;
	font-size: 15px;
}
</style>

<div class="container">

<br><br><br><br><br><br>

<form action="/member/pwFind" method="post" id="pwFind" name="pwFind" onsubmit="return false;">

	<div style="width:100%; height:550px;">
       
       <div style="width:470px; margin:0 auto; height:290px; border:2px solid #FF792A;; border-radius:10px;">
       		
       		<h1 style="margin-left: 20px; color:#FF792A;"><b>비밀번호 찾기</b></h1>
       		<hr style="height: 2px;border:none; color:#FF792A; background-color:#FF792A;">
       	
       		<div class="text-center">
				<br>
				<label for="id" style="margin-bottom: 5px; color:#888;"><b>아이디 입력</b></label>		
				<input type="text" id="id" name="id" size=30 style="height:30px; border: 2px solid #ccc; border-radius: 5px;">		
				<div class="check_font" id="id_check" style="margin-right:-10px;"></div>
			</div>
		
			<div class="text-center">
				<label for="email" style="margin-bottom: 5px; color:#888;"><b>이메일 입력</b></label>
				<input type="text" id="email" name="email" type="email" size=30 style="height:30px; border: 2px solid #ccc; border-radius: 5px;">	
				<div class="check_font" id="email_check" style="margin-right:-10px;"></div>
			</div>
		
			<!-- type="email" -> required="/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)?$/i" -->
			
			<div class="text-center">
				
				<button type="submit" id="btnFind" name="btnFind" disabled="disabled" style="margin-right: 5px;">찾기</button>
				<input type="button" id="btnCancel" name="btnCancel" value="취소" onclick="history.go(-1);" style="margin-left: 5px;" />
			</div>
		
		</div>
	
	</div>
	
</form>
	
</div><!-- .container -->

<%@ include file="../layout/footer.jsp" %>


