package web.controller;

import java.io.IOException;
import java.io.Writer;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import web.dto.Reply;
import web.service.face.BoardService;

@Controller
@RequestMapping("/reply")
public class ReplyController {

	@Autowired private BoardService boardService;	
	
	@RequestMapping(value="/insert")
	public String insert(Reply reply , Model model , HttpSession session) {
		
		System.out.println("리플확인" +reply.getBoardno() );
		System.out.println("리플확인" +reply.getContent() );
		System.out.println("리플확인" +reply.getBdate() );
		
		//작성자 아이디 가져오기
		reply.setId((String) session.getAttribute("id"));
		boardService.insertReply(reply);
		
		return "redirect:/board/freeView?boardno="+reply.getBoardno();
		
		
	}
	
	@RequestMapping(value="/delete")
	public void delete(Reply reply , Writer writer , Model model ) {
		
		boolean success = boardService.deleteReply(reply);
		
		try {
			writer.append("{\"success\":"+success+"}");
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	

	
}
