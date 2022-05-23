package web.dao.face;

import java.util.List;

import web.dto.Board;
import web.dto.Reply;

public interface ReplyDao {

	
	
	/**
	 * 
	 * 댓글삽입
	 * 
	 * @param reply
	 */
	void insertReply(Reply reply);


	/**
	 * 
	 * 댓글 목록 조회
	 * @param board
	 * @return
	 */

	public List<Reply> selectReply(Board board);


	/**
	 * 
	 * 댓글 삭제
	 * @param reply
	 */
	public void deleteReply(Reply reply);


	/**
	 * 
	 * 댓글삭제에대한 0 성공 1 실패
	 * 
	 * @param reply
	 * @return
	 */
	public int countReply(Reply reply);

	/**
	 * 
	 * 사진 리플 넣기
	 * @param reply
	 */
	public void insertPhotoReply(Reply photoReply);
	/**
	 * 사진 리플 목록 조회
	 * 
	 * @param board
	 * @return
	 */

	public List<Reply> selectPhotoReply(Board board);



}
