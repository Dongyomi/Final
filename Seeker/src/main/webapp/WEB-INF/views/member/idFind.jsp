<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %>

<script type="text/javascript">

//이메일 검사 정규식
var emailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; 

$(document).ready(function() {
	
	function press(f){ 
		if(f.keyCode == 13){ 
			btnFind.submit();
		}
	}
	
	$("#btnCancel").click(function() {
		history.go(-1)
	})
	
 	$("#email").focus();
	
// 	-------------------------------------------
	
	$("#email").focus(function(){
		$("#email_check").text(""); 	
	});
	
	$("#email").on("input change", function(){
		if( $(this).val() != ""){
			
			$("#email_check").text(""); 
			$("#btnFind").prop("disabled", false);
		
		}else{
			$("#btnFind").prop("disabled", true);
		}	
	});
	
	$("#email").blur(function() {
		if( $("#email").val() == "" ) {	
	
			$("#email_check").text("이메일을 입력해주세요."); 
			$("#email_check").css("color", "red");
		
		}else if(emailJ.test($("#email").val()) == false ) {	 
			
			$("#email_check").text("유효한 이메일이 아닙니다."); 
			$("#email_check").css("color", "red"); 
			$("#btnFind").prop("disabled", true);

		}else{
			$("#btnFind").prop("disabled", false);
		}
	});
	
	$("#btnFind").click(function() {
		console.debug("#btnFind click 1")

		$.ajax({ 
			async : true	//비동기식
			, type : "POST"
			, url : "/member/send_idAuthNum" 
			, data: {
				email: $("#email").val()
			}
			, dataType: "json" 
			
			, success : function(res) {
				console.debug("#btnFind click 2")
				console.log(res)
				
				if(res) {	
					
					console.debug("#btnFind click 2-1")
					alert("인증번호 전송에 성공했습니다.");
					location.href="/member/authId" 
					return false;
					
				} else {
					
					console.debug("#btnFind click 2-2")
					alert("등록된 회원이 아닙니다.");
					return false; 
					
				}
	
			}//success : function(data) end

			, error: function() {
				
				console.debug("#btnFind click 3")
				console.log("AJAX 실패 : authNum check");
				alert("인증에 실패했습니다.");	
				
			}
			
		});//ajax end
		console.debug("#btnFind click 4")

	});
	console.debug("#btnFind click 5")
	
});//$(document).ready(function() { end
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

<br><br><br><br><br><br>

<div class="container">

<form action="/member/idFind" method="post" id="idFind" name="idFind" onsubmit="return false;">

	<div style="width:100%; height:550px;">
       
       <div style="width:470px; margin:0 auto; height:290px; border:2px solid #FF792A;; border-radius:10px;">
       		
       		<h1 style="margin-left: 20px; color:#FF792A;"><b>아이디 찾기</b></h1>
       		<hr style="height: 2px;border:none; color:#FF792A; background-color:#FF792A;">

			<div class="text-center">
				<br><br>
				<label for="email" style="margin-bottom: 5px; color:#888;"><b>이메일 입력</b></label>
				<input type="text" id="email" name="email" type="email" size="30" style="height:30px; border: 2px solid #ccc; border-radius: 5px;">	
				<div class="check_font" id="email_check" style="margin-right:15px;"></div>
			</div>
		
			<!-- type="email" -> required="/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)?$/i" -->
			
			<div class="text-center">
				<br>
				<button type="submit" id="btnFind" name="btnFind" disabled='disabled' style="margin-right: 5px;">찾기</button>
				<input type="button" id="btnCancel" name="btnCancel" value="취소" onclick="history.go(-1);" style="margin-left: 5px;" />
			</div>
		
		</div>
		
	</div>
	
</form>
	
</div><!-- .container -->

<%@ include file="../layout/footer.jsp" %>
