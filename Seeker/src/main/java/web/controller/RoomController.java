package web.controller;

import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import web.dto.ChatDto;
import web.dto.ChatRoomDto;
import web.service.face.ChatService;

@Controller
public class RoomController {

	private static final Logger logger = LoggerFactory.getLogger(RoomController.class);
	
	@Autowired ChatService chatService;
	
//	------------- 다중 채팅 로직 ----------------------
	
	@GetMapping(value = "/chat/rooms")
	public void rooms(Model model) {
		List<ChatRoomDto> list = chatService.findAllRooms();
		model.addAttribute("list", list);
	}
	
	@GetMapping("/chat/room")
	public String getRoom(String roomId, Model model, HttpSession session) {
		ChatRoomDto room = chatService.findRoomById(roomId);
		String userid = (String) session.getAttribute("id");
		logger.info("채팅방 입장시 전달되는 모델값 {}", room);
		model.addAttribute("room",room);
		
		//세션 목록에 접속중인 유저명 추가 
		chatService.addSession(room, userid);
		return "chat/room";
	}
	
	@PostMapping(value = "/chat/room")
	public String create(String roomName, HttpSession session) {
		
		logger.info(roomName);
		ChatRoomDto chatroom = chatService.createRoom(roomName);
		String userid = (String) session.getAttribute("id");
		String roomId = chatroom.getRoomId(); // 생성한 채팅방의 주소
		return "redirect:/chat/room?roomId="+roomId; // 생성된 방으로 리턴
			
	}
	
	@ResponseBody
	@GetMapping("/chat/exit")
	public void getRoom(String roomId, HttpSession session) {
		ChatRoomDto room = chatService.findRoomById(roomId);
		String userid = (String) session.getAttribute("id");
		chatService.deleteSession(room, userid);
		
		ChatDto chatDto = new ChatDto();
		//채팅방 접속자 0명일시 채팅방 삭제 
		if (room.nameList.size() == 0)
			logger.info("마지막 접속자 {}", chatDto);
			logger.info("채팅방 접속자 삭제 로직 {}", room.nameList.size() == 0);
			chatDto.setRoomId(roomId);
			chatDto.setUserID(userid);
			chatDto.setIsEnd(1);
			chatDto.setChatLog("퇴장");
			chatService.saveMsg(chatDto); // 퇴장 문구 db 삽입
			
			chatService.deleteRoom(room); //채팅방 삭제
	}
	
	
//	-------------- 일대일 채팅 로직 ---------------
	
	//일반회원 접근
	@GetMapping("/chat/room11")
	
	public String get11Room(String roomId, HttpSession session, Model model) {
		roomId = (String) session.getAttribute("id"); 
		logger.info("roomid", roomId);
		model.addAttribute("roomId", roomId);
		getPastChat(roomId, model);
		//지난 채팅 내역 표시하기 
		 return "chat/room11";
	}
	
	//관리자 접근
	@GetMapping("/chat/room11Adm")
	public String get11RoomAdm(String roomId, HttpSession session, Model model) {
		logger.info("11chat", roomId);
		model.addAttribute("roomId", roomId);
		//지난 채팅 내역 표시하기 
		getPastChat(roomId, model);
		
		 return "chat/room11";
	}
	
	@GetMapping("/chat/getPastChat")
	public String getPastChat(String roomId, Model model){
		logger.info("getPastChat {}", roomId);
		List<ChatDto> pastChat =  chatService.getPastChat(roomId);
		logger.info("getPastChat {}", pastChat.toString());
		model.addAttribute("pastChat", pastChat);
		return "jsonView";
	}
	
	//접속자 리스트 가져오기 
	@ResponseBody // 요청 - 객체 변환
	@RequestMapping("/chat/participant")	
	public Set<String> nameList(String roomId){
		System.out.println("participant roomId"+roomId);
		ChatRoomDto room = chatService.findRoomById(roomId);
		System.out.println("participant room"+room.toString());
		Set<String> list = room.nameList;
		System.out.println("list"+list);
		return list;
	}
	
	
	//--------------------기타 처리 --------------
	
//	다운로드는 chat.jsp 내에서 비동기적으로 처리되므로
//  따로 뷰를 지정한다.
// 	jsp 대신 파일 객체를 반환하므로, resolver 설정 + view 생성 클래스 필요
	@RequestMapping("/chat/logdown")
	public String chatLogDown(ChatDto chatDto, HttpServletRequest request, Model model) {
		
		String filepath = chatService.getLog(chatDto); // ajax json값이 넘어옴 
		request.setAttribute("filepath",filepath);
		logger.info("logdown() {}" , chatDto.toString());
		return "down";
	}
	
//	@PostMapping("/chat/room11")
//	public String get11Room(HttpSession session) {
//		return "redirect: /chat/room11?roomId="+roomId;
//	}
//	
//	@ResponseBody
//	@GetMapping("/chat/exit")
//	public void getRoom(String roomId, HttpSession session) {
//		ChatRoomDto room = chatService.findRoomById(roomId);
//		String userid = (String) session.getAttribute("testuser");
//		chatService.deleteSession(room, userid);
//		
//		ChatDto chatDto = new ChatDto();
//		//채팅방 접속자 0명일시 채팅방 삭제 
//		if (room.nameList.size() == 0)
//			chatDto.setRoomId(roomId);
//			chatDto.setIsEnd(1);
//			chatDto.setChatLog("퇴장");
//			chatService.saveMsg(chatDto); // 퇴장 문구 db 삽입
//			
//			chatService.deleteRoom(room); //채팅방 삭제
//	}
	
	
//	-------------------------------
}