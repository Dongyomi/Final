<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">

<!-- SOCKJS -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.0/sockjs.min.js"></script>
<!-- STOMP -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
*{
 	font-family :'Do Hyeon', sans-serif; 
 	font-size : 18px;
}

body {
	width : 1200px;
	margin : auto;
}

#header {
	width : 1200px;
	height :130px;
}

#header d{
	height : 100px;
}

#header-box {
	display : inline-flex;
	width : 1200px;
	margin : 0px 0px 0px 0px;
	border-bottom : 2px solid black;
}

#header-logo-box {
	display : inline-flex;
}

.header-lmg-box {
	width : 70px;
	height : 90px;
	padding : 40px 0px 10px 0px;
}

.header-img {
	width : 70px;
	height : 40px;
}

#header-logo {
	width : 150px;
	height : 90px;
	padding : 35px 0px 0px 0px;
	text-align : center;
}

#header-logo h2{
	font-size : 50px;
	margin : 0px 0px 0px 0px;
}

#header-logo-black{
	width : 290px;
	height : 9px;
	background-color : black;
}

#header-logo-con:hover {
	cursor : pointer;
}

.header-menu-box {
	width : 130px;
	padding : 53px 0px 0px 0px;
	text-align : right;
}

.header-menu-box > a:hover{
	text-decoration-line : none;
	color : black;
}

.header-menu-box > a{
	font-size : 30px;
	color : #688331;
}

.dropdown > span {
	font-size : 30px;
	color : #688331;
}

.dropdown > span:hover{
	color : black;
}

.dropdown > ul {
	color : black;
}

#header-chat-box {
	width : 130px;
	padding : 8px 0px 0px 0px;
	text-align : right;
}

#header-chat-box > a:hover{
	text-decoration-line : none;
	color : black;
}

#header-chat-box > a{
	font-size : 30px;
	color : #688331;
}

#header-login-box {
	width : 180px;
	padding : 20px 0px 0px 0px;
	text-align : right;
}

#header-login-box > a{
	margin : 0px 0px 0px 5px;
}

#header-login-box > a:hover {
	text-decoration-line : none;
	color : black;
}

.header-menu-text-sm {
	font-size : 20px;
}

.header-menu-text-xs {
	font-size : 17px;
}

#hidden-menu-box {
	width : 1200px;
	height : 25px;
	margin : 0px 0px 5px 0px;
}

#hidden-menu-board {
	display : none;
	margin: 0px 0px 0px 430px;
}

#hidden-menu-board > a:hover {
	text-decoration-line : none;
}

#hidden-menu-board > a > span:hover {
	text-decoration-line : none;
	color : black;
}

#hidden-menu-board > a > span {
	margin : 0px 10px 0px 0px;
	padding : 5px 0px 0px 0px;
	color : #688331;
	font-size : 20px;
}

#wrap-con {
	width : 1200px;
	margin : auto;
	position : relative;
}
#wrap-con::after {
	content : "";
	position : absolute;
	left : 0;
	top : 0;
	width : 100%;
	height : 100%;
	background-color: #ECF8E0;
	background-size : 100%; z-index : -1;
	opacity : 0.3;
}

#wrap-box-top {
	display : inline-flex;
	height : 30px;
	font-size : 20px;
	margin : 0px 0px 10px 0px;
	border-top : 1px solid black;
	border-bottom : 1px solid black;
}

#wrap-box-top > div {
	width : 390px;
	height : 30px;
	margin : 0px 5px 0px 5px;
	padding : 4px 0px 0px 0px;
}

#title-box {
	text-align : center;
}

#wrap-box-bottom {
	height : 30px;
	font-size : 20px;
	margin : 10px 0px 0px 0px;
	padding : 0px 0px 0px 0px;
	border-bottom : 1px solid black;
}

#wrap-box {
	width :1100px;
	margin : auto;
	padding : 0px 50px 0px 50px;
	text-align : center;
}

.dp48 {
	margin : 6px 0px 0px 0px;
}

/* 여기부터 화상통화===================================== */
#video-call-div {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: none;
}

