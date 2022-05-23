<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style type="text/css">

#footer {
	display : inline-flex;
	width : 1200px;
	height : 30px;
	margin : 30px auto;
	border-top : 2px solid black;
}

#footer > div {
	width : 300px;
	height : 25px;
	text-align : center;
}

#footer a {
	color : black;
}

#footer a:hover{
	text-decoration-line : none;
	color : black;
}

#footer-copy-box {
	text-align : right;
}

</style>

	<div id="wrap-box-bottom">
	</div>
</div>
<footer id="footer">
	<div><a href="" ><span class="header-menu-text-xs">이용약관</span></a></div>
	<div><a href="" ><span class="header-menu-text-xs">개인정보처리방침</span></a></div>
	<div>
		<a href="/chat/room11" ><span class="header-menu-text-xs">1:1 문의 채팅</span></a>
	</div>
	<div>
		<a href="/videoChat/sender" ><span class="header-menu-text-xs">영상 통화</span></a>
	</div>
	<div>
		<a href="/admin/index" ><span class="header-menu-text-xs">관리자</span></a>
	</div>
	<div><div id="footer-copy-box"><small>Copyright &copy; 식물키우조 :)</small></div></div>
</footer>
</body>

<script type="text/javascript">
	
	const $box = document.getElementById('hidden-menu-box');
	const board = document.getElementById('menu-board');
	const $board = document.getElementById('hidden-menu-board');
	const garden = document.getElementById('menu-garden');
	const $garden = document.getElementById('hidden-menu-garden');
	
	board.onmouseover = function() {
			
		board.style.color = 'black';
		$board.style.display = "block";
		
	}
	
	$board.onmouseover = function() {
		
		board.style.color = 'black';
		$board.style.display = "block";
		
	}
	
	$board.onmouseout = function() {
		
		board.style.color = '';
		$board.style.display = "none";
		
	}
	
	garden.onmouseover = function() {
		
		garden.style.color = 'black';
		$garden.style.display = "block";
		
	}
		
	$garden.onmouseover = function() {
		
		garden.style.color = 'black';
		$garden.style.display = "block";
		
	}
	
	$garden.onmouseout = function() {
		
		garden.style.color = '';
		$garden.style.display = "none";
		
	}
	
</script>

</html>
