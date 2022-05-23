package web.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import web.dto.ChatDto;
import web.dto.Member;
import web.service.face.ChatService;
import web.service.face.MemberService;

@Controller
public class AdminChatController {

	@Autowired ChatService chatService;
	@Autowired MemberService memberService;
	
	@RequestMapping(value = "/chat/chatList11")
	public String chatList11(Model model) {
		
		List<ChatDto> list = chatService.get11chatList();
		
		String nick = null;
		Member member = new Member();

		List<Member> memList = new ArrayList<Member>();
		
		for(ChatDto user : list) {
			member.setId(user.getUserID());
			//nick = memberService.getNick(member);
			nick = memberService.getNick(member);
			
			member.setNick(nick); 
			memList.add(member);
		}

		model.addAttribute("memList",memList);
		model.addAttribute("list",list);
		
		return "/chat/rooms11";
	}
}
