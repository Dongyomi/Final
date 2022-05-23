package web.dao.face;

import web.dto.Member;

public interface MemberDao {
	
	/**
	 * ID/PW가 일치하는 회원 수를 반환한다
	 * 	-> 로그인 인증에 활용한다
	 * 
	 * @param member - 조회할 ID/PW를 가진 객체
	 * @return 조회된 행 수
	 */
	public int selectCntMemberByLogin(Member member);
	
	/**
	 * ID와 일치하는 회원 정보를 반환한다.
	 * 
	 * @param id - ID와 일치하는 회원 정보 객체
	 * @return 조회된 회원 정보 객체
	 */	
	public Member selectMemberById(String id);
	
	
	/**
	 * email과 일치하는 회원 수를 반환한다
	 * 
	 * @param email
	 * @return 회원의 유/무 (유 : 1, 무 : 0)
	 */	
	public int selectCntMemberByEmail(String email);
	
	/**
	 * id와 일치하는 회원 수를 반환한다 
	 * 
	 * @param member - 조회하려는 회원의 id를 가진 객체
	 * @return 0 - 중복되지 않은 ID, 1 - 중복된 ID
	 */
	public int selectCntMemberById(String id);
	
	/**
	 * email과 일치하는 회원 정보를 반환한다.
	 * 
	 * @param email
	 * @return 조회된 회원 정보 객체
	 */	
	public Member selectMemberByEmail(String email);
	
	/**
	 * SocialEmail과 일치하는 회원 정보를 반환한다.
	 * 
	 * @param Socialemail
	 * @return 조회된 회원 정보 객체
	 */	
	public Member selectMemberBySocialEmail(String socialEmail);

	/**
	 * 입력된 회원 정보와 일치하는 회원 정보 중, 전화번호를 반환한다.
	 * 
	 * @param member
	 * @return 전화번호
	 */	
	public Member selectMemberByMember(Member member);
	
	/**
	 * 신규 회원의 정보를 새롭게 삽입한다
	 * 
	 * @param member - 신규 회원 정보
	 */
	public void insert(Member member);

	/**
	 * id에 해당하는 회원 정보의 pw를 변경한다.
	 * 
	 * @param id, pw
	 */	
	public void updatePwById(Member member);

	/**
	 * id에 해당하는 회원 정보의 pw를 변경한다.
	 * 
	 * @param id, pw
	 */	
	public int selectCntMemberByNick(String nick);
	
	/**
	 * 회원정보를 수정한다
	 * 
	 * @param member
	 */	
	public void updateMember(Member member);
	
	/**
	 * id와 이메일에 일치하는 회원 수를 반환한다 
	 * 
	 * @param member - id, email
	 * @return - 일치하는 회원의 수
	 */
	public int selectCntMemberByEmailAndId(Member member);
	
	/**
	 * 세션에 저장돼있는 id에 해당하는 회원 정보를 삭제한다 
	 * 
	 * @param id 
	 * @return - 회원 정보 삭제 확인 유/무 (유 : 1, 무 : 0)
	 */
	public void delete(String id);

	/**
	 * pw에 해당하는 회원의 id를 가져온다. 
	 * 
	 * @param pw
	 * @return - id
	 */
	public String selectIdByPw(String pw);

	public String selectPwByid(String ssId);

	public String selectPhoneByid(String ssId);

	public int selectCntMemberByPhone(String phone);

	public String selectIdByPhone(String phone);

	public Member selectMemberByPhone(String phone);
	
}
