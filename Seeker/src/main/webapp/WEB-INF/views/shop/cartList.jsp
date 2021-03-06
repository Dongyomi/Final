<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<c:import url ="../layout/header2.jsp" ></c:import>



<style>

 a { color:#05f; text-decoration:none; }
 a:hover { text-decoration:underline; }
 
 h1, h2, h3, h4, h5, h6 { margin:0; padding:0; }
 ul, lo, li { margin:0; padding:0; list-style:none; }

 /* ---------- */
 
 div#root { width:900px; margin:0 auto; }
 header#header { }
 nav#nav { }
 section#container { }
  section#content { float:right; width:700px; }
  aside#aside { float:left; width:180px; }
  section#container::after { content:""; display:block; clear:both; } 

 
 /* ---------- */
 

 
 nav#nav div#nav_box { font-size:14px; padding:10px; text-align:right; }
 nav#nav div#nav_box li { display:inline-block; margin:0 10px; }
 nav#nav div#nav_box li a { color:#333; }
 
 section#container { }
 
 aside#aside h3 { font-size:22px; margin-bottom:20px; text-align:center; }
 aside#aside li { font-size:16px; text-align:center; }
 aside#aside li a { color:#000; display:block; padding:10px 0; }
 aside#aside li a:hover { text-decoration:none; background:#eee; }
 
 aside#aside li { position:relative; }
aside#aside li:hover { background:#eee; }   
aside#aside li > ul.low { display:none; position:absolute; top:0; left:180px;  }
aside#aside li:hover > ul.low { display:block; }
aside#aside li:hover > ul.low li a { background:#eee; border:1px solid #eee; }
aside#aside li:hover > ul.low li a:hover { background:#fff;}
aside#aside li > ul.low li { width:180px; }
 

 
</style>

<style>
/*  section#content ul li { display:inline-block; margin:10px; }
 section#content div.thumb img { width:200px; height:200px; }
 section#content div.goodsName { padding:10px 0; text-align:center; }
 section#content div.goodsName a { color:#000; } */
 
 section#content ul li { margin:10px 0; }
 section#content ul li img { width:200px; height:200px; }
 section#content ul li::after { content:""; display:block; clear:both; }
 section#content div.thumb { float:left; width:100px; }
 section#content div.gdsInfo { float:right; width:calc(100% - 270px); }
 section#content div.gdsInfo { font-size:20px; line-height:2; }
 section#content div.gdsInfo span { display:inline-block; width:100px; font-weight:bold; margin-right:10px; }
 section#content div.gdsInfo .delete { text-align:right; }
 section#content div.gdsInfo .delete button { font-size:15px;
            padding:5px 10px; border:1px solid #eee; background:#eee;}
            
.allCheck { float:left; width:200px; }
.allCheck input { width:16px; height:16px; }
.allCheck label { margin-left:10px; }
.delBtn { float:right; width:300px; text-align:right; }
.delBtn button { font-size:18px; padding:5px 10px; border:1px solid #eee; background:#eee;}

.checkBox { float:left; width:30px; }
.checkBox input { width:16px; height:16px; }
.total {font-size: 30px;}
.gdsAllPrice{font-size: 32px; color: #86B404;}
.numBox { font-size:22px; width:50px; padding:5px; margin:0; border:1px solid #eee; }
.plus { font-size:26px; border:none; background:none; }
.minus { font-size:26px; border:none; background:none; }

.listResult { padding:20px; background:#eee; }
.listResult .sum { float:left; width:45%; font-size:22px; }

.listResult .orderOpne { float:right; width:45%; text-align:right; }
.listResult .orderOpne button { font-size:18px; padding:5px 10px; border:1px solid #999; background:#fff;}
.listResult::after { content:""; display:block; clear:both; }

.orderInfo { border:5px solid #eee; padding:20px; display: none; }
.orderInfo .inputArea { margin:10px 0; }
.orderInfo .inputArea label { display:inline-block; width:150px; margin-right:10px; }
.orderInfo .inputArea input { font-size:14px; padding:5px; width: 200px; }
#addr2, #addr3 { width:250px; }

.orderInfo .inputArea:last-child { margin-top:30px; }
.orderInfo .inputArea button { font-size:20px; border:2px solid #ccc; padding:5px 10px; background:#fff; margin-right:20px;}

</style>

<div id="wrap-box-top">
	<div><a href="/shop/home"><span class="glyphicon glyphicon-arrow-left"></span>&nbsp;?????? ???</a></div>
	<div id="title-box">????????????</div>
	<div></div>
</div>
<div id="wrap-box">


<section id="container">
	<div id="container_box">
	<aside id="aside">
 		<ul>
  		<c:import url ="../layout/asideGoodsUser.jsp" ></c:import>
 		</ul>
	</aside>
	
		<section id="content">
		
		<script>IMP.init("imp61196601");</script>
			
			<ul>
			<li>
				<div class="allCheck">
   				<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck">?????? ??????</label> 
  				</div>
  				
  				<script>
					$("#allCheck").click(function(){
					 var chk = $("#allCheck").prop("checked");
					 if(chk) {
					  $(".chBox").prop("checked", true);
					 } else {
					  $(".chBox").prop("checked", false);
					 }
					});
				</script>
  
  				<div class="delBtn">
   					<button type="button" class="selectDelete_btn">?????? ??????</button>				 
  				</div>
    			<script>
					 $(".selectDelete_btn").click(function(){
					  //confirm??? ????????? ?????? ????????? ??????
					  var confirm_val = confirm("?????? ?????????????????????????");
					  
					  //?????? ????????? ?????????????????? ?????? ?????? checkArr??? ????????? ??? ??????????????? ??????
					  if(confirm_val) {
					   	var checkArr = new Array();
					   
					   	//each() : ????????? ????????? ?????? ?????? ??? ????????? ????????? ???????????? ????????? ??????
					   	$("input[class='chBox']:checked").each(function(){
					   		
					   		//data-[????????? ??????] : ????????? ?????? -> cartNum??? ???????????? ?????? 
					    	checkArr.push($(this).attr("data-cartNum"));
					   	});
					    
					   	$.ajax({
					    	url : "/shop/deleteCart",
					    	type : "post",
					    	data : { chbox : checkArr },
					    	success : function(result){
					    		if(result == 1) {
					    			//?????? ??? ????????????
					    			alert("?????????????????????!");
					     			location.href = "/shop/cartList";
					    		} else {
					    			alert("?????? ?????? ???, ????????? ???????????? ???????????? ????????? ?????????????????????.");
					    		}
					    	}
					   	});
					   } 
					 });
				</script>
			</li>
			
			<c:set var ="total" value="0" />
			
 			<c:forEach items="${cartList}" var="cartList">
 			<li>
 			
 			<div class="checkBox">
   				<input type="checkbox" name="chBox" class="chBox" data-cartNum="${cartList.cartNum}" />
  			</div>
  			
  			
  			<script>
  				//?????? ?????? ??????????????? ????????? ????????? ?????? ???????????? ?????? ??????
				 $(".chBox").click(function(){
				  $("#allCheck").prop("checked", false);
				 });
			</script>
  			
  			<div class="thumb">
   				<img src="<%=request.getContextPath() %>/upload/${cartList.imgStoredName }" 
			 alt="????????? ??????????????????" width="50%" height="50%"><br>
  			</div> 
  			<div class="gdsInfo">
    			<p>
    				
     				 <span>????????? : </span>${cartList.gdsName}<br />
				     <span>?????? ?????? : </span><fmt:formatNumber pattern="###,###,###" value="${cartList.gdsPrice}" />???<br />
				     <span>?????? ?????? : </span>
				     		
 							<input type="hidden" value="${cartList.gdsStock}"/>
 							<input type="number" name="numBox_${cartList.cartNum}" class="numBox_${cartList.cartNum}" min="1" max="${cartList.gdsStock}" value="${cartList.cartStock}"/>
 							
 							
 							<button type="button" class="update_${cartList.cartNum}_btn" data-cartNum="${cartList.cartNum}" data-cartStock="${cartList.cartStock}" >??????</button>
 						
 							 
			    			<script>
								 $(".update_${cartList.cartNum}_btn").click(function(){
									 
									 console.log("click()");
									 
								  	//confirm??? ????????? ?????? ????????? ??????
								  	var confirm_val = confirm("?????????????????????????");
								  	 if(confirm_val) {
								  		
								  		/* var cartNum = new Array(); 
								  		var cartStock = new Array();
								  		cartNum.push($(this).attr("data-cartNum"));
								  		cartStock.push($(this).attr("data-cartStock")); */
								  	
								  		
								  		 
								  		var cartStock = $(".numBox_${cartList.cartNum}").val();
								  		var cartNum; 
								  		console.log(cartStock);
								  		/* cartNum.push($(this).attr("data-cartNum")); */  
								  		var cartNum = $(this).attr("data-cartNum"); 
								  		console.log(cartNum);
								  		
									   	
								  		
								  		
								  		 var data = {
								  				cartStock : cartStock,
								  				/* chbox : checkArr */
								  				 cartNum : cartNum 
											     }; 
											     
							
		
								  		
				    						$.ajax({
				    				 			url : "/shop/updateCart",
				    				 			type : "post",
				    				 			data : data,
				    				 			success : function(result){
				    				  				if(result == 1) {
				    				  					alert("?????????????????????!");
				    				   					location.href = "/shop/cartList";
				    				  				} else {
				    				   					alert("?????? ?????? ???, ????????? ???????????? ?????? ????????? ?????????????????????.");
				    				  				}
				    				 			}
				    						});
								  		} 
								  	   
								 });
			    			</script>  
		 				<br>
		 
						
				     
				     <span>??? ?????? : </span><fmt:formatNumber pattern="###,###,###" value="${cartList.gdsPrice * cartList.cartStock}" />???
				     <c:set var="total" value="${total + cartList.gdsPrice * cartList.cartStock }" />
    			</p>
    			
    			<div class="delete">
    				<button type="button" class="delete_${cartList.cartNum }_btn" data-cartNum="${cartList.cartNum}">??????</button>
    			</div>
    			<script>
					 $(".delete_${cartList.cartNum }_btn").click(function(){
					  	//confirm??? ????????? ?????? ????????? ??????
					  	var confirm_val = confirm("?????? ?????????????????????????");
					  	if(confirm_val) {
					  		
					  		//???????????? ????????? ????????? ????????? ????????? ???????????? ?????? -> ???????????? ????????? ??????
					  		var checkArr = new Array();
					  		
					  		checkArr.push($(this).attr("data-cartNum"));
					  		
    						$.ajax({
    				 			url : "/shop/deleteCart",
    				 			type : "post",
    				 			data : { chbox : checkArr },
    				 			success : function(result){
    				  				if(result == 1) {
    				  					alert("?????????????????????!");
    				   					location.href = "/shop/cartList";
    				  				} else {
    				   					alert("?????? ?????? ???, ????????? ???????????? ???????????? ????????? ?????????????????????.");
    				  				}
    				 			}
    						});
					  	}
					 });
    			</script>
    			
    			    
   			</div>
 			</li>
 			</c:forEach>
 			<li>
 				<br>
   				<div class="listResult">
   				<div class="total">
   					???????????? <fmt:formatNumber pattern="###,###,###" value="${total}" />??? + ????????? 0??? = <div class="gdsAllPrice">??? ?????? <fmt:formatNumber pattern="###,###,###" value="${total}" />???<br /></div>
   				</div>
				 <div class="orderOpne">
				  <button type="button" class="orderOpne_bnt">?????? ?????? ??????</button>
				 </div>
				 
				 <script>
				 	//?????? ?????? ?????? ????????? ???????????? ??????????????? ?????? ???????????? ??????????????? ????????? ?????????
					 $(".orderOpne_bnt").click(function(){
					  $(".orderInfo").slideDown();
					  $(".orderOpne_bnt").slideUp();
					 });      
				</script>
				
				</div>
				
				<div class="orderInfo">
 					<form role="form" method="post" action="/shop/cartList" autocomplete="off" name="orderForm">
    
  						<input type="hidden" name="amount" value="${total}" />
    
					  <div class="inputArea">
					   <label for="orderRec">?????????</label>
					   <input type="text" name="orderRec" id="orderRec" required="required" value="${member.name }" />
					  </div>
					  
					  <div class="inputArea">
					   <label for="phone">?????????</label>
					   <input type="text" name="phone" id="phone" required="required" value="${member.phone }" />
					  </div>
					  
					  <div class="inputArea">
					   <label for="addr1">????????????</label>
					   <input type="text" name="addr1" id="addr1" required="required" value="${member.addr1 }" />
					  </div>
					  
					  <div class="inputArea">
					   <label for="addr2">1??? ??????</label>
					   <input type="text" name="addr2" id="addr2" required="required" value="${member.addr2 }" />
					  </div>
					  
					  <div class="inputArea">
					   <label for="addr3">2??? ??????</label>
					   <input type="text" name="addr3" id="addr3" required="required" value="${member.addr3 }" />
					  </div>
					  
					  
					  <input type="hidden" name="addr3" id="addr3" />
					  
					  <div class="inputArea">
					  
					   <button type="button" class="order_btn">??????</button>
					   <script>
					   	
					   
					   	$(".order_btn").click(function(){ 
					   		IMP.request_pay({
					   		    pg : 'html5_inicis',
					   		    pay_method : 'card',
					   		    merchant_uid: "merchant_" + new Date().getTime(), // ???????????? ???????????? ?????? ????????? ??????
					   		    name : '${cartList[0].gdsName}',
					   		    amount : '${total}',
					   		    buyer_email : '${member.email}',
					   		    buyer_name : '${member.name}',
					   		    buyer_tel : '${member.phone}',
					   		    buyer_addr : '${member.addr2} ${member.addr3}',
					   		    buyer_postcode : '${member.addr1}',
					   		}, function(rsp) { // callback ??????
					   			if(rsp.success) {
					   				

					   				var msg = '????????? ?????????????????????.';
					   				/* msg += '??????ID :' + rsp.imp_uid;
					   				msg += '?????? ??????ID : ' + rsp.merchant_uid; */
					   				msg += '?????? ?????? : ' + rsp.paid_amount;
					   				msg += '?????? ???????????? : ' + rsp.apply_num;
					   				
					   				//????????? -> ?????????????????? ?????????
					   				$('form[name="orderForm"]').serialize();
					   				
					   				$('form[name="orderForm"]').append($('<input/>', {type: 'hidden', name: 'impUid', value: rsp.imp_uid}));
					   				$('form[name="orderForm"]').append($('<input/>', {type: 'hidden', name: 'merchantUid', value: rsp.merchant_uid}));
					   				$('form[name="orderForm"]').append($('<input/>', {type: 'hidden', name: 'paidAmount', value: rsp.paid_amount}));
					   				$('form[name="orderForm"]').append($('<input/>', {type: 'hidden', name: 'applyNum', value: rsp.apply_num}));
					   				
					   				/* newForm.appendTo('body'); */
								   				   				
					   				$('form[name="orderForm"]').submit();
					   				
					   			} else {
					   				var msg = '????????? ?????????????????????.';
					   				msg += '???????????? : ' + rsp.error_msg;
					   			}
					   			
					   			alert(msg);
					   		});
					   		
					   	});
					   
					   
					   </script>
					   
					   <button type="button" class="cancel_btn">??????</button> 
					  </div>
					  
					  <script>
					  		//?????? ???????????? ?????? ????????? ???????????? ?????? ???????????? ??????????????? ?????? ?????? ?????? ????????? ???????????? ???
							$(".cancel_btn").click(function(){
							 $(".orderInfo").slideUp();
							 $(".orderOpne_bnt").slideDown();
							});      
					   </script>
  
 					</form> 
				</div>
   			</li>
			</ul>
		
		</section>
	
	
	</div>

</section>
</div>

<c:import url ="../layout/footer.jsp" ></c:import>
