
package web.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import web.dto.Board;
import web.dto.BoardFile;
import web.dto.Recommend;
import web.dto.Reply;
import web.service.face.BoardService;
import web.service.face.MemberService;
import web.util.Paging_board;

@Controller
@RequestMapping(value = "/board")
public class BoardController {
	 
  
	@Autowired private BoardService boardService;
	@Autowired private MemberService memberService;
	
	
	private Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping(value="/error")
	public void boardError() {
		
	}
	
	@RequestMapping(value = "/freeList")
	public void list(Paging_board ParamData , Model model) {
		
		logger.info(" board/freeList [get]");
		
		//페이징계산
		Paging_board paging = boardService.getPaging( ParamData );
//		logger.info("paging페이징계산{}" , paging);
		
		//게시글 목록 조회
		List<Board> list = boardService.list(paging);
//		for(Board b : list) {
//			logger.info("목록조회{}" , b);
//		} 
		
		model.addAttribute("paging" , paging);
		model.addAttribute("list" , list);
		     
	}
	 
	@RequestMapping("/freeView")
	public String view(Board viewBoard , Model model , HttpSession session) {
		logger.info("freeView게시글보기{}" , viewBoard);
		
		//잘못된 게시글 번호 처리
		if( viewBoard.getBoardno() < 1 ) {
			
			return "redirect:/board/freeList";
		}

		//게시글조회
		viewBoard = boardService.view(viewBoard);
		logger.info("조회된게시글{}" , viewBoard);
		
		//모델값 전달 - 게시글
		model.addAttribute("viewBoard" , viewBoard);
		
		//첨부파일 정보 모델값 전달
		BoardFile boardFile = boardService.getAttachFile(viewBoard);
		model.addAttribute("boardFile" , boardFile);
		
		//추천 상태 조회
		Recommend recommend = new Recommend();
		recommend.setBoardno(viewBoard.getBoardno());
		recommend.setId((String) session.getAttribute("id"));
		
		//추천 상태 전달
		boolean isRecommend = boardService.isRecommend(recommend);
		model.addAttribute("isRecommend" , isRecommend);
		
		//게시글의 전체 추천수
		model.addAttribute("cntRecommend" , boardService.getTotalCntRecommend(recommend));
		
		//댓글 리스트 전달
		Reply reply = new Reply();
		List<Reply> replyList = boardService.getReplyList(viewBoard);
		model.addAttribute("replyList" , replyList);
		
		logger.info("리플아이디확인{} " , replyList);
		
		return "board/freeView";
	}

	
 
	@GetMapping("/freeWrite")
	public void write() { }
	
	@Transactional
	@PostMapping("/freeWrite")
	public String writeProc(Board board , MultipartFile file , HttpSession session) {
		
		logger.info("/write [post]");
		logger.info("Board{}" , board);
		logger.info("file{}" , file);
		
		board.setId((String) session.getAttribute("id"));
		board.setNick((String) session.getAttribute("nick"));
		logger.info("Board{}" , board);
		
//		board.setId((String) session.getAttribute("id"));
//		board.setNick((String) session.getAttribute("nick"));
//		logger.info("아이디/닉네임 세션{}" , board);
		
//		board.setId("id");
//		board.setNick("nick");
//		
		boardService.write(board, file);
		
		return "redirect:/board/freeList";
		
	}
	
	
	@RequestMapping("/freeDownload")
	public String download(BoardFile boardFile , Model model) {
		boardFile = boardService.getFile(boardFile);
		model.addAttribute("downFile" , boardFile);
		
		return "boarddown";
	}
	
	@Transactional
	@GetMapping("/freeUpdate")
	public String update(Board board , Model model) {
		logger.info("/update확인{}" , board);
		
		//잘못된 게시글 번호 처리
		if( board.getBoardno() < 1 ) {
			return "redirect:/board/freeList";
		}
		
		//수정할 게시글의 상세보기
		board = boardService.view(board);
		model.addAttribute("updateFreeBoard" , board);
		
		//첨부파일 정보 모델값 전달
		BoardFile boardFile = boardService.getAttachFile(board);
		model.addAttribute("boardFile" , boardFile);
		
		return "board/freeUpdate";
		 
	}
	
	@Transactional
	@PostMapping("/freeUpdate")
	public String updateProc(Board board , MultipartFile file) {
		logger.info("update[post]확인 {}" , board);
		logger.info("Board{}" , board);
		logger.info("file{}" , file);
		
		boardService.freeUpdate(board , file);
		
		return "redirect:/board/freeView?boardno=" + board.getBoardno();
	}
	 
	@Transactional
	@RequestMapping("/freeDelete")
	public String delete(Board board) {
		
		boardService.freeDelete(board);
		
		 return "redirect:/board/freeList";
	 }

