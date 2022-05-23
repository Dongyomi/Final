<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
//비밀번호 정규식 
var pwJ = /(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$/;	// 숫자, 특수문자 각 1회 이상, 영문 소/대문자 2개 이상 혼용하여 8자리 이상 입력 
</script>

<script type="text/javascript">
$(document).ready(function() {
	
	function press(f){ 
		if(f.keyCode == 13){ 
			btnFind.submit();
		}
	}
	
	$("#btnCancel").click(function() {
		history.go(-1)
	})
	
	$("#newPw").focus();
	
// 	------------------------------------------------------

	$("#newPw").on("input change", function(){
		
		$("#btnSetPw").attr("disabled", true);

		if( $("#newPw").val() == "" ) {
		
			$("#msg_newPw").text("비밀번호를 입력해주세요."); 
			$("#msg_newPw").css("color", "red");

		}else if( pwJ.test($("#newPw").val()) == false ) {	 
			
			$("#msg_newPw").text("유효하지 않은 비밀번호 입니다."); 
			$("#msg_newPw").css("color", "red"); 

		}else {
			
			$("#msg_newPw").text("유효한 비밀번호 입니다."); 
			$("#msg_newPw").css("color", "green"); 
			
			if(pwJ.test($("#chkPw").val()) && $("#newPw").val() == $("#chkPw").val() ){
				$("#btnSetPw").attr("disabled", false);
			}
		}
			
	});
	
	$("#chkPw").on("input change", function(){
		
		$("#btnSetPw").attr("disabled", true);

		if ($("#newPw").val() != $(this).val() ) { 

			$("#msg_chkPw").text("비밀번호가 일치하지 않습니다."); 
			$("#msg_chkPw").css("color", "red"); 
		
		}else if ($("#newPw").val() == $(this).val() ){ 
			
			$("#msg_chkPw").text("비밀번호가 일치합니다."); 
			$("#msg_chkPw").css("color", "green");
			
			$("#btnSetPw").attr("disabled", false);
		
		} 
	});
		
	$("#newPw").blur(function() { 
		
		if( $("#newPw").val() == "" ) {
			
			$("#msg_newPw").text("비밀번호를 입력해주세요."); 
			$("#msg_newPw").css("color", "red");
			$("#btnSetPw").attr("disabled", true);

		}else if( pwJ.test($("#newPw").val()) ) {	 
			
			$("#btnSetPw").attr("disabled", false);

		}else {
			
			$("#msg_newPw").text("유효하지 않은 비밀번호 입니다."); 
			$("#msg_newPw").css("color", "red"); 
			$("#btnSetPw").attr("disabled", true);

		}
	});
		
	$("#chkPw").blur(function() { 
		
		if ($("#newPw").val() != $(this).val() ) { 

			$("#msg_chkPw").text("비밀번호가 일치하지 않습니다."); 
			$("#msg_chkPw").css("color", "red"); 
			$("#btnSetPw").attr("disabled", true);

		}else if ($("#newPw").val() == $(this).val() ){ 
			
			$("#msg_chkPw").text("비밀번호가 일치합니다."); 
			$("#msg_chkPw").css("color", "green");
			$("#btnSetPw").attr("disabled", false);
		
		} 
	});
		
	$("#btnSetPw").click(function() {
		console.debug("#btnSetPw click 1")

		if($("#newPw").val() == $("#chkPw").val()){
			console.debug("#btnSetPw click 2")

			$("#btnSetPw").attr("disabled", false);

			$.ajax({ 
				async : true	//비동기식
				, type : "POST"
				, url : "/member/chk_pwChange" 
				, data: {
					newPw : $("#newPw").val(),
					chkPw : $("#chkPw").val()
				}
				, dataType: "json" 
				
				, success : function(res) {
					console.debug("#btnSetPw click 3")
					console.log(res)
					
					if(res) {	
						
						console.debug("#btnSetPw click 3-1")
						
						alert("비밀번호 변경에 성공했습니다.");
						location.href="/member/login" 
						return false;
						
					} else {
						
						console.debug("#btnSetPw click 3-2")
						alert("비밀번호 변경에 실패했습니다.");
						return false; 
						
					}
		
				}//success : function(data) end

				, error: function() {
					
					console.debug("#btnSetPw click 4")
					console.log("AJAX 실패 : set NewPw");
					alert("비밀번호 변경에 실패했습니다.");
					
				}
				
			});//ajax end
			console.debug("#btnSetPw click 5")
			
		}
		
	});
	console.debug("#btnSetPw click 6")
	
})
</script>

<style type="text/css">
#btnSetPw, #btnCancel {
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
<br><br><br><br><br>
<form id="form" action="/member/setNewPw" method="post" onsubmit="return false;">

	<div style="width:100%; height:550px;">
       
       <div style="width:470px; margin:0 auto; height:290px; border:2px solid #FF792A;; border-radius:10px;">
       		
       		<h1 style="margin-left: 20px; color:#FF792A;"><b>비밀번호 변경</b></h1>
       		<hr style="height: 2px;border:none; color:#FF792A; background-color:#FF792A;">

			<div class="text-center">
				<br>
				<label for="newPw" style="margin-bottom: 20px; color:#888;"><b>새 비밀번호 입력</b></label>
				<input type="password" id="newPw" name="newPw" size=30 style="height:30px; border: 2px solid #ccc; border-radius: 5px;">	
				<div class="check_font" id="msg_newPw"></div>
			</div>
			
			<div class="text-center">
				<label for="chkPw" style="margin-bottom: 20px; color:#888;"><b>비밀번호 확인</b></label>
				<input type="password" id="chkPw" name="chkPw" size=30 style="height:30px; border: 2px solid #ccc; border-radius: 5px;">	
				<div class="check_font" id="msg_chkPw"></div>	
			</div>
		
		
			<!-- type="email" -> required="/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)?$/i" -->
			
			<div class="text-center">
				<button id="btnSetPw" disabled="disabled" style="margin-right: 5px;">변경</button>
				<input type="button" value="취소" onclick="history.go(-1);" id="btnCancel" style="margin-left: 5px;" />
			</div>
		
		</div>
		
	</div>
	
	<input type="hidden" id="id" name="id"/>
	
</form>

</div><!-- .container end -->

<c:import url="/WEB-INF/views/layout/footer.jsp" />
