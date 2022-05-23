<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
$(document).ready(function() {
	
	
	
});
</script>

<style type="text/css">
#goLogin {
	border: 0;
	border-radius: 5px;
	background: #FF792A;
	color: white;
	width: 125px;
	height: 30px;
	font-size: 15px;
}
</style>

<div class="container">

<div class="form-group text-center"> 
	<h2>회원님의 아이디는 <%=(String)session.getAttribute("id")%> 입니다.</h2>
</div>

<div class="form-group text-center"> 
	<button type="submit" id="goLogin" onclick="location.href='<%=request.getContextPath() %>/member/login'">로그인 화면으로</button> 
</div> 

</div><!-- .container end -->

<c:import url="/WEB-INF/views/layout/footer.jsp" />