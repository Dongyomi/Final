<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
$(document).ready(function() {
	
	function press(f){ 
		if(f.keyCode == 13){ 
			authBtn.submit(); 
		}
	}
	
	$("#btnCancel").click(function() {
		history.go(-1)
	})
	
	$("#authNum").focus();
	
// 	---------------------------------------------

	$("#authNum").focus(function(){
		$("#authNum_check").text(""); 	
	});
	
	$("#authNum").on("input change", function(){
		if( $(this).val() != ""){
			
			$("#authNum_check").text(""); 
			$("#btnAuth").prop("disabled", false);
		
		}else{
			$("#btnAuth").prop("disabled", true);
		}	
	});

	$("#authNum").blur(function() {
		if( $("#authNum").val() == "" ) {	
			
			$("#authNum_check").text("인증번호를 입력해주세요."); 
			$("#authNum_check").css("color", "red");
			
		}
	});
		
	$("#btnAuth").click(function() {
		console.debug("#btnAuth click 1")

		$.ajax({ 	
			async : true	//비동기식
			, type : "POST"
			, url : "/member/chk_pwAuthNum" 
			, data: {
				authNum: $("#authNum").val()
			}
			, dataType: "json" 
			
			, success : function(res) {
				console.debug("#btnAuth click 2")
				console.log(res)
				
				if(res) {	
					
					console.debug("#btnAuth click 2-1")
					location.href="/member/setNewPw" 
					return false;
					
				} else {	
					
					console.debug("#btnAuth click 2-2")
					alert("인증에 실패했습니다.");
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

<form action="/member/authPw" method="post" id="pwFind" name="pwFind" onsubmit="return false;">

	<br><br><br><br><br>
	<div style="width:100%; height:550px;">
       
       <div style="width:470px; margin:0 auto; height:290px; border:2px solid #FF792A;; border-radius:10px;">
       		
       		<h1 style="margin-left: 20px; color:#FF792A;"><b>번호 인증</b></h1>
       		<hr style="height: 2px;border:none; color:#FF792A; background-color:#FF792A;">

			<div class="text-center">
				<br><br>
				<label for="authNum" style="margin-bottom: 20px; color:#888;"><b>인증번호 입력</b></label>
				<input type="text" id="authNum" name="authNum" style="height:30px; width: 150px; border: 2px solid #ccc; border-radius: 5px;">	
				<div class="check_font" id="authNum_check"></div> 
			</div>
		
			<div class="text-center">
				<br>
				<button type="submit" id="btnAuth" name="btnAuth" disabled='disabled' style="margin-right: 5px;">확인</button>
				<input type="button" id="btnCancel" name="btnCancel" value="취소" onclick="history.go(-1);" style="margin-left: 5px;" />
			</div>
		
		</div>
		
	</div>
	
</form>

</div><!-- .container -->

<%@ include file="../layout/footer.jsp" %>