#local-video {
    position: absolute;
    top: 0;
    left: 0;
    margin: 16px;
    border-radius: 16px;
    max-width: 20%;
    max-height: 20%;
    background: #ffffff;
}

#remote-video {
    background: #000000;
    width: 100%;
    height: 100%;
}

.call-action-div {
    position: absolute;
    left: 45%;
    bottom: 32px;
}

button {
    cursor: pointer;
}

#video_modal {
    display: none;
    width: 600px;
    height:600px;
    padding: 20px 60px;
    background-color: #fefefe;
    border: 1px solid #888;
    border-radius: 3px;
    overflow:scroll;
}
/* 여기까지 화상통화===================================== */

/* 쪽지 사이드바 스타일 */
.sidenav {
    height:100%;
    width: 0;
    position: fixed;
    z-index:1;
    top: 0;
    left: 0;
    background-color: #F5F6CE;
    overflow-x: hidden;
    transition:0.5s ease-in-out;
    padding-top: 60px;
}
.sidenav a {
    padding: 8px 8px 8px 32px;
    text-decoration: none;
    font-size: 25px;
    color: #fff;
    display: block;
    transition: 0.2s ease-in-out;
}
.sidenav a:hover, .offcanvas a:focus {
    color: #000;
}
.closebtn {
    position: absolute;
    top: 0;
    right: 25px;
    font-size: 36px !important;
    margin-left: 50px;
}
.openmenu:hover {
    color:rgb(0,154,200);
    transition:0.5s ease-in-out;
}
.openmenu {
    font-size: 25px;
    cursor:pointer;
    transition:0.5s ease-in-out;
}
.openmenu > i {
    font-size: 30px;
}
/* 미디어쿼리 적용 */
@media screen and (max-height:450px) {
    .sidenav {
        padding-top:15px;
    }
    .sidenav a {
        font-size: 18px;
    }
}
 
.letter {
    margin-left : 20px;
    border : 1px solid white;
    background-color : white;
    margin-bottom : 10px;
    display :inline-block;
    width : 300px;
    height : 150px;
}
.letter .header {
    background-color : #e60e45;
    font-color : white;
}
 
#mssage_send_btn {
    float : left;
    margin-top : -50px;
    margin-left : 10px;
    height :35px;
}
 
.msg_form .modal-body table tbody tr {
    margin-bottom : 20px;
}
</style>


<script type="text/javascript">

$(document).ready(function(){
	var username = '${id}'
	console.log('${id}')
	if('${id}'!='') {// 아이디가 비어있지 않다면
		//클라이언트 소켓 만들기 
		var sockJS = new SockJS("/notice")
		var stomp = Stomp.over(sockJS);
		
		stomp.connect({},function(){
			stomp.subscribe("/sub/notice"+username, function(notice){
			
			var alArray = JSON.parse(notice.body)	
			console.log(alArray)
			
			stomp.disconnect();
			
			if(alArray[0]!='noPlantsWantWater'){
				$(".dropdown").eq(0).find("#wantsWater").html("물이 먹고 싶어요.")
				$(".dropdown").eq(0).find("#alarm1").html(alArray[0].nick)
				if(alArray[1]!=null)
					$(".dropdown").eq(0).find("#alarm2").html(alArray[1].nick)
				if(alArray[2]!=null)
					$(".dropdown").eq(0).find("#alarm3").html(alArray[2].nick)
			}else if(alArray[0]=='noPlantsWantWater'){
				$(".dropdown").eq(0).find("#wantsWater").html(alArray[1])
			}
			})
			
			$.ajax({
				url: "/notice",
				type: "get",
				asnyc: false,
				data: {username:username},
			})
		  })
	}//if end
})

//----------------------------------여기부터 화상통화--------------------------------------

var receiverId;
let myId = '${sessionScope.id }';

var eventData
var webSocket

webSocket = new WebSocket("ws://localhost:8088/videows/video")


