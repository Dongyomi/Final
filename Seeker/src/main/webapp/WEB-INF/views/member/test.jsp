<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp" %>

<style>
#container {
	width: 95%;
	height: 95%;
	margin: 0px auto;
	padding: 10px;
	border: 1px solid #bcbcbc;
}

#content {
	width: 900px;
	height: 95%;
	padding: 5px;
	margin-bottom: 5px;
	float: right;
	border: 1px solid #bcbcbc;
}

#sidebar {
  width: 200px;
  height: 95%;
  padding: 20px;
  margin-bottom: 5px;
  float: reft;
  border: 1px solid #bcbcbc;
}

</style>

<div id="container">
      
	<div id="content">
		
		<h3>내정보 보여주기</h3>
		
	</div><!-- <div id="content"> -->
	
<!-- 	------------------------------------------------------------ -->

	<div id="sidebar">
		<h2>카테고리</h2>
		<br>
		<ul>
			<li>
				<a href="/member/changeInfo">회원정보수정</a>
			</li>
			<br>
			<li>
				<a href="/member/changePw">비밀번호변경</a>
			</li>
			<br>
			<li>
				<a href="/member/delete">회원탈퇴</a>
			</li>
		</ul>
	</div>

   

</div><!-- <div id="container"> -->

<%@ include file="../layout/footer.jsp" %>

