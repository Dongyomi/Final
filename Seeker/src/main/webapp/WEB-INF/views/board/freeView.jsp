<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/header2.jsp" />

<script type="text/javascript">
$(document).ready(function() {
 
	
	$("#btnRecommend").click(function() {
		
		$.ajax({
			type: "get"
			, url: "/board/freeRecommend"
			, data: { "boardno": '${viewBoard.boardno }' }
			, dataType: "json"
			, success: function( data ) {
					console.log("성공");
					console.log(data);
	
				if( data.result === true ) { //추천 성공
					$("#heart").attr('src', '/resources/img/full_heart.png');
// 					.removeClass("btn-primary")
// 					.addClass("btn-warning")
// 					.html('추천 취소');
				
				} else { //추천 취소 성공
					$("#heart").attr('src', '/resources/img/empty_heart.png');
// 					removeClass("btn-primary")
// 					.addClass("btn-warning")
// 					.html('추천 취소');
				
				}
				
				//추천수 적용
				$("#recommend").html(data.cnt);
			}
			, error: function() {
				console.log("실패");
			}
		}); //ajax end
		
	}); //$("#btnRecommend").click() end
});
</script>

<script type="text/javascript">
$(document).ready(function() {
	$("#btnList").click(function() {
		location.href = "/board/freeList"
	})
	
	$("#btnUpdate").click(function() {
		location.href = "/board/freeUpdate?boardno=${viewBoard.boardno}"
	})
	
	$("#btnDelete").click(function() {
		location.href = "/board/freeDelete?boardno=${viewBoard.boardno}"
	})
})

</script>

<script type="text/javascript">

$(document).ready(function() {



	// 댓글 입력
	$("#btnCommInsert").click(function() {
		
		
		$form = $("<form>").attr({
			action: "/reply/insert",
			method: "post"
		}).append(
			$("<input>").attr({
				type:"hidden",
				name:"boardno",
				value:"${viewBoard.boardno }"
			})
		).append(
			$("<textarea>")
				.attr("name", "content")
				.css("display", "none")
				.text($("#content").val())
		
	);
		
		
		
		$(document.body).append($form);
		$form.submit();
		
	}); //$("#btnCommInsert").click() end
});

function deleteReply(replyno) {
	$.ajax({
		type: "post"
		, url: "/reply/delete"
		, dataType: "json"
		, data: {
			replyno: replyno
		}
		, success: function(data){
		
			if(data.success) {	
				$("[data-replyno='"+replyno+"']").remove();	
			} else {
				alert("댓글 삭제 실패");
			}			
		}
		, error: function() {
			console.log("error");
		}
	});
}
</script>



<div class="container">

<div id="wrap-box-top">
	<div><a href="/board/freeList"><span class="glyphicon glyphicon-arrow-left"></span>&nbsp;이전 페이지</a></div>
	<div id="title-box">자유게시판</div>
	<div></div>
</div>


<span class="title"><h1>${viewBoard.btitle }</h1></span>

	<span><img width="20" src="/resources/img/flower.jpg"> ${viewBoard.nick } </span> <span></span><fmt:formatDate value="${viewBoard.bdate }" pattern="yyyy-MM-dd hh:mm:ss "/></span>

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<span type="button" id="btnRecommend">
	   	<img src="${ isRecommend == true ? '/resources/img/full_heart.png' : '/resources/img/empty_heart.png' }" 
	         id="heart" height="50px" width="50px">&nbsp;&nbsp;<span id="recommend">${cntRecommend }</span></span>
<hr>

<div class="content" >${viewBoard.bcontent }</div>


		
<hr>
<br><br>

<a href="/board/freeDownload?fileNo=${boardFile.fileNo }">${boardFile.originName }</a>

<div class="text-center">
	<button id="btnList" class="btn btn-default">목록</button>
	
	<c:if test="${id eq viewBoard.id }">
		<button id="btnUpdate" class="btn btn-primary">수정</button>
		<button id="btnDelete" class="btn btn-danger">삭제</button>
	</c:if>
</div>

<!-- 댓글 처리 -->
<hr>
<div>
	<!-- 비로그인상태 -->
	<c:if test="${not login }">
	<strong>로그인이 필요합니다</strong><br>
	<button onclick='location.href="/member/login";'>로그인</button>
	<button onclick='location.href="/member/join";'>회원가입</button>
	</c:if>
	
	<!-- 로그인상태 -->
	<c:if test="${login }">
	<!-- 댓글 입력 -->
	<div class="form-inline text-center">
		<input type="text" size="10" class="form-control" id="id" value="${nick }" readonly="readonly"/>
		<textarea rows="2" cols="60" class="form-control" id="content"></textarea>
		<button id="btnCommInsert" class="btn">입력</button>
	</div>	<!-- 댓글 입력 end -->
	</c:if>
	
	<!-- 댓글 리스트 -->
	<table class="table table-striped table-hover table-condensed">
	<thead>
	<tr>
		
		<th style="width: 10%;">작성자</th>
		<th style="width: 50%;">댓글</th>
		<th style="width: 20%;">작성일</th>
		<th style="width: 5%;"></th>
	</tr>
	</thead>
	<tbody id="commentBody">
	<c:forEach items="${replyList }" var="reply">
	<tr data-replyno="${reply.replyno }">
		
		<td style="width: 10%;">${reply.nick }</td>
		<td style="width: 40%;">${reply.content }</td>
		<td style="width: 10%;"><fmt:formatDate value="${viewBoard.bdate }" pattern="yyyy-MM-dd "/></td>
		<td style="width: 5%;"><button class="btn btn-default btn-xs">댓글</button></td>
		<td style="width: 5%;">
			<c:if test="${sessionScope.id eq reply.id }">
			<button class="btn btn-default btn-xs"
				onclick="deleteReply(${reply.replyno });">삭제</button>
			</c:if>
		</td> 
		
	</tr>
	</c:forEach>
	</table>	<!-- 댓글 리스트 end -->

</div>	<!-- 댓글 처리 end -->


</div><!-- .container end --> 

<c:import url="/WEB-INF/views/layout/footer2.jsp" />

