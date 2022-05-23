package web.dao.face;

import java.util.List;

import web.dto.Board;
import web.dto.BoardFile;
import web.util.Paging_board;

public interface BoardDao {

	/**
	 * 
	 * 전체 게시글 수를 조회
	 * @return
	 */
	public int selectCntAll();

	/**
	 * 
	 * 페이징을 적용하여 게시글 목록 조회
	 * 
	 * @param paging
	 * @return
	 */
	public List<Board> selectFreeList(Paging_board paging);

	/**
	 * 조회된 게시글 조회수를 1 증가
	 * 
	 * @param viewBoard
	 */
	public void hit(Board viewBoard);

	/**
	 * 게시글 번호를 이용하여 게시글 조회
	 * 
	 * @param viewBoard
	 * @return
	 */
	public Board select(Board viewBoard);

	/**
	 * 게시물정보 삽입
	 * 
	 * @param board - 삽입할 게시글
	 */
	public void insertBoard(Board board);

	/**
	 * 첨부 파일 정보를 삽입한다
	 * 
	 * @param boardFile
	 */
	public void insertFile(BoardFile boardFile);

	/**
	 * DTO 의 게시글 번호 이용해서 첨부파일 정보를 조회한다
	 *  
	 * @param viewBoard - 조회할 게시글 번호
	 * @return - 조회된 첨부파일 정보
	 */
	public BoardFile selectBoardFileByBoardno(Board viewBoard);

	/**
	 * 
	 * 파일번호를 이용해서 첨부파일 정보를 조회
	 * 
	 * @param boardFile
	 * @return
	 */
	public BoardFile selectBoardFileByFileNo(BoardFile boardFile);

	/**
	 * 게시글 정보 수정
	 * 
	 * @param board
	 */
	public void freeUpdate(Board board);

	/**
	 * 
	 * 게시글을 참조하고 있는 모든 첨부파일을 삭제한다
	 * 
	 * @param boardFile 삭제할 게시글 번호 객체
	 */
	public void deleteFile(Board board);

	/**
	 * 게시글 정보 삭제
	 * 
	 * @param board
	 */
	public void freeDelete(Board board);

	/**
	 * 
	 * 사진게시판 수를 조회
	 * 
	 * @return
	 */
	public int photoSelectCntAll();

	/**
	 * 
	 * 사진게시판 리스트 조회
	 * 
	 * @param photoPaging
	 * @return
	 */
	public List<Board> selectPhotoList(Paging_board photoPaging);

	/**
	 * 사진게시판 글 상세보기
	 * 
	 * @param viewBoard
	 * @return
	 */
	public Board photoSelect(Board viewBoard);

	
	/**
	 * 사진게시판 정보 삽입
	 * 
	 * @param board
	 */
	public void photoinsertBoard(Board board);

	/**
	 * 사진게시판 첨부파일 삽입
	 * 
	 * @param boardFile
	 */
	public void photoinsertFile(BoardFile boardFile);

	
	/**
	 * DTO 의 게시글 번호 이용해서 첨부파일 정보를 조회한다
	 * 
	 * @param viewBoard
	 * @return
	 */
	public List<BoardFile> selectPhotoBoardFileByBoardno(BoardFile viewBoard);
	

	
	/**
	 * 파일번호를 이용해서 첨부파일 정보를 조회
	 * 
	 * @param viewBoard
	 * @return
	 */
	public List<BoardFile> selectPhotoBoardFileByBoardno(Board viewBoard);
	

	/**
	 * 사진게시물 정보 수정
	 * @param board
	 */
	public void photoUpdate(Board board);

	/*
	 * 사진게시물 첨부파일 삭제
	 * 
	 */
	public void deletePhotoFile(Board board);
	/**
	 * 사진게시판 게시물 삭제
	 * 
	 * @param board
	 */
	public void photoDelete(Board board);

	/**
	 * 사진게시판 조회수
	 * 
	 * @param viewBoard
	 */
	public void photoHit(Board viewBoard);

	/**
	 * 
	 * 페이징파일
	 * @return
	 */
	public int fileSelectCntAll();

	/**
	 * 
	 * 섬네일리스트 가져오기
	 * @param paging
	 * @return
	 */
	public List<BoardFile> getFilePhotoList(Paging_board paging);

	
	/**
	 * 첨부파일 리스트 가져오기 
	 * 
	 * @param viewBoard
	 * @return
	 */
	public List<BoardFile> selectPhotoBoardFile(Board viewBoard);

	
	
	

}