	//--------------------------------------------------------------------------
	

	
	@RequestMapping(value="/photoList")
	public void pList (Paging_board photoParam , Model model) {
		
		   logger.info(" board/photoList [get]");
		      
		      //페이징계산
		      Paging_board photoPaging = boardService.getPaging(photoParam);
		      System.out.println("dfdasfsdfasdfohasfghoashugasgh총페이지"+ photoPaging.getTotalCount());
		      //게시글 목록 조회
		      List<Board> photoList = boardService.photoList(photoPaging);

		      
		      Paging_board filePaging = boardService.getPhotoFile(photoParam);
		      List<BoardFile> fileList = boardService.getFilePhotoList(filePaging);
		      
		      model.addAttribute("paging" , filePaging);
		      model.addAttribute("list" , photoList);
		      model.addAttribute("fileList" , fileList);
		      
		      
		      
		      logger.info("포토리스트{}" , photoList);
		      logger.info("파일리스트{}" , fileList);
	}
	 
	
	@RequestMapping(value="/photoView")
	public String photoView(Board viewBoard , Model model , HttpSession session) {
		
		logger.info("photoView게시글보기{}" , viewBoard);
		
		//잘못된 게시글 번호 처리
		if( viewBoard.getBoardno() < 1 ) {
			
			return "redirect:/board/photoList";

		}
		
		//사진게시글 조회
		viewBoard = boardService.photoView(viewBoard);
		logger.info("사진조회{} , viewBoard");
		
		//모델값 전달 - 게시글
		model.addAttribute("viewBoard" , viewBoard);
			
		//첨부파일 정보 모델값 전달
		List<BoardFile> boardFile = boardService.getAttachPhotoFile(viewBoard);
		model.addAttribute("boardFile" , boardFile);	
		
		//추천 상태 조회 
		Recommend recommend = new Recommend();
		recommend.setBoardno(viewBoard.getBoardno());	//게시글 번호
		recommend.setId((String) session.getAttribute("id"));	//로그인한 아이디
		
		//추천 상태 전달
		boolean isRecommend = boardService.isRecommend(recommend);
		model.addAttribute("isRecommend" , isRecommend);
		
		//게시글의 전체 추천수
		model.addAttribute("cntRecommend" , boardService.getTotalCntRecommend(recommend));
		
		
	
		//댓글 리스트 전달
		Reply reply = new Reply();
		List<Reply> replyphotoList = boardService.getReplyphotoList(viewBoard);
		model.addAttribute("replyphotoList" , replyphotoList);
		
		logger.info("리플아이디 전달 {} " , replyphotoList);
		
		
		
		logger.info("포토보드파일{} " , boardFile);
		
		return "board/photoView";
	}
	
	
	@RequestMapping("/photoWrite")
	public void photoWrite() { }
	

	@Transactional
	@PostMapping(value="/photoWrite")
	public String photoWriteProc(Board board , @RequestParam(value="file") List<MultipartFile> file, HttpSession session) {
	logger.info("/photowrite [post]");

	logger.info("멀티파트 리스트 {} " , file);

	
	
	board.setId((String) session.getAttribute("id"));
	board.setNick((String) session.getAttribute("nick"));
	
	boardService.photoWrite(board, file);
	
	
	return "redirect:/board/photoList";
	
	}
	
	
	
	//사진게시판 첨부파일 다운로드
	@RequestMapping("/photoDownload")
	public String photoDownload(BoardFile boardFile , Model model) {
		
		List<BoardFile> boardFile1 = boardService.photogetFile(boardFile);
		model.addAttribute("downFile" , boardFile1);
		
		
		return "redirect:/board/photoView?boardno=" + boardFile.getBoardNo();
	}
	
	//사진게시판 첨부파일 업데이트
	@Transactional
	@RequestMapping("/photoUpdate")
	public String photoUpdate(Board board , Model model) {
		logger.info("/photoUpdate확인{}" , board);
		
		//잘못된 게시글 번호 처리
		if( board.getBoardno() < 1 ) {
			return "redirect:/board/photoList";
		}

		logger.info("보드넘버가져오기!!!!!! {}" , board);
		
		//수정할 게시글의 상세보기
		board = boardService.photoView(board);
		model.addAttribute("updatePhotoBoard" , board);
		
		//첨부파일 정보 모델값 전달
		BoardFile boardFile = boardService.getPhotoAttachFile(board);
		model.addAttribute("boardFile" , boardFile);
		
		
		
		return "board/photoUpdate";
		
	}
	

	@Transactional
	@PostMapping("/photoUpdate")
	public String photoUpdateProc(Board board , MultipartFile file) {
		logger.info("update[post]확인 {}" , board);
		
		boardService.photoUpdate(board , file);
		
		return "redirect:/board/photoView?boardno=" + board.getBoardno();
	}
	
	@Transactional
	@RequestMapping("/photoDelete")
	public String photoDelete(Board board) {
		
		boardService.photoDelete(board);
		
		 return "redirect:/board/photoList";
	 }
	

	//사진게시판 추천 컨트롤러
	@RequestMapping("/photoRecommend") @ResponseBody
	public HashMap<String, Object> recommend(Recommend recommend  , HttpSession session) {
		
		
		HashMap<String, Object>	map = new HashMap<String, Object>();
		
		
		//추천정보 토글
		recommend.setId((String) session.getAttribute("id"));
		boolean result = boardService.photoRecommend(recommend);
		
		//추천 수 
		int cnt = boardService.getTotalCntRecommend(recommend);
		
		map.put("result" , result);
		map.put("cnt" , cnt);
		
		
		return map;
		
	}
	
	//자유게시판 추천 컨트롤러 
	@RequestMapping("/freeRecommend") @ResponseBody
	public HashMap<String, Object> freerecommend(Recommend recommend  , HttpSession session) {
		
		
		HashMap<String, Object>	map = new HashMap<String, Object>();
		
		
		//추천정보 토글
		recommend.setId((String) session.getAttribute("id"));
		boolean result = boardService.photoRecommend(recommend);
		
		//추천 수 
		int cnt = boardService.getTotalCntRecommend(recommend);
		
		map.put("result" , result);
		map.put("cnt" , cnt);
		
		
		return map;
		
	}
	
	
}
