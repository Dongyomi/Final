package web.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import web.dao.face.MemberDao;
import web.dto.Member;
import web.service.face.MemberService;


@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired MemberDao memberDao;
	
	@Override
	public boolean login(Member member) {
		
		//로그인 정보에 해당하는 회원수 get
		int loginChk = memberDao.selectCntMemberByLogin(member);
		
		//로그인 정보에 해당하는 회원이 존재할 시 = 로그인 성공 시
		if( loginChk > 0 ) {
			return true;
		}
		
		//로그인 실패 시
		return false;
		
	}

	@Override
	public Member getMemberByLogin(Member member) {
		return memberDao.selectMemberById(member.getId() );
	}
	
	@Override
	public boolean checkSameEmail(String email) {
		
		int chkEmail = memberDao.selectCntMemberByEmail(email);
		
		//중복된 email이 존재할 경우,
		if(chkEmail > 0) {
			return true;
		}
		
		//중복된 email이 존재하지 않을 경우,
		return false;
	}

	@Override
	public Member getMemberByEmail(String email) {
		return memberDao.selectMemberByEmail(email);
	}
	
	@Override
	public Member getMemberBySocialEmail(String SocialEmail) {
	
		return memberDao.selectMemberBySocialEmail(SocialEmail);
	}

	@Override
	public Member getMemberByMember(Member member) {
	
		return memberDao.selectMemberByMember(member);
	}

	@Override
	public boolean join(Member member) {
	
		//입력한 정보에 해당하는 회원(= 중복된 회원)이 존재할 경우, 
		if( memberDao.selectCntMemberByLogin(member) > 0 ){
			return false;	//회원가입 불가 = 실패
		}
		
		//회원 가입
		memberDao.insert(member);
		
		//회원가입 처리 검토
		if( memberDao.selectCntMemberByLogin(member) > 0 ) {
			//입력한 정보에 해당하는 회원(= 중복된 회원)이 존재할 경우,
			// = 회원가입이 된 상태라면,
			return true;
		}
		
		return false;	//회원가입 실패

	}

	@Override
	public void changePw(Member member) {
		memberDao.updatePwById(member);		
	}

	@Override
	public boolean duplChkId(String id) {

		int duplChkId = memberDao.selectCntMemberById(id);
		
		//중복된 id가 존재할 경우,
		if( duplChkId > 0 ) {
			return true;
		}
		
		//중복된 id가 존재하지 않을 경우,
		return false;
	
	}

	@Override
	public boolean duplChkNick(String nick) {

		int duplChkNick = memberDao.selectCntMemberByNick(nick);
		
		//중복된 nick이 존재할 경우,
		if( duplChkNick > 0 ) {
			return true;
		}
		
		//중복된 nick이 존재하지 않을 경우,
		return false;
	
	}

	@Override
	public void updateMember(Member member) {
		
		memberDao.updateMember(member);
		
	}

	@Override
	public Member getMemberById(String id) {
		return memberDao.selectMemberById(id);
	}

	@Override
	public boolean checkSameEmailAndId(Member member) {
		
		int chkMember = memberDao.selectCntMemberByEmailAndId(member);
		
		//정보와 일치하는 회원이 존재할 경우,
		if( chkMember > 0 ) {
			return true;
		}
		
		//정보와 일치하는 회원이 존재하지 않을 경우,
		return false;
		
	}

	@Override
	public boolean delete(String id) {
		
		//회원 삭제 진행
		memberDao.delete(id);
	
		//회원 삭제 검토
		if( memberDao.selectCntMemberById(id) > 0 ) {
			//회원 삭제 실패 시
			return false;
		}else {
			//회원 삭제 성공 시 
			return true;
		}

	}

	@Override
	public String getIdByPw(String pw) {
		
		return memberDao.selectIdByPw(pw);
	}

	@Override
	public String getPwByid(String ssId) {
		return memberDao.selectPwByid(ssId);
	}

	@Override
	public String getPhoneByid(String ssId) {
		return memberDao.selectPhoneByid(ssId);
	}

	@Override
	public Boolean checkSamePhone(String phone) {
		
		int chkMember = memberDao.selectCntMemberByPhone(phone);
		
		//정보와 일치하는 회원이 존재할 경우,
		if( chkMember > 0 ) {
			return true;
		}
		
		//정보와 일치하는 회원이 존재하지 않을 경우,
		return false;
		
	}

	@Override
	public String getIdByPhone(String phone) {
		return memberDao.selectIdByPhone(phone);
	}

	@Override
	public Member getMemberByPhone(String phone) {
		return memberDao.selectMemberByPhone(phone);
	}
	
}