webSocket.onmessage = (event) => {
    eventData = JSON.parse(event.data);
    receiverId = eventData.senderId;

	console.log(JSON.parse(event.data))
	
	//통화요청 알림
    let $socketAlert = $('div#socketAlert');
    $socketAlert.text(eventData.senderId+"님의 화상통화 요청");
    $socketAlert.css('display', 'block');
    
    handleSignallingData(JSON.parse(event.data))
    
}
	

function handleSignallingData(data) {
    switch (data.type) {
        case "send_answer":
        	console.log("---send_answer---")
            peerConn.setRemoteDescription(data.answer)
        	console.log("---send_answer---")
            break;
        case "candidate":
        	console.log("---candidate---")
            peerConn.addIceCandidate(data.candidate)
        	console.log("---candidate---")
    }
}

function sendData(data) {
    webSocket.send(JSON.stringify(data))
}

let localStream
let peerConn
function startCall() {
 	var	videoModal = "<div id='video-call-div'><video muted id='local-video' autoplay></video>"
		videoModal += "<video id='remote-video' autoplay></video><div class='call-action-div'>"
		videoModal += "<button onclick='muteVideo()'>화면 끄기</button>"
		videoModal += "<button onclick='muteAudio()'>오디오 끄기</button>"
		videoModal += "<button class='modal_close_btn'>나가기</button></div></div>"
		
    $("#video_modal").html(videoModal);
	modalStart('video_modal');
		
    document.getElementById("video-call-div").style.display = "inline"

//     navigator.getUserMedia({
//         video: {
//             frameRate: 24,
//             width: {
//                 min: 480, ideal: 720, max: 1280
//             },
//             aspectRatio: 1.33333
//         },
//         audio: true
//     }, (stream) => {
//         localStream = stream
//         document.getElementById("local-video").srcObject = localStream

//         let configuration = {
//             iceServers: [
//                 {
//                     "urls": ["stun:stun.l.google.com:19302", 
//                     "stun:stun1.l.google.com:19302", 
//                     "stun:stun2.l.google.com:19302"]
//                 }
//             ]
//         }

//         peerConn = new RTCPeerConnection(configuration)
//         peerConn.addStream(localStream)

//         peerConn.onaddstream = (e) => {
//             document.getElementById("remote-video").srcObject = e.stream
//         }

//         peerConn.onicecandidate = ((e) => {
//             if (e.candidate == null)
//                 return;
//             sendData({
//             	receiverId: receiverId,
//             	senderId: myId,
//                 type: "store_candidate",
//                 candidate: e.candidate
//             })
//         })

//         createAndSendOffer()
//     }, (error) => {
//         console.log(error);
//     })

		const constraints = {
		    'video': true,
		    'audio': true
		}
		navigator.mediaDevices.getUserMedia(constraints)
		    .then(stream => {
		        console.log('Got MediaStream:', stream);
		 	    localStream = stream
		 	    document.getElementById("local-video").srcObject = localStream
		        
		     let configuration = {
		     iceServers: [
		         {
		             "urls": ["stun:stun.l.google.com:19302", 
		             "stun:stun1.l.google.com:19302", 
		             "stun:stun2.l.google.com:19302"]
		         }
		     ]
		 }
		
		 peerConn = new RTCPeerConnection(configuration)
		 peerConn.addStream(localStream)
		
		 peerConn.onaddstream = (e) => {
		     document.getElementById("remote-video").srcObject = e.stream
		 }
		
		 peerConn.onicecandidate = ((e) => {
		     if (e.candidate == null)
		         return;
		     sendData({
		     	receiverId: receiverId,
		     	senderId: myId,
		         type: "store_candidate",
		         candidate: e.candidate
		     })
		 })
		
		 createAndSendOffer()
		 	    
		})
		.catch(error => {
		    console.error('Error accessing media devices.', error);
		});
    
};   
    

function createAndSendOffer() {
    peerConn.createOffer((offer) => {
        sendData({
        	receiverId: receiverId,
        	senderId: myId,
            type: "store_offer",
            offer: offer
        })

        peerConn.setLocalDescription(offer)
    }, (error) => {
        console.log(error)
    })
};

