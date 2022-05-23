package web.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import web.dto.CartList;
import web.dto.ChatDto;
import web.dto.MyPlant;
import web.dto.Order;
import web.dto.OrderList;
import web.service.face.ChatService;
import web.service.face.MemberService;
import web.service.face.MyPlantService;
import web.service.face.ShopService;
import web.service.face.WaterPerService;

@Controller
public class StompChatController {
	
	private static final Logger logger = LoggerFactory.getLogger(StompChatController.class);
	@Autowired SimpMessagingTemplate template;
	@Autowired ChatService chatService;
    @Autowired MemberService memberService;
    @Autowired MyPlantService myPlantService;
    @Autowired WaterPerService wpService;
    @Autowired ShopService shopService;
	// StompWebSocketConfig 에서 설정한 prifix가 경로에 병합됨.
	
	@MessageMapping(value = "/chat/enter")
	public void enter(ChatDto chatDto) {
		chatDto.setIsStart(1); //채팅시작
		logger.info("chatDto enter {}",chatDto.toString());
		
		chatService.saveMsg(chatDto);
		template.convertAndSend("/sub/chat/room" + chatDto.getRoomId(), chatDto);
	}
	
	@MessageMapping(value = "/chat/message")
	public void message(ChatDto chatDto) {
		template.convertAndSend("/sub/chat/room" + chatDto.getRoomId(), chatDto);
		chatService.saveMsg(chatDto);
		logger.info("chatLog message {}",chatDto.toString());
	}
	
	@MessageMapping(value = "/chat/exit")
	public void exit(ChatDto chatDto) {
		template.convertAndSend("/sub/chat/room" + chatDto.getRoomId(), chatDto);
		chatDto.setIsEnd(1); // 채팅종료
		chatService.saveMsg(chatDto);
		logger.info("chatLog exit {}",chatDto.toString());
	}
	
//	-------일대일채팅--------
	
	@MessageMapping(value = "/chat/enter11")
	public void enter11(ChatDto chatDto) {
		chatDto.setIsStart(1); 
		
		chatService.saveMsg(chatDto);
		logger.info("enter11 chatDto {}",chatDto.toString());
		
		//채팅방의 주소는 각자의 아이디로 한다. 
		template.convertAndSend("/sub/chat/room11" + chatDto.getUserID(), chatDto);
	}
	
	@MessageMapping(value = "/chat/message11")
	public void message11(ChatDto chatDto) {
		chatService.saveMsg(chatDto);
		template.convertAndSend("/sub/chat/room11" + chatDto.getRoomId(), chatDto);
		logger.info("chatLog {}",chatDto.toString());
	}
	
	@MessageMapping(value = "/chat/exit11")
	public void exit11(ChatDto chatDto) {
		template.convertAndSend("/sub/chat/room11" + chatDto.getRoomId(), chatDto);
		chatDto.setIsEnd(1); // 채팅종료
		chatService.saveMsg(chatDto);
		logger.info("chatLog {}",chatDto.toString());
	}
	
//  ---------------알람 보내기 --------------
    
  @GetMapping(value = "/notice")
//  @MessageMapping
  public String messageAlart(String username, HttpSession session) throws IOException {
      
      web.dto.Member member = new web.dto.Member();
      member.setId(username);
//    int memberNo = memberService.getMemberNo(member);
      int memberNo = memberService.getMemberNo(member);

      List<MyPlant> forAlarmList = wpService.isWaterToday(memberNo);
      Gson gson = new Gson();
      
      if(forAlarmList.size()!=0) {
          template.convertAndSend("/sub/notice"+username, gson.toJson(forAlarmList));
      }else {
          String[] str = {"noPlantsWantWater","아직 물이 부족하지 않아요."};
          template.convertAndSend("/sub/notice"+username, gson.toJson(str));
      }
      return "chat/empty";
  }    
  
  //카트가 비어있지 않으면 알람에 추가 
  @GetMapping(value = "/chkCarts")
  public String messageChkCarts(String username, HttpSession session) {
	  
	  	int memberNo = (Integer) session.getAttribute("memberNo");
	  	 Gson gson = new Gson();
		List<CartList> cartList = shopService.cartList(memberNo);
		if(cartList.size()!=0) {
			template.convertAndSend("/sub/chkCarts"+username, gson.toJson(cartList));
		}else {
	          String[] str = {"emptyCart","카트가 비어 있어요."};
	          template.convertAndSend("/sub/chkCarts"+username, gson.toJson(str));
	      }
	      return "chat/empty";
	      
  }

  //주문한 내역이 있으면 알람에 추가 
  @GetMapping(value = "/chkOrders")
  public String messageChkOrders(String username, HttpSession session) {
	  	
	  	int memberNo = (Integer) session.getAttribute("memberNo");
	  	Order order = new Order();
	  	Gson gson = new Gson();
	  
	  	order.setMemberNo(memberNo);
	  	logger.info("{}","/sub/chkOrders"+username);
	  	List<OrderList> orderList = shopService.orderList(order);
	  	logger.info("{}",gson.toJson(orderList));
	  	if(orderList.size()!=0) {
			template.convertAndSend("/sub/chkOrders"+username, gson.toJson(orderList));
		}else {
	          String[] str = {"noOrderExists","주문 내역이 없어요."};
	          template.convertAndSend("/sub/chkOrders"+username, gson.toJson(str));
	      }
	      return "chat/empty";
  }
	  //주문후 배송이 완료되면 알람에 추가 (미구현)
  
}