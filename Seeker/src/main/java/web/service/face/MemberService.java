package web.service.face;

import web.dto.Member;

public interface MemberService {
	
	/**
	 * 일반 로그인 인증 처리
	 * 	  
	 * @param member - 입력한 ID/PW 정보
	 * @return 일반 로그인 인증 결과
	 */
	public boolean login(Member member);
	
	/**
	 * 일반 로그인 정보와 일치하는 회원 정보 반환
	 * 	  
	 * @param member - 입력한 ID/PW 정보
	 * @return 조회된 회원 정보 객체
	 */
	public Member getMemberByLogin(Member member);
	
	/**
	 * socialEmail과 일치하는 회원의 유/무 확인 
	 * 	  
	 * @param socialEmail 
	 * @return 회원의 유/무 (유 : 1, 무 : 0)
	 */
	public boolean checkSameEmail(String email);
	
	/**
	 * 소셜 로그인 시, 소셜에 등록돼있는 정보 중, socialEmail과 일치하는 회원의 정보를 반환한다
	 * 
	 * @param socialEmail
	 * @return 조회된 회원 정보 객체
	 */	
	public Member getMemberBySocialEmail(String email);
	
	/**
	 * email과 일치하는 회원 정보를 반환한다.
	 * 
	 * @param email
	 * @return 조회된 회원 정보 객체
	 */	
	public Member getMemberByEmail(String email);
	
	/**
	 * 회원 정보(= id, email)와 일치하는 회원 정보 중, 전화번호를 반환한다.
	 * 
	 * @param member
	 * @return 조회된 회원 정보 중, 전화번호
	 */
	public Member getMemberByMember(Member member);
	
	/**
	 * 신규 회원 가입
	 * 	  
	 * @param member - 신규 회원의 정보
	 * @return 회원가입 결과
	 */
	public boolean join(Member member);
	

	/**
	 * 비밀번호 변경
	 * 	  
	 * @param member - id, 새 비밀번호
	 */
	public void changePw(Member member);

	/**
	 * id 중복 확인
	 * 	  
	 * @param id
	 */
	public boolean duplChkId(String id);

	/**
	 * nick 중복 확인
	 * 	  
	 * @param nick
	 */
	public boolean duplChkNick(String nick);
	
	/**
	 * 회원정보수정
	 * 	  
	 * @param member
	 */
	public void updateMember(Member member);

	/**
	 * 세션에 저장된 id와 일치하는 회원정보 가져오기
	 * 	  
	 * @param id
	 * @return 회원정보
	 */
	public Member getMemberById(String id);

	/**
	 * id와 email에 해당하는 회원이 존재하는지 확인
	 * 	  
	 * @param member(id, email)
	 * @return 존재 유/무	(유 : true, 무 : false)
	 */
	public boolean checkSameEmailAndId(Member member);

	/**
	 * 세션에 저장돼있는 id에 해당하는 회원 정보 삭제
	 * 	  
	 * @param id
	 * @return - 회원 정보 삭제 성공 유/무 (유 : true, 무 : false)
	 */
	public boolean delete(String id);

	/**
	 * pw에 해당하는 id 가져오기
	 * 	  	  
	 * @param pw
	 * @return - id
	 */
	public String getIdByPw(String pw);

	public String getPwByid(String ssId);

	public String getPhoneByid(String ssId);

	public Boolean checkSamePhone(String phone);

	public String getIdByPhone(String phone);

	public Member getMemberByPhone(String phone);

	public String getNick(Member member);

	public int getMemberNo(Member member);

}