let isAudio = true
function muteAudio() {
    isAudio = !isAudio
    localStream.getAudioTracks()[0].enabled = isAudio
}

let isVideo = true
function muteVideo() {
    isVideo = !isVideo
    localStream.getVideoTracks()[0].enabled = isVideo
};



var modal
var bg
function modalStart(id) {
    var zIndex = 9999;
    modal = document.getElementById(id);

    // 모달 div 뒤에 희끄무레한 레이어
    bg = document.createElement('div');
    bg.setStyle({
        position: 'fixed',
        zIndex: zIndex,
        left: '0px',
        top: '0px',
        width: '100%',
        height: '100%',
        overflow: 'auto',
        // 레이어 색갈은 여기서 바꾸면 됨
        backgroundColor: 'rgba(0,0,0,0.4)'
    });
    document.body.append(bg);

    // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
    modal.querySelector('.modal_close_btn').addEventListener('click', function() {
    	bg.remove();
        modal.style.display = 'none';
        $('#socketAlert').css('display', 'none');
    });

    modal.setStyle({
        position: 'fixed',
        display: 'block',
        boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

        // 시꺼먼 레이어 보다 한칸 위에 보이기
        zIndex: zIndex + 1,

        // div center 정렬
        top: '50%',
        left: '50%',
        transform: 'translate(-50%, -50%)',
        msTransform: 'translate(-50%, -50%)',
        webkitTransform: 'translate(-50%, -50%)'
//	        overflow:'hidden'
    });
}

// Element 에 style 한번에 오브젝트로 설정하는 함수 추가
Element.prototype.setStyle = function(styles) {
    for (var k in styles) this.style[k] = styles[k];
    return this;
};

function okCall(){

	if (confirm("영상통화를 시작하시겠습니까?") == true){    //확인

		startCall()

	}else{   //취소
		$('#socketAlert').css('display', 'none');
		sendData({
        	receiverId: receiverId,
        	senderId: myId,
            type: "cancle"
        })
	    return;

	}

}

//----------------------------------여기부터 화상통화--------------------------------------

</script>


</head>

<body>

<!-- ===========화상통화 알림창============ -->
<div id="socketAlert" class="alert alert-success" role="alert" style="display:none; margin: 0;" onClick="okCall()"></div>

<div>
	<span id="video_modal"></span>
</div>
<!-- ===========화상통화 알림창============ -->

<header id="header">
	<div id="header-box">
		<div id="header-logo-con" onClick="location.href='/'">
			<div id="header-logo-box">
				<div class="header-lmg-box">
					<img class="header-img" src="/resources/img/headerleft.png">
				</div>
				<div id="header-logo">
					<h2>Seeker</h2>
				</div>
				<div class="header-lmg-box">
					<img class="header-img" src="/resources/img/headerright.png">
				</div>
			</div>
			<div id="header-logo-black">
			</div>
		</div>
		<div id="header-center"></div>
		<div class="header-menu-box">
			<a href="/myplant/list">나의 식물</a>
		</div>
		<div class="header-menu-box" id="menu-box-board">
			<a id="menu-board">게시판</a>
		</div>	
		<div class="header-menu-box">
			<a href="/garden/gardenMap">수목원</a>
		</div>
		<div class="header-menu-box">
			<a href="/shop/home">스토어</a>
		</div>
		<div class="header-menu-box dropdown" >
			<span class="dropdown-toggle" data-toggle="dropdown" role="button" style="cursor:pointer;">
			<i class="material-icons dp48">alarm_on</i>
			<span class="header-menu-text-sm">알람</span> 
			</span>
			<ul class="dropdown-menu" role="menu" style="width: 15em" >
				<li><div id="wantsWater" style="text-align: center"></div></li>
				<li> <div style="text-align: center">
				<span class="dropdown-item" id="alarm1" ></span> 
				<span class="dropdown-item" id="alarm2" ></span> 
				<span class="dropdown-item" id="alarm3" ></span> 
				</div>
			    <li class="dropdown-header"></li>
			    <li class="divider"></li>
			</ul>
		</div>
		<div class="header-menu-box">
			<a href="/shop/cartList" >
				<i class="material-icons dp48">shopping_cart</i>
				<span class="header-menu-text-sm">장바구니</span>
			</a>
		</div>	
		<div>
			<div id="header-login-box">
				<c:choose>
					<c:when test="${empty login }">
						<a href="/member/login"><span class="header-menu-text-xs">로그인</span></a>
					</c:when>
					<c:when test="${login eq true }">
