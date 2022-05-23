<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
$(document).ready(function() {
	
	$("#btnCancel").click(function() {
		history.go(-1)
	})
	
 	$("#auth").focus();

	$("#auth").blur(function() {
		if( $("#auth").val() == "" ) {	
			
			$("#authNum_check").text("인증번호를 입력해주세요."); 
			$("#authNum_check").css("color", "red");
			
		}
	});
	
	$("#auth").focus(function(){
		$("#authNum_check").text(""); 	
	});
	
	$("#auth").on("input change", function(){
		if( $(this).val() != ""){
			
			$("#authNum_check").text(""); 
			$("#btnAuth").prop("disabled", false);
		
		}else{
			$("#btnAuth").prop("disabled", true);
		}	
	});
		
	
	$("#btnAuth").click(function() {
	   
		var auth = $('#auth').val();

		//Ajax를 사용하여 닉네임 중복확인 
		$.ajax({ 
				
			async : true	//비동기식
			, type : "POST"
			, url : "/member/check_auth_num" 
			, data: {
				auth : auth
			}
			, dataType: "json" 
			
			, success : function(res) {
				console.debug("#btnAuth click 2")
				console.log(res)
			
				if(res) {	
					console.debug("#btnAuth click 2-1")
					
					alert("회원탈퇴 완료!");
					
					location.href="/main" 
					return false;
				
				} else {	
					console.debug("#btnAuth click 2-2")
					
					alert("인증에 실패했습니다.");
					
					return false;
					
				}
				
			}//success : function(data) end

			, error: function() {
				console.debug("#btnAuth click 3")
				
				console.log("AJAX 실패 : auth check");
				alert("인증에 실패했습니다.");
			
			}

		});//ajax end
		console.debug("#btnAuth click 4")

	});
	console.debug("#btnAuth click 5")
	
});
</script>

<style type="text/css">
#btnAuth, #btnCancel {
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

<!-- <form method="post"> -->
	<br><br><br><br><br>
	<div style="width:100%; height:550px;">
       
       <div style="width:470px; margin:0 auto; height:290px; border:2px solid #FF792A;; border-radius:10px;">
       		
       		<h1 style="margin-left: 20px; color:#FF792A;"><b>번호 인증</b></h1>
       		<hr style="height: 2px;border:none; color:#FF792A; background-color:#FF792A;">

			<div class="text-center">
				<br><br>
				<label for="auth" style="margin-bottom: 20px; color:#888;"><b>인증번호 입력</b></label>
				<input type="text" id="auth" name="auth" size=30 style="height:30px; width: 150px; border: 2px solid #ccc; border-radius: 5px;">	
				<div class="check_font" id="authNum_check"></div> 
			</div>
		
			<div class="text-center">
				<br>
				<button type="submit" id="btnAuth" disabled='disabled' style="margin-right: 5px;">확인</button>
				<input type="button" value="취소" onclick="history.go(-1);" id="btnCancel" style="margin-left: 5px;" />
			</div>
		
		</div>
		
	</div>
	
<!-- </form> -->

</div><!-- .container -->

<%@ include file="../layout/footer.jsp" %>