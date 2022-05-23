package web.service.face;


import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import web.dto.Board;
import web.dto.BoardFile;
import web.dto.Recommend;
import web.dto.Reply;
import web.util.Paging_board;



public interface BoardService {

	
	/**
	 * 
	 * 게시글 목록을 위한 페이지 객체 생성
	 * 
	 * @param paramData -curPage를 저장하고있는 객체
	 * @return - 계산이 완료된 Paging 객체
	 */
	public Paging_board getPaging(Paging_board paramData);

	/**
	 * 
	 * 페이징이 적용된 게시글 목록 조회
	 * 
	 * @param paging
	 * @return
	 */
	public List<Board> list(Paging_board paging);

	/**
	 * 게시글 상세보기
	 * 
	 * @param viewBoard
	 * @return
	 */
	public Board view(Board viewBoard);

	/**
	 * 게시글 정보, 첨부파일을 함께 처리한다
	 * 
	 * @param board - 게시글 정보 DTO
	 * @param file - 첨부파일 정보 DTO
	 */
	public void write(Board board, MultipartFile file);

	/**
	 * 
	 * 게시글 번호를 이용하여 업로드된 파일 정보를 조회한다
	 * 
	 * @param viewBoard - 조회할 게시글 번호를 가진 객체
	 * @return 첨부파일의 정보 
	 */
	
	public BoardFile getAttachFile(Board viewBoard);

	/**
	 * 파일번호를 이용해서 업로드된 파일 정보를 조회
	 * 
	 * @param boardFile 조회할 게시글 번호를 가진 객체
	 * @return 첨부파일의 정보
	 */
	public BoardFile getFile(BoardFile boardFile);

	/**
	 * 
	 * 게시글 번호를 이용하여 수정 처리
	 * 
	 * @param board
	 */
	public void freeUpdate(Board board);
	
	/**
	 * 게시글 번호를 이용하여 수정 처리
	 * 첨부파일 수정 처리
	 * 
	 * @param board
	 * @param file
	 */

	public void freeUpdate(Board board , MultipartFile file);

	/**
	 * 
	 * 게시물+ 첨부파일 을 삭제한다
	 * 
	 * @param board 삭제할 게시물의 글번호
	 */
	public void freeDelete(Board board);

	/**
	 * 
	 * 댓글 삽입
	 * @param reply
	 */
	public void insertReply(Reply reply);
	
	
	/**
	 * 댓글리스트
	 * 
	 * @param viewBoard
	 * @return
	 */
	public List<Reply> getReplyList(Board board);

	/**
	 * 댓글삭제
	 * 
	 * @param reply
	 * @return
	 */
	public boolean deleteReply(Reply reply);

	/**
	 * 
	 * 사진게시판 페이징 처리
	 * 
	 * @param paging
	 * @return
	 */
	public Paging_board getphotoPaging(Paging_board photoParam);

	/**
	 * 
	 * 페이징이 적용될 사진게시판 조회
	 * @param photoPaging
	 * @return
	 */
	public List<Board> photoList(Paging_board photoPaging);

	
	/**
	 * 사진게시판 글 상세보기
	 * 
	 * @param viewBoard
	 * @return
	 */
	public Board photoView(Board viewBoard);

	


	/**
	 * 
	 * 사진게시판 파일번호를 이용해서 업로드된 파일 정보를 조회
	 * 
	 * @param boardFile
	 * @return
	 */
	public List<BoardFile> photogetFile(BoardFile boardFile);
	
	

	/**
	 * 
	 * 사진게시글 번호를 이용하여 업로드된 파일 정보를 조회한다
	 * 
	 * @param board
	 * @return
	 */
	public BoardFile getPhotoAttachFile(Board viewBoard);

	/**
	 * 
	 * 사진게시물 업데이트
	 * @param board
	 * @param file
	 */
	public void photoUpdate(Board board);

	/**
	 * 
	 * 게시물이랑 첨부파일 업데이트 
	 * @param board
	 * @param file
	 */
	public void photoUpdate(Board board, MultipartFile file);
	/**
	 * 
	 * 사진게시물과 파일을 업데이트
	 * @param board
	 * @param file
	 */
	public void photoWrite(Board board, List<MultipartFile> file);

	/**
	 * 사진게시물 삭제
	 * 
	 * @param board
	 */
	public void photoDelete(Board board);
	
	/**
	 * 
	 * 페이징에 첨부파일 가져오기
	 * 
	 * @param paging
	 * @return
	 */
	public Paging_board getPhotoFile(Paging_board paging);
	
	/**
	 * 사진게시판 섬네일 불러오기
	 * @param paging
	 * @return
	 */
	public List<BoardFile> getFilePhotoList(Paging_board paging);

	/**
	 * 추천상태
	 * 
	 * @param recommend
	 * @return
	 */
	public boolean isRecommend(Recommend recommend);

	/**
	 * 게시글 전체의 추천수
	 * 
	 * @param recommend
	 * @return
	 */
	public int getTotalCntRecommend(Recommend recommend);

	/**
	 * 게시판 추천정보 토글
	 * 
	 * @param recommend
	 * @return
	 */
	public boolean photoRecommend(Recommend recommend);

	
	/**
	 * 
	 * 첨부파일 리스트 전달 
	 * @param viewBoard
	 * @return
	 */
	public List<BoardFile> getAttachPhotoFile(Board viewBoard);

	/**
	 * 포토 리플 리스트 인서트
	 * @param reply
	 */
	public void insertPhotoReply(Reply photoReply);
	
	/**
	 * 
	 * 포토리플 리스트
	 * 
	 * @param viewBoard
	 * @return
	 */
	public List<Reply> getReplyphotoList(Board viewBoard);

	





}