<span id="recMs" class="header-menu-text-xs" onclick="openNav()" name="recMs" style="float:left;cursor:pointer;margin-right:10px;color:pink;"><img src="/resources/img/msgicon.png" id="messageImage" style="opacity :0.3;width:15px;"></span>
						<a href="/member/logout"><span class="header-menu-text-xs">로그아웃</span></a>
					</c:when>
				</c:choose>
				<a href="/member/join"><span class="header-menu-text-xs">회원가입</span></a>
			</div>
			<div id="header-chat-box">
			<a href="/chat/rooms" >
			<i class="material-icons dp48">chat_bubble</i>
			<span class="header-menu-text-sm">오픈채팅</span>
			</a>
			</div>
		</div>
	</div>
	<div id="hidden-menu-box">
		<div id="hidden-menu-board">
			<a href="/board/freeList"><span>자유 게시판</span></a>
			<a href="/board/photoList"><span>사진 게시판</span></a>
		</div>
	</div>
<!-- ----------------------------------여기부터 쪽지-------------------------------------- -->


<div id="mysidenav" class="sidenav">
        <a href="#" class="closebtn" onclick='closeNav()'>x</a>
        <div id="mssage_send_btn" name="mssage_send_btn" class="btn btn-warning"><p>쪽지 보내기</p></div>
        <!--  <div id="bbb" name="mssage_send_btn" class="btn btn-warning"><p>쪽지</p></div> -->
    </div>
    
<div class="modal fade momo" id="MsgForm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header fn-font">
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">X</span>
                    </button>
                </div>
                <form class="msg_form">
                    <!-- <input type="hidden" id="flag" name="flag" value="insert"/> -->
                    <input type="hidden" id="memberNo" name="memberNo" value="${memberNo}"/>
                    <div class="modal-body fn-font">
                        <table>
                            <colgroup>
                                <col style="width:150px;"/>
                                <col style="width:px;"/>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>작성자</th>
                                    <th><input type="text" id="senderName" name="senderName" class="form-control" value="<c:out value='${id}'/>" readonly/></th>
                                </tr>
                                <tr>
                                    <th>받는 사람</th>
                                    <th>
                                        <select id="receiverName" name="receiverName" class="form-control user" value="">
                                            
                                                <option value="">전체</option>
                                            
                                        </select>
                                    </th>
                                </tr>
                                <tr>
                                    <th>제목</th>
                                    <th><input type="text" id="msTitle" name="msTitle" class="form-control" value=""/></th>
                                    
                                </tr>
                                <tr>
                                    <th>내용</th>
                                    <th><textArea id="msContent" name="msContent" class="form-control"></textArea></th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </form>
                <div class="modal-footer fn-font">
                    <button class="btn" type="button" id="msg_submit">보내기</button>
                    <button class="btn" type="button" data-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
<script>
$(document).ready(function() {
	//$("#bbb").click(function(){
	$.ajax({
		type:"get",
        dataType:"json",
        url:"/layout/header",
        success:function(userList){
        	
        	console.log(userList);

        	for(let i = 0; i<userList.length; i++) {
        		console.log(userList[i].id);
        		
        		var userSelect = $("select.user");
        		
        		userSelect.append("<option value='" + userList[i].id + "'>"
						+ userList[i].id + "</option>");
        		
        	}
    
      
        },
        error:function(){
        	//'<c:set var="userList" value="userList"/>'
        	console.log("에러러러러러ㅓ" );
      
        }
	})
	//})
});

</script>

<script>

