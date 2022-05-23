<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html style="height:100%">


<!-- jQuery 2.2.4 -->
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<!-- SOCKJS -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.0/sockjs.min.js"></script>
<!-- STOMP -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<!-- BOOTSTRAP -->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css"/>

    <style>
    
        input[type="text"]{border:0; width:85%;background:#ddd; border-radius:5px; height:30px; padding-left:5px; box-sizing:border-box; margin-top:5px}
        input[type="text"]::placeholder{color:#999}

	.btn-primary { 
	  background-color: #99CC66;
	  display: inline-block;
	  margin: auto 0;
	  border: 0;
	   }
		   
     .modal-backdrop {
       z-index: -1;
 	  }
    
    
  
    </style>

<script type="text/javascript">

$(document).ready(function(){
	//웹소켓 설정을 위한 준비 작업 
	//const username = ${sessionScope.testuser}
	var username ="${id}"
	if(username == '') username = '${adminid}'
	var namelength = username.length;
	console.log(username)
	var msg = $("#messages");
	console.log(msg.val())
	
 	if(username==null){
	alart('로그인되지 않았습니다')	
	}
	
	//-----------------------------------------
	// 클라이언트 소켓 만들기
	var sockJS = new SockJS("/chat")
	var stomp = Stomp.over(sockJS);
	

   var roomName = '${room.roomName}';
   var roomId = '${room.roomId}';
   
	stomp.connect({},function(){
		console.log("stomp 호출")
		//subscribe(path, callback)
		stomp.subscribe("/sub/chat/room"+roomId, function(chat){
			console.log(chat)
  		   var content = JSON.parse(chat.body)
			var chatLog = content.chatLog
			var writer = content.userID;
	 		var message = content.chatLog
	 		var str = '<div style=padding'
	 			str += ":" 
 				str += '3px 0.5em;>'
				str += writer 
				str += ":" 
				str += message 
		 		str += "</div>"

    			$("#msgArea").append(str);
			console.log("chat"+str)
		})//subscribe end
		
		//send(path, header, message)
		stomp.send('/pub/chat/enter', {}, 
				JSON.stringify({roomId: roomId, 
					userID: username,
					chatLog: ' 님이 입장하였습니다. '
					}))
		
	})//connect end
	
    
    var currentTime = function(){
        var date = new Date();
        var hh = date.getHours();
        var mm = date.getMinutes();
        var apm = hh >12 ? "오후":"오전";
        var ct = apm + " "+hh+":"+mm+"";
        return ct;
    }
	

	//퇴장
	function onClose(e){
//		clearInterval(websocket.interval);
		$.ajax({
			url: "/chat/exit",
			type: "get",
			data: {roomId: roomId, username:username},
			success: console.log("session deleted") ,
			error:	console.log("session delete error")
		})
		stomp.disconnect()
		console.log("onClose()")
		window.location.replace("/chat/rooms")
	}
	
	 function onError(e){
		console.log("onError()")
		alart('에러가 발생하였습니다')
		history.go(-1)
	} 
		
// 		----------------------
//DOM 요소들의 동작


	 $("#sendButton").click(function(e){
		 var msg = $("#messages")
         stomp.send('/pub/chat/message11', {}, 
 				JSON.stringify({roomId: roomId, 
 					userID: username,
 					chatLog: msg.val()
 					}))
         $("#messages").value = '';
	 })
	 
	  $("#disconn").click(function(){
		function pro1(){
			console.log("퇴장 ",username)
			stomp.send('/pub/chat/exit', {}, 
					JSON.stringify({roomId: roomId, 
						userID: username,
						chatLog: '님이 퇴장하였습니다.'
						}))
			console.log("here1")
		}
		
		function pro3() {
						console.log("here3")
						if (typeof window !== 'undefined') { alert('채팅을 종료합니다.') }
						onClose();	// 개발 위해 잠시 주석 처리
		}
		
		function pro2(){
			console.log("here2")
			
			 $.ajax({
					url: "/chat/logdown",
					type: "post",
					async: false,
					data: {userID:username, roomId:roomId}, //username은 위에서 선언한 var 
// 					dataType: "json",
	                success: function (data) {
	                	console.log(data)
	                    var blob = new Blob([data], { type: "application/octet-stream" });
	 					var fileName = "ChatLog.txt";
	                    var isIE = false || !!document.documentMode;
	                    if (isIE) {
	                        window.navigator.msSaveBlob(blob, fileName);
	                    } else {
	                        var url = window.URL || window.webkitURL;
	                        link = url.createObjectURL(blob);
	                        var a = $("<a />");
	                        a.attr("download", fileName);
	                        a.attr("href", link);
	                        
	                        $("body").append(a);
	                        a[0].click();
	                        a.remove();
	                    }
	                    pro3()
	                }
					,error:function(){
						console.log("저장실패")
						pro3();
					}
					 })
		}
			 
		if(!confirm("채팅 내역을 저장하시겠습니까?")){ // 저장안함
			forcheckSaveDiv.click() 
		} else { // 저장함 
			pro1();
			pro2();
	    	onClose();
		}		
	 
	  })//disconn end
	
	  $("#forcheckSaveDiv").click(function(){
          		if (confirm("채팅을 종료하시겠습니까?")){ //종료함
     		    	onClose();
          		}
	  })	
	  
	$("#checkparts").click(function(){
		$.ajax({
			url:"/chat/participant",
			type:"post",
			data:{roomId:roomId},
			dataType:"json",
			success:function(list){
				var str = "";
				for(var i=0; i<list.length; i++){
					str = ""
					console.log("참여자명 "+list[i]);
					str = "<div>" + list[i] + "</div>"
				
					$("#participants").append(str)
				}
			},
			error:function(result){
			console.log("에러");
				$('#participants').val('error')
			}
		})
	})
	
	$("#closeBtn").click(function(){
		$("#participants").empty()
	})
	$("#reloadNames").click(function(){
		$("#participants").empty()
		$.ajax({
			url:"/chat/participant",
			type:"post",
			data:{roomId:roomId},
			dataType:"json",
			success:function(list){
				var str = "";
				for(var i=0; i<list.length; i++){
					str = ""
					console.log("참여자명 "+list[i]);
					str = "<div>" + list[i] + "</div>"
				
					$("#participants").append(str)
				}
			},
			error:function(result){
			console.log("에러");
				$('#participants').val('error')
			}
		})
	})
	
	
})

</script>


<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="/WEB-INF/views/layout/header.jsp" />	
</head>
<body style="height: 100%">

<div style="text-align: center; padding: 0.5em; background-color:#99CC66; font-size: 1.5em; font: bolder;">
<label>[OnLine] ${room.roomName}</label>
</div>

<div id="msgArea" style="height:600px; overflow-y:scroll; padding: 10px 10px"></div>

<div style="height: 15px"></div>

<div style=" position:static; width: -webkit-fill-available;">
	<div style="text-align: center;">
		<input type="text" id="messages" placeholder="메시지를 입력하세요.">
		<button type="button" class="btn" id="sendButton" style=" height:31px; width: 10%" >전송</button>
		<div id="forcheckSaveDiv"></div> <!-- 체크용 빈 div -->
	</div>

	<div style="padding: 1em">


	<div style="text-align: center">
	<button type="button"  class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" id="checkparts">참가자 확인</button>
	<button type="button" class="btn btn-primary" id="disconn" >대화방 나가기</button>
	</div>		
	<div style="height: 2em"></div>
</div>	
		
		
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">참여자 목록</h5>
        <button class="close btn btn-secondary" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" >
        <div style="text-align: center">
        	<div id="participants"></div>
        	<div style="padding: 0.3em 0"></div>
			<button name="createBtn" id="reloadNames" class="btn-create"  style="border:0; padding: 8px 14px; border-radius: 4px;" id="checkparts">새로고침</button>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" id="closeBtn" data-dismiss="modal">Close</button>
      </div>
      </div>
    </div>
  </div>
</div>		

</body>

<c:import url="/WEB-INF/views/layout/footer.jsp" />

</html>