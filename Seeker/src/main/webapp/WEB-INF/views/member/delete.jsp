<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %>

<script type="text/javascript">

var pwJ = /(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$/;	// 숫자, 특수문자 각 1회 이상, 영문 소/대문자 2개 이상 혼용하여 8자리 이상 입력 

$(document).ready(function() {

	$("#btnDelete").click(function() {
		
		if( $("#pw").val() == "" ) {	
			
			$("#pw").focus();
			
			alert("현재 비밀번호를 입력해주세요.");
		
			return false;

		} else if( pwJ.test($("#pw").val()) == false ) {	 
			
			$("#pw").focus();
		
			alert("유효하지 않은 비밀번호입니다.");
			
			return false;
			
		} else if( $("#chkPw").val() == "" ) {	
			
			$("#chkPw").focus();
			
			alert("현재 비밀번호를 한번 더 입력해주세요.");
		
			return false;

		} else if( pwJ.test($("#chkPw").val()) == false ) {	
			
			$("#chkPw").focus();
		
			alert("다시 입력하신 비밀번호가 유효하지 않습니다.");
			
			return false;
			
		} else if( $("#pw").val() != $("#chkPw").val() ) {	
			
			$("#pw").focus();
			
			alert("비밀번호가 일치하지 않습니다.");
		
			return false;

		} else {
			
			console.debug("#delete click 1")
	
			var pw = $('#pw').val();
			var chkPw = $('#chkPw').val();
			
			$.ajax({
				
				async : true	//비동기식
				,type : "POST"
				,url: "/member/deleteMember"
				,data : { 
					pw : pw, 
					chkPw : chkPw
				}
				,dataType: "json"		
				
				,success: function(data) {
					console.debug("#delete click 2")
					console.debug("data", data)
					
					if(data){
						console.debug("#delete click 2-1")
						location.href = '/member/authPhoneForDelete';
					   	
					}else{
						console.debug("#delete click 2-2")
						alert('비밀번호가 틀립니다.');

					}
					
		      	}
				
				, error: function() {
					console.debug("#delete click 3")
					console.log("AJAX 실패 : login")
				}
		  	});//ajax end
			console.debug("#delete click 4")	
		}	
	})//$("#btnLogin").click(function() end
			
	$("#btnCancel").click(function() {
		history.go(-1)
	})
	
 	$("#pw").focus();

});
</script>

<div class="container">

<form method="post" id="deleteForm" name="deleteForm" onsubmit="return false;">
                      
<input type="hidden" id="id" name="id" value="<%=(String)session.getAttribute("id")%>">

	<div class="col-sm-8 col-sm-offset-2">
		
		<div class="panel panel-default panel-margin-10">
			
			<div class="panel-body panel-body-content text-center">
				
				<p class="lead">본인 확인을 위해 비밀번호를 입력해주세요.</p>
			
				<div class="form-group">
					<input type="password" id = "pw" name="pw" class="text-center" placeholder="PASSWORD..." style="width:300px;"/>
				</div>
				
				<div class="form-group">
					<input type="password" id="chkPw" name="chkPw"  class="text-center" placeholder="PASSWORD CHECK..." style="width:300px;"/>
				</div>
	
				<button type="button" id="btnDelete" name="btnDelete" class="btn btn-primary">회원탈퇴</button>
				<input type="button" value="취소" class="btn btn-default" onclick="history.go(-1);" id="btnCancel" />
			
			</div>

		</div>
	
	</div>

</form>

</div><!-- .container -->

<%@ include file="../layout/footer.jsp" %>