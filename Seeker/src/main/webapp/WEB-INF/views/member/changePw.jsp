<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %>

<script type="text/javascript">

//비밀번호 정규식 
var pwJ = /(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$/;	// 숫자, 특수문자 각 1회 이상, 영문 소/대문자 2개 이상 혼용하여 8자리 이상 입력 

$(document).ready(function() {
	
	function press(f){ 
		if(f.keyCode == 13){ 
			btnChange.submit();
		}
	}
	
	$("#btnCancel").click(function() {
		history.go(-1)
	})
	
 	$("#oldPw").focus();

	$("#btnChange").click(function() {
	   
		if( $("#oldPw").val() == "" ) {	
			
			$("#oldPw").focus();
			
			alert("현재 비밀번호를 입력해주세요.");
		
			return false;

		} else if( pwJ.test($("#oldPw").val()) == false ) {	 
			
			$("#oldPw").focus();
		
			alert("유효하지 않은 비밀번호입니다.");
			
			return false;
			
		} else if( $("#newPw").val() == "" ) {	
			
			$("#newPw").focus();
			
			alert("새 비밀번호를 입력해주세요.");
		
			return false;

		} else if( pwJ.test($("#newPw").val()) == false ) {	
			
			$("#newPw").focus();
		
			alert("유효하지 않은 새 비밀번호 입니다.");
			
			return false;
			
		} else if( $("#newPw").val() != $("#chkNewPw").val() ) {	
			
			$("#chkNewPw").focus();
			
			alert("새 비밀번호가 일치하지 않습니다.");
		
			return false;

		} else {	//변경 버튼이 정상 작동될 경우,
			console.debug("#btnChange click 1")
			
			var oldPw = $('#oldPw').val();
			var newPw = $('#newPw').val();
		
			//Ajax를 사용하여 닉네임 중복확인 
			$.ajax({ 
					
				async : true	//비동기식
				, type : "POST"
				, url : "/member/checkPhone" 
				, data: {
					oldPw : oldPw, 
					newPw : newPw
				}
				, dataType: "json" 
				
				, success : function(res) {
					console.debug("#btnChange click 2")
					console.log(res)
				
					if(res) {	
						console.debug("#btnChange click 2-1")
						
						location.href="/member/authPhoneForChangePw" 
						return false;
					
					} else {	
						console.debug("#btnChange click 2-2")
						
						alert("현재 비밀번호를 다시 확인해주세요");
						return false;
					}
					
				}//success : function(data) end
	
				, error: function() {
					console.debug("#btnChange click 3")
					
					console.log("AJAX 실패 : email check");
					alert("본인 인증에 실패했습니다.");
					return false;
				}
	
			});//ajax end
			console.debug("#btnChange click 4")

		}
		console.debug("#btnChange click 5")

	});
	
});
</script>

<style type="text/css">
#btnChange, #btnCancel {
	border: 0;
	border-radius: 5px;
	background: #FF792A;
	color: white;
	width: 80px;
	height: 30px;
	font-size: 15px;
}
</style>
<br><br><br><br><br><br>
<div class="container">

<form method="post" name="pwFind" onsubmit="return false;">

	<div style="width:100%; height:550px;">
       
       <div style="width:470px; margin:0 auto; height:290px; border:2px solid #FF792A;; border-radius:10px;">
       		
       		<h1 style="margin-left: 20px; color:#FF792A;"><b>비밀번호 변경</b></h1>
       		<hr style="height: 2px;border:none; color:#FF792A; background-color:#FF792A;">
       	
       		<div class="text-center">
				<label for="oldPw" style="margin-bottom: 20px; color:#888;"><b>현재 비밀번호</b></label>		
				<input type="password" id="oldPw" name="oldPw" size=30 style="height:30px; border: 2px solid #ccc; border-radius: 5px;">		
				<div class="check_font" id="oldPw_check"></div>
			</div>
		
			<div class="text-center">
				<label for="newPw" style="margin-left: 50px; margin-bottom: 20px; color:#888;"><b>새 비밀번호</b></label>
				<input type="password" id="newPw" name="newPw" size=30 style="margin-right: 35px; height:30px; border: 2px solid #ccc; border-radius: 5px;">	
				<div class="check_font" id="newPw_check"></div>
			</div>
			
			<div class="text-center">
				<label for="chkNewPw" style="margin-bottom: 20px; color:#888;"><b>새 비밀번호 확인</b></label>
				<input type="password" id="chkNewPw" name="chkNewPw" size=30 style="margin-right: 18px; height:30px; border: 2px solid #ccc; border-radius: 5px;">	
				<div class="check_font" id="chkNewPw_check"></div>
			</div>
			
			<!-- type="email" -> required="/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)?$/i" -->
			
			<div class="text-center">
		
				<button type="button" id="btnChange" style="margin-right: 5px;">변경</button>
	
				<input type="button" value="취소" onclick="history.go(-1);" id="btnCancel" style="margin-left: 5px;" />
			
			</div>
		
		</div>
	
	</div>
	
</form>
	
</div><!-- .container -->

<%@ include file="../layout/footer.jsp" %>