function openNav() {
    document.getElementById('mysidenav').style.width = '350px';
    $.ajax({
        type:"post",
        dataType:"json",
        url:"/message/list",
        data :{
            receiverName : '${id}'
        },
        success:function(data){
            var i =1;
            var dataset = data.result;
            
            
            dataset.forEach(function(row){
            	// 메세지를 호출해와야 하기 때문에 $.ajax를 통해 receiverName으로 온 메세지들을 모두 불러온다
            	//해당 if 조건절의 length 는 div의 ID값이 데이터베이스에서 AUTO INCREMENT 되는 값이기 때문에,
				//div 아이디를 토대로 중복으로 html 요소가 생성되지 않도록 하는 구문이다.
         
				var date = new Date(+ row.msDate + 3240 * 10000).toISOString().replace("T", " ").replace(/\..*/, '');
            	
            	console.log(date)
            	
                if($("#"+i).length >0){
                }else{
                	/* $("#mysidenav").children().remove(); */
                    $("#mysidenav").append("<div id='"+ row.memberNo +"'class='letter'><div class='header'><p style='color:white;font-size:23px;margin-left: 20px;'>"+row.msTitle+"</p></div><table><tbody><tr><th>"+date+"</th><th>&nbsp;&nbsp;발송자: "+row.senderName+"</th></tr>"+   
                               "<tr><th>"+row.msContent+"</th></tr></tbody></table><div class='footer'></div></div>");
            
                    /* if(row.readYn == 0){
                            $("#"+i+" .footer").append("<input type='button' style='float:right;' id='letter_read' class='btn btn-danger' value='read'/>");
                    } */
                    i++;    
                }
            });
        }
    })
    
    //사이드바가 열려있을 때 width가 늘어나고 닫힐 때 없어짐
    if($("#mysidenav").css("width") =="350px")
        document.getElementById('mysidenav').style.width = '0';
        
}
function closeNav() {
    document.getElementById('mysidenav').style.width = '0';
}

</script>  

<script>
$("#mssage_send_btn").click(function(){
    $('#MsgForm').modal("show");
});
$("#msg_submit").click(function(){
    var msg= "쪽지를 보내겠습니까?";
    
    if(!confirm(msg))
        return false;
    
    $.ajax({
        url : "/message/proc",
        dataType : "json",
        type : "post",
        data : $(".msg_form").serialize(),
        success:function(result){
        	
        	if(result == 1) {
            alert("쪽지를 보냈습니다."); 
            location.href = "/";
        	}
   
        }
    })
});

</script>  
    
<script type="text/javascript">

/* var sock = null; */

var socket = null; 
var sock = new SockJS("/message");
socket = sock; 

$(document).ready(function(){
    if(${login}) {
    	
	
    }	
           /*  connectWS(); */
});
   /*  $(".chat_start_main").click(function(){
        $(this).css("display","none");
        $(".chat_main").css("display","inline");
    })
    $(".chat_main .modal-header").click(function(){
        $(".chat_start_main").css("display","inline");
        $(".chat_main").css("display","none");
    }); */
 
    /* function connectWS(){ */
        sock.onopen = function() {
               console.log('Message: connection opened.');
				sock.send("1");
        };
        sock.onmessage = function(e){
           /* var splitdata =e.data.split(":");
            if(splitdata[0].indexOf("recMs") > -1)             
                $("#recMs").append("["+splitdata[1]+"통의 쪽지가 왔습니다.]"); */
                
                console.log(e.data);
                
                $("#recMs").append("["+e.data+"통]");
            /* else
                $("#chat").append(e.data + "<br/>"); */
        }
        /* sock.onclose = function(){
            $("#chat").append("연결 종료");
//              setTimeout(function(){conntectWs();} , 10000); 
        } */
        sock.onerror = function (err) {console.log('Errors : ' , err);};
 		
   /*  } */
    
    /* $("#board1").click(function(){
        location.href="/board/main_board.do";
    }); */
 
/* $("#chatForm").submit(function(event){
        event.preventDefault();
            sock.send($("#message").val());
            $("#message").val('').focus();    
    });  */   
</script>

<!-- ----------------------------------여기까지 쪽지-------------------------------------- -->
</header>
<div id='wrap-con'>
