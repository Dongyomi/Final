package web.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import web.controller.BoardController;
import web.dao.face.BoardDao;
import web.dao.face.RecommendDao;
import web.dao.face.ReplyDao;
import web.dto.Board;
import web.dto.BoardFile;
import web.dto.Recommend;
import web.dto.Reply;
import web.service.face.BoardService;
import web.util.Paging_board;

@Service
public class BoardServiceImpl implements BoardService{

	private Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);
	
	
	@Autowired ReplyDao replyDao;
	@Autowired BoardDao boardDao;
	@Autowired private RecommendDao recommendDao;
	@Autowired private ServletContext context;
	
	@Override
	public Paging_board getPaging(Paging_board paramData) {
		
		//총 게시글 수 조회
		int totalCount = boardDao.selectCntAll();
		
		//페이징 계산
		Paging_board paging = new Paging_board(totalCount , paramData.getCurPage());
		
		//검색 페이징 계산
		paging.setSearch(paramData.getSearch());
		
		return paging;
	}

	@Override
	public List<Board> list(Paging_board paging) {
		return boardDao.selectFreeList(paging);
	}

	
	@Override
	public Board view(Board viewBoard) {
		
		//조회수 증가
		boardDao.hit(viewBoard);
		
		//상세보기 조회결과 리턴
		return boardDao.select(viewBoard);
	}


	@Override
	public void write(Board board, MultipartFile file) {

		if("".equals(board.getBtitle() )) {
			board.setBtitle("(not title)");
			
		}
		
		boardDao.insertBoard(board);
		
		//----------------------------------------------------
		//파일 처리
		
		//빈파일인 경우
		
		if( file.getSize() <=0 ) {
			return;
		}
		
		//파일이 저장될 경로
		String storedPath = context.getRealPath("upload");
		File storedFolder =  new File(storedPath);
		if ( !storedFolder.exists()) {
			storedFolder.mkdir();
			
		}
		
		//파일이 저장될 이름
		String originName = file.getOriginalFilename();
		String storedName = originName + UUID.randomUUID().toString().split("-")[4];
		
		//저장될 파일 정보 객체
		File dest = new File ( storedFolder , storedName );
		
		try {
			file.transferTo(dest);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//-----------------------------------------------------
		
		BoardFile boardFile = new BoardFile();
		boardFile.setBoardNo(board.getBoardno());
		boardFile.setOriginName(originName);
		boardFile.setStoredName(storedName);
		
		boardDao.insertFile(boardFile);
	
	}

	@Override
	public BoardFile getAttachFile(Board viewBoard) {
		return boardDao.selectBoardFileByBoardno(viewBoard);
	} 

	@Override
	public BoardFile getFile(BoardFile boardFile) {
		return boardDao.selectBoardFileByFileNo(boardFile);
	}


	@Override
	public void freeUpdate(Board board) {
		
		//제목없음 처리
		if("".equals(board.getBtitle() )) {
			board.setBtitle("(not title)");
			
		}
		
		boardDao.freeUpdate(board);
		
		
	}

	
	//자유게시판 파일업로드
	@Override
	public void freeUpdate(Board board , MultipartFile file) {
		
		this.freeUpdate(board);
		
		//업로드된 파일처리
		//빈파일인 경우
		
		if( file.getSize() <=0 ) {
			return;
		}
		
		//파일이 저장될 경로
		String storedPath = context.getRealPath("upload");
		File storedFolder =  new File(storedPath);
		if ( !storedFolder.exists()) {
			storedFolder.mkdir();
			
		}
		
		//파일이 저장될 이름
		String originName = file.getOriginalFilename();
		String storedName = originName + UUID.randomUUID().toString().split("-")[4];
		
		//저장될 파일 정보 객체
		File dest = new File ( storedFolder , storedName );
		
		try {
			file.transferTo(dest);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//-----------------------------------------------------
		
		BoardFile boardFile = new BoardFile();
		boardFile.setBoardNo(board.getBoardno());
		boardFile.setOriginName(originName);
		boardFile.setStoredName(storedName);
		
		//기존의 첨부파일 정보를 삭제한다
		boardDao.deleteFile(board);
		
		boardDao.insertFile(boardFile);
		
	}


	//자유게시판 글 삭제
	@Override
	public void freeDelete(Board board) {
		
		boardDao.deleteFile(board);
		boardDao.freeDelete(board);
	}

	
	//리플 인서트
	@Override
	public void insertReply(Reply reply) {
		replyDao.insertReply(reply);
	}
	

	//자유게시판 리플 리스트
	@Override
	public List<Reply> getReplyList(Board board) {
		return replyDao.selectReply(board);
	}

	@Override
	public boolean deleteReply(Reply reply) {
		
		replyDao.deleteReply(reply);
		
		if(replyDao.countReply(reply) > 0 ) {
			return false;
			
		}else {
			
			return true;
			
		}
		
	}

	
	//--------------------------------------------------------------------------------------
	
	
	
	
	
	@Override
	public Paging_board getphotoPaging(Paging_board photoParam) {
		//총 게시글 수 조회
		int totalCount = boardDao.photoSelectCntAll();
		
		//페이징 계산
		Paging_board photoPaging = new Paging_board(totalCount , photoParam.getCurPage());
		
		
		return photoPaging;
	}
	
	
	//사진게시판 리스트
	@Override
	public List<Board> photoList(Paging_board photoPaging) {
		
		return boardDao.selectPhotoList(photoPaging);
	}


	//사진게시판 상세보기
	@Override
	public Board photoView(Board viewBoard) {
		
		//조회수 증가
		boardDao.photoHit(viewBoard);
		
		//상세보기 조회결과 리턴
		
		return boardDao.photoSelect(viewBoard);
	}

	//사진게시판 글쓰기
	@Override
	public void photoWrite(Board board, List<MultipartFile> file) {
		
		
		if("".equals(board.getBtitle() )) {
			board.setBtitle("(not title)");
			
		}
		
		boardDao.photoinsertBoard(board);
	
		
//		------------------------------------------------------------------
		for (MultipartFile mf : file) {
			
		
		logger.info("파일다중파일!!! {} " , mf);
		
		
		
		//빈파일인 경우
		if( mf.getSize() <=0 ) {
			return;
		}
		
		//파일이 저장될 경로
		String storedPath = context.getRealPath("upload");
		File storedFolder =  new File(storedPath);
		if ( !storedFolder.exists()) {
			storedFolder.mkdir();
			
		}
		
		//파일이 저장될 이름
		String originName = mf.getOriginalFilename();
		String storedName = originName + UUID.randomUUID().toString().split("-")[4];
		
		//저장될 파일 정보 객체
		File dest = new File ( storedFolder , storedName );
		
		try {
			mf.transferTo(dest);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		
		//-----------------------------------------------------
		
		BoardFile boardFile = new BoardFile();
		boardFile.setBoardNo(board.getBoardno());
		boardFile.setOriginName(originName);
		boardFile.setStoredName(storedName);
		
		boardDao.photoinsertFile(boardFile);
		
		logger.info("파일확인{} " , boardFile);
		
		}

		
	}
	
	@Override
	public List<BoardFile> photogetFile(BoardFile viewBoard) {
		return boardDao.selectPhotoBoardFileByBoardno(viewBoard);
	}
	
	@Override
	public List<BoardFile> getPhotoAttachFile(Board viewBoard) {
		return boardDao.selectPhotoBoardFileByBoardno(viewBoard);
	}
	
	@Override
	public void photoUpdate(Board board) {
		//제목없음 처리
		if("".equals(board.getBtitle() )) {
			board.setBtitle("(not title)");
		}
		boardDao.photoUpdate(board);
		
	}
	
	@Override
	public void photoUpdate(Board board, MultipartFile file) {
		
		this.photoUpdate(board);
		
		//업로드된 파일처리
		//빈파일인 경우
		
		if( file.getSize() <=0 ) {
			return;
		}
		
		//파일이 저장될 경로
		String storedPath = context.getRealPath("upload");
		File storedFolder =  new File(storedPath);
		if ( !storedFolder.exists()) {
			storedFolder.mkdir();
			
		}
		
		//파일이 저장될 이름
		String originName = file.getOriginalFilename();
		String storedName = originName + UUID.randomUUID().toString().split("-")[4];
		
		//저장될 파일 정보 객체
		File dest = new File ( storedFolder , storedName );
		
		try {
			file.transferTo(dest);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//-----------------------------------------------------
		
		BoardFile boardFile = new BoardFile();
		boardFile.setBoardNo(board.getBoardno());
		boardFile.setOriginName(originName);
		boardFile.setStoredName(storedName);
		
		//기존의 첨부파일 정보를 삭제한다
		boardDao.deletePhotoFile(board);
		
		boardDao.photoinsertFile(boardFile);
		
	}
	
	
	@Override
	public void photoDelete(Board board) {
		
		boardDao.deletePhotoFile(board);
		boardDao.photoDelete(board);
		
	}
	
	//페이징 첨부파일
	@Override
	public Paging_board getPhotoFile(Paging_board paging) {
		
		//총 게시글 수 조회
		int totalCount = boardDao.fileSelectCntAll();
		
		//페이징 계산
		Paging_board photoPaging = new Paging_board(totalCount , paging.getCurPage());
		
		
		return photoPaging;
		
	}
	
	@Override
	public List<BoardFile> getFilePhotoList(Paging_board paging) {
		return boardDao.getFilePhotoList(paging);
	}

	
	@Override
	public boolean isRecommend(Recommend recommend) {
		
		int cnt = recommendDao.selectCntRecommend(recommend);
		
		if(cnt > 0) { //추천했음
			return true;
			
		} else { //추천하지 않았음
			return false;
			
		}
	}

	
	@Override
	public int getTotalCntRecommend(Recommend recommend) {
		return recommendDao.selectTotalCntRecommend(recommend);
	}

	@Override
	public boolean photoRecommend(Recommend recommend) {
		
		if( isRecommend(recommend) ) { //추천한 상태
			recommendDao.deleteRecommend(recommend);
			
			return false;
			
		} else { //추천하지 않은 상태
			recommendDao.insertRecommend(recommend);
			
			return true;
		}
	}


	
	@Override
	public List<BoardFile> getAttachPhotoFile(Board viewBoard) {
		return boardDao.selectPhotoBoardFile(viewBoard);
	}

	@Override
	public void insertPhotoReply(Reply photoReply) {
		replyDao.insertPhotoReply(photoReply);
		
	}

	@Override
	public List<Reply> getReplyphotoList(Board board) {
		return replyDao.selectPhotoReply(board);
	}
}
