package web.controller;

import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import web.dto.Member;
import web.service.face.MemberService;
import web.util.Encrypt;
import web.util.MailService;
import web.util.SmsService;


@Controller
public class MemberLoginController {

	private static final Logger logger = LoggerFactory.getLogger(MemberLoginController.class);
	
	@Autowired MemberService memberService;
	
	@Autowired private MailService mailService;
	
	//---------------------------------------------------
	
//	@RequestMapping(value="/member/login", method = RequestMethod.GET)
	@GetMapping("/member/login")
	public void login() {
		logger.info("/member/login [GET]");
	}
	
	//---------------------------------------------------
	
	@RequestMapping(value = "/member/loginCheck", method = RequestMethod.POST)
	@ResponseBody
	public Boolean loginCheck(String id, String pw, String user_check, HttpSession session, HttpServletResponse resp,@RequestParam(defaultValue="0", required = false) String loginType) {
		
		System.out.println("id : " + id);
		System.out.println("pw : " + pw);
		
		//아이디 기억하기 기능을 위한, 쿠키에 아이디 저장
		Cookie cookie = new Cookie("user_check", id);
		
		if (user_check!=null && user_check.equals("true")) {
			
			resp.addCookie(cookie);
			System.out.println("쿠키 아이디저장 O");
			// 쿠키 확인
			// System.out.println("Service check" + cookie);
		
		} else {
			
			System.out.println("쿠키 아이디저장 X");
			cookie.setMaxAge(0);
			resp.addCookie(cookie);
			
		}
		//아이디 기억하기 기능을 위한, 쿠키에 아이디 저장 end
		
		//-------------------------------------------------------------
		
		//<form>에 입력된 id, pw 받아오기
		Member member = new Member();
		
		//id Set
		member.setId(id);
		
		// 받아온 비밀번호 암호화(인코딩)
		Encrypt encrypt  = new Encrypt();
		try {
			
			String encryptPw = encrypt.encrypt(pw);
			System.out.println("pw : " + encryptPw);
			//String decipherPw = encrypt.decrypt(cipherText);	//비밀번호 디코딩
			//System.out.println("pw : " + decipherPw);
			
			//암호화된 pw Set
			member.setPw(encryptPw);
		
		} catch (Exception e) {
			
			e.printStackTrace();
		}
			
		//--------------------------------------------------------------------------------
		
		//일반 로그인 허용 유/무 확인 true : 로그인 허용, false : 로그인 불가
		Boolean chkMember = memberService.login(member);
		
		if(chkMember) {	//일반 로그인 허용 시,
			
			Member dbMember = new Member() ;
			
			//로그인 정보와 일치하는 회원 정보를 DB에서 가져오기
			dbMember = memberService.getMemberByLogin(member);
			
			//로그인 진행
			session.setAttribute("memberNo", dbMember.getMemberNo());
			session.setAttribute("memberRank", dbMember.getMemberNo());
			session.setAttribute("id", member.getId());
			session.setAttribute("name", dbMember.getName());
			session.setAttribute("nick", dbMember.getNick());
			session.setAttribute("email", dbMember.getEmail());
			session.setAttribute("phone", dbMember.getPhone());
			session.setAttribute("addr1", dbMember.getAddr1());
			session.setAttribute("addr2", dbMember.getAddr2());
			session.setAttribute("addr3", dbMember.getAddr3());
			session.setAttribute("login", true);
			
			// loginType : 로그인 상태 식별키 
			// 0 : 비로그인 상태 (defaultValue = 0)
			// 1 : 일반 로그인 상태 
			// 2 : 카카오 로그인 상태
			// 3 : 네이버 로그인 상태
			// 4 : 구글 로그인 상태
			
			//header에 넘겨줄 식별키 set : 1(일반 로그인 상태)
			session.setAttribute("loginType", 1);
			
			//일반 로그인 상태임을 명시하는 data
			Boolean loginSuccess = true;
			
			//일반 로그인 상태임을 명시하는 data 반환
			return loginSuccess;	
			
		} else {	
			
			logger.info("로그인 실패");
			
			session.invalidate();
			
			//일반 로그인 상태가 아님(= 일반 로그인에 실패)을 명시하는 data 반환			
			Boolean loginFailure = false;
			
			//일반 로그인 상태가 아님을 명시하는 data 반환
			return loginFailure;	
			
		}
	
	}
	
	//------------------------------------------------------------------------------------
	
//	@RequestMapping(value="/member/login", method = RequestMethod.POST)
	@PostMapping("/member/login")
	public String loginProcess(HttpSession session, Member member, String socialName, String socialEmail, @RequestParam(defaultValue="0", required = false) String loginType) {
		
		logger.info("/member/login [POST]");
		System.out.println("id : " + member.getId());
		System.out.println("id : " + member.getPw());
		System.out.println("socialEmail : " + socialEmail);
		System.out.println("socialName : " + socialName);
		System.out.println("loginType : " + loginType); 
		
		// loginType : 로그인 상태 식별키 
		// 0 : 비로그인 상태 (defaultValue = 0)
		// 1 : 일반 로그인 상태 
		// 2 : 카카오 로그인 상태
		// 3 : 네이버 로그인 상태
		// 4 : 구글 로그인 상태
		
		int loginTypeKey = Integer.parseInt(loginType);
		
		//일반 로그인 시,
		if(loginTypeKey == 1) {
			
			return "redirect:/main";

		}else if(loginTypeKey == 2) {	//카카오 소셜 로그인 시,
			
			//DB에, 소셜 로그인 정보(= socialEmail)와 일치하는 회원 정보가 있는지 확인 
			boolean chkMember = memberService.checkSameEmail(socialEmail);
			//(chkMember = true) : 일치하는 회원 정보 존재
			//(chkMember == false) : 일치하는 회원 정보 없음
			
			if(chkMember) {	//DB에, 소셜 로그인 정보(= socialEmail)와 일치하는 회원 정보가 존재할 경우,
				
				Member dbMember = null;
				
				//DB에서, 소셜 로그인 정보(= socialEmail)와 일치하는 회원 정보를 가져온다
				dbMember = memberService.getMemberByEmail(socialEmail);
				
				//세션에 저장
				session.setAttribute("memberNo", dbMember.getMemberNo());
				session.setAttribute("memberRank", dbMember.getMemberRank());
				session.setAttribute("id", dbMember.getId());
				session.setAttribute("name", dbMember.getName());
				session.setAttribute("nick", dbMember.getNick());
				session.setAttribute("email", dbMember.getEmail());
				session.setAttribute("phone", dbMember.getPhone());
				session.setAttribute("addr1", dbMember.getAddr1());
				session.setAttribute("addr2", dbMember.getAddr2());
				session.setAttribute("addr3", dbMember.getAddr3());
				
				// loginType : 로그인 상태 식별키 
				// 0 : 비로그인 상태 (defaultValue = 0)
				// 1 : 일반 로그인 상태 
				// 2 : 카카오 로그인 상태
				// 3 : 네이버 로그인 상태
				// 4 : 구글 로그인 상태
				session.setAttribute("loginType", 2); 
				
				return "redirect:/main";
			
			}else if(chkMember == false) {	//DB에, 소셜 로그인 정보(= socialEmail)와 일치하는 회원 정보가 존재하지 않을 경우
					
				session.setAttribute("name", socialName);
				session.setAttribute("email", socialEmail);
				
				// loginType : 로그인 상태 식별키 
				// 0 : 비로그인 상태 (defaultValue = 0)
				// 1 : 일반 로그인 상태 
				// 2 : 카카오 로그인 상태
				// 3 : 네이버 로그인 상태
				// 4 : 구글 로그인 상태
				session.setAttribute("loginType", loginType);
				
				//회원가입을 진행
				return "redirect:/member/socialJoin";
			
			}else {
				
				logger.info("로그인 실패");
				
				session.invalidate();
				
				return "redirect:/member/login";
				
			}
		
		}else {
			
			return null;
			
		}
	
	}
				
//	------------------------------------------------------
	
	//네이버 콜백함수
	@GetMapping("/member/callback")
	public void callback() {}

	@PostMapping("/member/callback")
	public String callbackProcess(HttpSession session, String socialName, String socialEmail, @RequestParam(defaultValue="0", required = false) String loginType) {
		// loginType : 로그인 상태 식별키 
		// 0 : 비로그인 상태 (defaultValue = 0)
		// 1 : 일반 로그인 상태 
		// 2 : 카카오 로그인 상태
		// 3 : 네이버 로그인 상태
		// 4 : 구글 로그인 상태
		
		System.out.println("socialEmail : " + socialEmail + " -> callback");
		System.out.println("socialName : " + socialName + " -> callback");
		System.out.println("loginType : " + loginType + " -> callback"); 
		
		//DB에, 소셜 로그인 정보(= socialEmail)와 일치하는 회원 정보가 있는지 확인 
		boolean chkMember = memberService.checkSameEmail(socialEmail);
		//(chkMember == true) : 일치하는 회원 정보 존재
		//(chkMember == false) : 일치하는 회원 정보 없음
		
		if(chkMember) {	//DB에, 소셜 로그인 정보(= socialEmail)와 일치하는 회원 정보가 존재할 경우,
	
			//DB에서, 소셜 로그인 정보(= socialEmail)와 일치하는 회원 정보를 가져온다
			Member dbMember = new Member();
					
			dbMember = memberService.getMemberByEmail(socialEmail);
			
			//세션에 저장
			session.setAttribute("memberNo", dbMember.getMemberNo());
			session.setAttribute("memberRank", dbMember.getMemberRank());
			session.setAttribute("id", dbMember.getId());
			session.setAttribute("name", dbMember.getName());
			session.setAttribute("nick", dbMember.getNick());
			session.setAttribute("email", dbMember.getEmail());
			session.setAttribute("phone", dbMember.getPhone());
			session.setAttribute("addr1", dbMember.getAddr1());
			session.setAttribute("addr2", dbMember.getAddr2());
			session.setAttribute("addr3", dbMember.getAddr3());	
			
			//header에 넘겨줄 식별키 set : 3(네이버 로그인 상태)
			session.setAttribute("loginType", 3); 
			
			return "redirect:/main";
			
		}else {	//DB에, 소셜 로그인 정보(= socialEmail)와 일치하는 회원 정보가 존재하지 않을 경우,

			session.setAttribute("name", socialName);
			session.setAttribute("email", socialEmail);
			
			// loginType : 로그인 상태 식별키 
			// 0 : 비로그인 상태 (defaultValue = 0)
			// 1 : 일반 로그인 상태 
			// 2 : 카카오 로그인 상태
			// 3 : 네이버 로그인 상태
			// 4 : 구글 로그인 상태
			session.setAttribute("loginType", loginType);
			
			//회원가입을 진행
			return "redirect:/member/socialJoin";
				
		}
		
	}
		
	//---------------------------------------------------
	
	@RequestMapping("/member/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/main";
	}
	
//	---------------------------------------------------
	
	@GetMapping("/member/idFind")
	public void idFind() {
		logger.info("/member/idFind [GET]");
	}
	
	@RequestMapping(value = "/member/send_idAuthNum", method = RequestMethod.POST)
	@ResponseBody
	public Boolean sendIdAuthNum(@RequestParam String email, HttpSession session) {
	    
		System.out.println("email : " + email);
		
		//요청받은 email값이 DB에 존재하는지 확인
		//true : 존재O , false : 존재X
		Boolean chkEmail =  memberService.checkSameEmail(email);
		
		if(chkEmail) {
			
			Member member = new Member();
			member = memberService.getMemberByEmail(email);
			
			String id = member.getId();
			
			Random r = new Random();
			String num = Integer.toString(r.nextInt(999999) ); // 랜덤난수설정
			 
			String fromAddress = "dudals3719@gmail.com";
			String subject = "인증번호";
			String content = num;
			
			mailService.sendEmail(member.getEmail(), fromAddress, subject, content);		
			
			session.setAttribute("id", id);
			session.setAttribute("authKey", num);
			
			return true;		//아이디 찾기 성공
			
		} else {
		
			System.out.println("이메일에 해당하는 회원이 존재하지 않는다.");
			return false;	//아이디 찾기 실패			
		}
			
	}
	
	@PostMapping("/member/idFind")
	public String idFindProcess() {
		return "redirect:/member/idFind";
	}
	
//	---------------------------------------------------
	
	@GetMapping("/member/authId")
	public void authId() {
		logger.info("/member/authId [GET]");
	}

	@RequestMapping(value = "/member/chk_idAuthNum", method = RequestMethod.POST)
	@ResponseBody
	public Boolean chkIdAuthNum(@RequestParam String authNum, HttpSession session) {
	
		String serverAuthKey  = (String)session.getAttribute("authKey");
		System.out.println("serverAuthKey : " + serverAuthKey);
		
		String userAuthNum  = authNum;
		System.out.println("userAuthNum" + userAuthNum);
		
		if( !("".equals(userAuthNum)) && !("".equals(serverAuthKey)) && (userAuthNum.equals(serverAuthKey))) {
					
			session.removeAttribute("authKey");
			return true;
			
		}else {

			return false; 
		
		}

	}
	
	@PostMapping("/member/authId")
	public String authIdProcess(HttpSession session) {
		session.removeAttribute("authKey");
		return "redirect:/member/authId";
	}
	
//	---------------------------------------------------

	@GetMapping("/member/showId")
	public void showId(HttpSession session) {
		session.removeAttribute("authKey");
		logger.info("/member/showId [GET]");
	
	}
	
//	---------------------------------------------------
	
	@GetMapping("/member/pwFind")
	public void pwFind() {
		logger.info("/member/pwFind [GET]");
	}
	
	@RequestMapping(value = "/member/send_pwAuthNum", method = RequestMethod.POST)
	@ResponseBody
	public Boolean chkPwAuthNum(Member member, HttpSession session) {
		
		SmsService smsSend = new SmsService();
		
		//입력한 정보에 해당하는 회원이 존재하는지 확인 
		boolean chkMember = memberService.checkSameEmailAndId(member);
		//(chkMember == true) : 일치하는 회원 정보 존재
		//(chkMember == false) : 일치하는 회원 정보 없음
		
		if(chkMember) {	//일치하는 회원 정보가 존재할 경우,
	
			//입력한 정보로 회원 정보 가져오기
			Member dbmember = new Member();
			dbmember = memberService.getMemberByMember(member);
			
			String phone = dbmember.getPhone();
			String id = dbmember.getId();
			
			if(!("".equals(phone)) || phone != null) {
				
				Random r = new Random();
				String num = Integer.toString(r.nextInt(999999) ); // 랜덤난수설정
				System.out.println("authKey : " + num);
//				smsSend.sendSms(phone, num);	
				
				session.setAttribute("authKey", num);
				session.setAttribute("id", id);
				
				return true;
				
			} else {
				
				return false;
			}
			
		}else {
			return false;
		}
		
	}
	
	@PostMapping("/member/pwFind")
	public String pwFindProcess() {
		return "redirect:/member/pwFind";
	}

//	---------------------------------------------------
	
	@GetMapping("/member/authPw")
	public void authPw() {
		logger.info("/member/authPw [GET]");
	}

	@RequestMapping(value = "/member/chk_pwAuthNum", method = RequestMethod.POST)
	@ResponseBody
	public Boolean chkPwAuthNum(@RequestParam String authNum, HttpSession session) {
	
		String serverAuthKey  = (String)session.getAttribute("authKey");
		System.out.println("serverAuthKey : " + serverAuthKey);
		
		String userAuthNum  = authNum;
		System.out.println("userAuthNum" + userAuthNum);
		
		if( !("".equals(userAuthNum)) && !("".equals(serverAuthKey)) && (userAuthNum.equals(serverAuthKey))) {
					
			session.removeAttribute("authKey");
			return true;
			
		}else {

			return false; 
		
		}
		
	}
	
	@PostMapping("/member/authPw")
	public String authPwProcess(HttpSession session) {
		session.removeAttribute("authKey");
		return "redirect:/member/pwFind"; 
	}
	
//	---------------------------------------------------
	
	@GetMapping("/member/setNewPw")
	public void setNewPw() {
		logger.info("/member/setNewPw [GET]");
	}
	
	@RequestMapping(value = "/member/chk_pwChange", method = RequestMethod.POST)
	@ResponseBody
	public Boolean chkPwChange(String newPw, String chkPw, HttpSession session) {
		
		session.removeAttribute("authKey");
		
		if( !("".equals(newPw)) && !("".equals(chkPw)) && (newPw.equals(chkPw)) ) {
			
			String id = (String)session.getAttribute("id");
			
			Member member = new Member();
			
			member.setId(id);

			// 받아온 비밀번호 암호화(인코딩)
			Encrypt encrypt  = new Encrypt();
			try {
				
				String encryptPw = encrypt.encrypt(newPw);
				System.out.println("pw : " + encryptPw);
				//String decipherPw = encrypt.decrypt(cipherText);	//비밀번호 디코딩
				//System.out.println("pw : " + decipherPw);
				
				//암호화된 pw Set
				member.setPw(encryptPw);
			
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			
//			비밀번호 변경 진행
			memberService.changePw(member);
			
			//인증키 삭제
			session.invalidate();
			
			return true;
			
		}
		
		return false;
	
	}
	
	@PostMapping("/member/setNewPw")
	public String setNewPwProcess() {
		return "redirect:/member/setNewPw";
	}
	
//	---------------------------------------------------
	@GetMapping("/member/join")
	public void join() {
		logger.info("/member/join [GET]");
	}
	
	@RequestMapping(value = "/member/dupl_id", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> duplChkId(String id) {
	    
		boolean duplChkId = memberService.duplChkId(id);
		logger.info("{}", duplChkId);
		//duplChkId = true : 중복O
		//duplChkId = false : 중복X
		
		HashMap<String, Object> resMap = new HashMap<>();
		
		resMap.put("duplChkId", duplChkId);
		
		return resMap;

	}
	
	//-------------------------------------------------------------------------
	
	@RequestMapping(value = "/member/dupl_nick", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> duplChkNick(String nick) {
	    
		boolean duplChkNick = memberService.duplChkNick(nick);
		
		logger.info("{}", duplChkNick);
		//duplChkId = true : 중복O
		//duplChkId = false : 중복X
		
		HashMap<String, Object> resMap = new HashMap<>();
		
		resMap.put("duplChkNick", duplChkNick);

		
		return resMap;
		
	}
	
	//-------------------------------------------------------------------------
	
	@RequestMapping(value = "/member/send_emailAuthNum", method = RequestMethod.POST)
	@ResponseBody
	public Boolean sendEmailAuthNum(String email, HttpSession session) {
	   
		System.out.println("email : " + email);
	
		Boolean chkEmail =  memberService.checkSameEmail(email);
		
		if( (!"".equals(email)) && (!chkEmail) ) {
	
			Random r = new Random();
			String num = Integer.toString(r.nextInt(999999) ); // 랜덤난수설정
			
			String fromAddress = "dudals3719@gmail.com";
			String subject = "인증번호";
			String content = num;
			System.out.println("authKey : " + num);
			
			//mailService.sendEmail(email, fromAddress, subject, content);	
			session.setAttribute("authKey", num);
			return true;
			
		}else {
			return false;
		}
		
	}
	
	//-------------------------------------------------------------------------

	@RequestMapping(value = "/member/auth_email", method = RequestMethod.POST)
	@ResponseBody
	public boolean authEmail(@RequestParam String emailAuthNum, HttpSession session) {
 
		System.out.println("emailAuthNum : " + emailAuthNum);
		
		String userAuthKey = emailAuthNum; 
		System.out.println("userAuthKey : " + userAuthKey);
		
		String serverAuthKey = String.valueOf(session.getAttribute("authKey"));
		System.out.println("serverAuthKey : " + serverAuthKey);
		
		if(userAuthKey.equals(serverAuthKey)) {
			return true;
		}else {
			return false;
		}
		
	}
	
	//-------------------------------------------------------------------------
	
	@RequestMapping(value = "/member/send_phoneAuthNum", method = RequestMethod.POST)
	@ResponseBody
	public Boolean sendPhoneAuthNum(String phone, HttpSession session, Model model) {
		System.out.println("phone : " + phone);

		if( !"".equals(phone) ) {
			
			Random r = new Random();
			String num = Integer.toString(r.nextInt(999999) ); // 랜덤난수설정
			
			SmsService smsSend = new SmsService();
			//smsSend.sendSms(phone, num);	
			System.out.println("authKey : " + num);
			session.setAttribute("authKey", num);
			
			return true;
		
		}else {
	
			return false;
			
		}

	}

	//-------------------------------------------------------------------------

	@RequestMapping(value = "/member/auth_phone", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> authPhone(@RequestParam String phoneAuthNum, String phone, HttpSession session) {
	    System.out.println("phoneAuthNum : " + phoneAuthNum);
	    System.out.println("phone : " + phone);
		
	    HashMap<String, Object> resMap = new HashMap<>();
		
		String userAuthKey = phoneAuthNum; 
		System.out.println("userAuthKey : " + userAuthKey);
		
		String serverAuthKey = String.valueOf(session.getAttribute("authKey"));
		System.out.println("serverAuthKey : " + serverAuthKey);
		
		if(userAuthKey.equals(serverAuthKey)) {
			
			
			resMap.put("authChk", true);
			
			Boolean chkPhone = memberService.checkSamePhone(phone);
			
			if(chkPhone) {
				
				Member member = memberService.getMemberByPhone(phone);
				String email = member.getEmail();
				System.out.println("email : " + email);
				
				resMap.put("email", email);
				
				return resMap;
				
			}else {
				return resMap;
			}
				
		}else {

			return resMap;
		}
		
	}
	
	//-------------------------------------------------------------------------
	
	@PostMapping("/member/join")
	public String joinProcess(Member member, Model model) {
		logger.info("/member/join [POST]");
		logger.info("{}", member);

		// <form>로 받아온 비밀번호 암호화(인코딩)
		Encrypt encrypt  = new Encrypt();
		try {
			
			String encryptPw = encrypt.encrypt(member.getPw());
			System.out.println("pw : " + encryptPw);
			//String decipherPw = encrypt.decrypt(cipherText);	//비밀번호 디코딩
			//System.out.println("pw : " + decipherPw);
			
			//암호화된 pw Set
			member.setPw(encryptPw);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//회원가입 진행 후, 처리 결과 반환
		boolean joinResult = memberService.join(member);	//회원가입 성공 : true, 실패 : false
		
		if(joinResult) {	//회원가입 성공 시,
		
			System.out.println("joinResult : " + joinResult + " -> 회원가입 성공");
			return "redirect:/main";	
			
		} else {	//회원가입 실패 시,
			
			System.out.println("joinResult : " + joinResult + " -> 회원가입 실패");
			return "redirect:/member/join";
		
		}
	}
	
//	---------------------------------------------------
	
	@RequestMapping(value = "/member/chk_member_by_email", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> chkMemberByEmail(String email) {
		
		HashMap<String, Object> resMap = new HashMap<>();
		
		if( !"".equals(email) ) {
			
			System.out.println("email : " + email);

			Boolean chkEmail = memberService.checkSameEmail(email);
			
			if(chkEmail) {
				
				resMap.put("chkEmail", true);
				
				Member member = memberService.getMemberByEmail(email);
				String sameEmil = member.getEmail(); 
				resMap.put("sameEmil", sameEmil);
				
			}

		}
		
		return resMap;
	
	}
	
//	---------------------------------------------------
	
	@RequestMapping(value = "/member/chk_member_by_phone", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> chkMemberByPhone(String phone) {
		
		HashMap<String, Object> resMap = new HashMap<>();
		
		if( !"".equals(phone) ) {
			
			System.out.println("phone : " + phone);

			Boolean chkPhone = memberService.checkSamePhone(phone);
			
			if(chkPhone) {
				
				resMap.put("chkPhone", true);
				
				Member member = memberService.getMemberByPhone(phone);
				String samePhone = member.getPhone(); 
				resMap.put("samePhone", samePhone);
				resMap.put("email", member.getEmail());
				
			}

		}
		
		return resMap;
	
	}
	
//	---------------------------------------------------

	@GetMapping("/member/socialJoin")
	public void socialJoin() {
		logger.info("/member/socialJoin [GET]");
	}
	
	@PostMapping("/member/socialJoin")
	public String socialJoinProcess(HttpSession session, Member member, Model model) {
		logger.info("/member/socialJoin [POST]");
		logger.info("{}", member);
		
		int loginTypeKey = Integer.parseInt((String)session.getAttribute("loginType"));
		
		Member dbMember = new Member();
		
		//session에 저장돼있는 소셜회원정보(= 이름, 이메일)를 가져온다.
		dbMember.setEmail((String)session.getAttribute("email"));
		dbMember.setName((String)session.getAttribute("name"));
		
		model.addAttribute("name", dbMember.getName());
		model.addAttribute("email", dbMember.getEmail());
			
		// <form>로 받아온 비밀번호 암호화(인코딩)
		Encrypt encrypt  = new Encrypt();
		try {
			
			String encryptPw = encrypt.encrypt(member.getPw());
			System.out.println("pw : " + encryptPw);
			//String decipherPw = encrypt.decrypt(cipherText);	//비밀번호 디코딩
			//System.out.println("pw : " + decipherPw);
			
			//암호화된 pw Set
			member.setPw(encryptPw);
		
		} catch (Exception e) {
			
			e.printStackTrace();
		}
				
		//회원가입 진행
		boolean joinResult = memberService.join(member);
		
		if(!joinResult) {
		
			System.out.println("joinResult : " + joinResult + " -> 소셜회원 회원가입 실패");
			return "redirect:/member/socialJoin";
			
		} else {
			
			System.out.println("joinResult : " + joinResult + " -> 소셜회원 회원가입 성공");
			
			//DB에서, 소셜 로그인 정보(= socialEmail)와 일치하는 회원 정보를 가져온다
			dbMember = memberService.getMemberByEmail((String)session.getAttribute("email"));
			
			//세션에 저장
			session.setAttribute("memberNo", dbMember.getMemberNo());
			session.setAttribute("memberRank", dbMember.getMemberRank());
			session.setAttribute("id", dbMember.getId());
			session.setAttribute("name", dbMember.getName());
			session.setAttribute("nick", dbMember.getNick());
			session.setAttribute("email", dbMember.getEmail());
			session.setAttribute("phone", dbMember.getPhone());
			session.setAttribute("addr1", dbMember.getAddr1());
			session.setAttribute("addr2", dbMember.getAddr2());
			session.setAttribute("addr3", dbMember.getAddr3());
			
			// loginType : 로그인 상태 식별키 
			// 0 : 비로그인 상태 (defaultValue = 0)
			// 1 : 일반 로그인 상태 
			// 2 : 카카오 로그인 상태
			// 3 : 네이버 로그인 상태
			// 4 : 구글 로그인 상태
			if(loginTypeKey == 2) {		//카카오 로그인 상태일 경우
				
				//header에 넘겨줄 식별키 set : 2(카카오 로그인 상태)
				session.setAttribute("loginType", 2); 
				
			}else if(loginTypeKey == 3) {		//네이버 로그인 상태일 경우
				
				//header에 넘겨줄 식별키 set : 3(네이버 로그인 상태)
				session.setAttribute("loginType", 3); 
				
			}else if(loginTypeKey == 4) {		//구글 로그인 상태일 경우
				
				//header에 넘겨줄 식별키 set : 4(구글 로그인 상태)
				session.setAttribute("loginType", 4); 
				
			}

			return "redirect:/main";
		}
	}

	//-------------------------------------------------------------------------
	@GetMapping("/member/changeInfo")
	public void changeInfo() {
		logger.info("/member/changeInfo [GET]");
	}

	@PostMapping("/member/changeInfo")
	public String changeInfoProcess(HttpSession session, Member member, Model model) {
		
		//session에 저장된 id와 일치하는 회원정보를 DB에서 가져오기  
		if( !"".equals((String)session.getAttribute("id")) ) {
			
			String id = (String)session.getAttribute("id");
			System.out.println("id : "+ id);
			
			Member dbMember = new Member();
			dbMember = memberService.getMemberById(id);
		
			//DB에서 가져온 DTO_회원정보를 jsp로 전달하기
			model.addAttribute("id", dbMember.getId());
			model.addAttribute("name", dbMember.getId());
			model.addAttribute("nick", dbMember.getId());
			model.addAttribute("email", dbMember.getId());
			model.addAttribute("phone", dbMember.getId());
			model.addAttribute("addr1", dbMember.getId());
			model.addAttribute("addr2", dbMember.getId());
			model.addAttribute("addr3", dbMember.getId());

			member.setPw(dbMember.getPw());
			
			//회원정보수정 진행
			memberService.updateMember(member);
		
			return "redirect:/main";
			
		}else {
			return "/member/changeInfo";
		}

	}
	
	//-------------------------------------------------------------------------

	@GetMapping("/member/changePw")
	public String changePw() {
		logger.info("/member/changePw [GET]");
		return "/member/changePw";
	}
	
	@RequestMapping(value = "/member/checkPhone", method = RequestMethod.POST)
	@ResponseBody
	public boolean checkPhone(String oldPw, String newPw, HttpSession session) {
	    
		// <form>로 받아온 비밀번호 암호화(인코딩)
		Encrypt encrypt  = new Encrypt();
		try {
			
			String encryptOldPw = encrypt.encrypt(oldPw);
			System.out.println("pw : " + encryptOldPw);
			//String decipherPw = encrypt.decrypt(cipherText);	//비밀번호 디코딩
			//System.out.println("pw : " + decipherPw);
			
			//session에 저장돼있는 id 정보를 가져온다.
			String ssId = ((String)session.getAttribute("id"));
			System.out.println("ssId : " + ssId);
			
			//id에 해당하는 비밀번호를 가져온다.
			String dbPw = memberService.getPwByid(ssId);
			
			//현재 비밀번호가 세션에 저장돼있는 id에 해당하는 비밀번호와 동일한지 대조
			if(encryptOldPw.equals(dbPw) ) {	//동일하면,
				
				//session에 저장돼있는 id정보를 이용하여 DB에서 phone 정보를 가져온다.
				String phone = memberService.getPhoneByid(ssId);
				System.out.println("phone : " + phone);
				
				//휴대폰 본인인증을 위해서 인증번호 전송
				Random r = new Random();
				String num = Integer.toString(r.nextInt(999999) ); // 랜덤난수설정
				System.out.println("authKey : " + num);
				
				SmsService smsSend = new SmsService();

				//smsSend.sendSms(phone, num);	
				
				session.setAttribute("authKey", num);
				session.setAttribute("newPw", newPw);
				session.setAttribute("id", ssId);
				
				return true;
				
			}else{
				return false;
			}
				
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return false;

	}
	
	@PostMapping("/member/changePw")
	public String changePwProcess(HttpSession session) {
		return "redirect:/member/changePw";
	}
	
	//----------------------------------------------------------
	
	@GetMapping("/member/authPhoneForChangePw")
	public String authPhoneForChangePw() {
		logger.info("/member/authPhoneForChangePw [GET]");
		return "/member/authPhoneForChangePw";
	}
	
	@RequestMapping(value = "/member/checkAuthNum", method = RequestMethod.POST)
	@ResponseBody
	public boolean checkAuthNum(String auth, HttpSession session) {
		
		String serverAuthKey  = (String)session.getAttribute("authKey");
		String userAuthNum  = auth;
		
		if(userAuthNum.equals(serverAuthKey)) {
				
			String newPw  = (String)session.getAttribute("newPw");
			
			//비밀번호 암호화 진행
			Encrypt encrypt  = new Encrypt();
			try {
				
				String encryptPw = encrypt.encrypt(newPw);
				System.out.println("pw : " + encryptPw);
				//String decipherPw = encrypt.decrypt(cipherText);	//비밀번호 디코딩
				//System.out.println("pw : " + decipherPw);
				
				String id  = (String)session.getAttribute("id");
				
				Member member = new Member();
				
				member.setPw(encryptPw);
				member.setId(id);
				
				memberService.changePw(member);
				
				//인증키 삭제
				session.removeAttribute("authKey");
				
				return true;
			
			} catch (Exception e) {
				
				e.printStackTrace();
			}

		}else {

			return false;
		
		}
		
		return false;
	
	}
	
	@PostMapping("/member/authPhoneForChangePw")
	public String authPhoneForChangePw(HttpSession session) {
		return "redirect:/member/authPhoneForChangePw";
	}
	
//	-------------------------------------------------------------------------------
	
	@GetMapping("/member/delete")
	public void  delete() {
		logger.info("/member/delete [GET]");
	}
	
	@RequestMapping(value = "/member/deleteMember", method = RequestMethod.POST)
	@ResponseBody
	public boolean deleteMember(String pw, String chkPw, HttpSession session) {
	    
		System.out.println("pw : " + pw);
		System.out.println("chkPw : " + chkPw);
		
		// 받아온 비밀번호 암호화(인코딩)
		Encrypt encrypt  = new Encrypt();
		try {
			
			String encryptPw = encrypt.encrypt(pw);
			System.out.println("pw : " + encryptPw);
			//String decipherPw = encrypt.decrypt(cipherText);	//비밀번호 디코딩
			//System.out.println("pw : " + decipherPw);
			
			//session에 저장돼있는 id 정보를 가져온다.
			String ssId = ((String)session.getAttribute("id"));
			System.out.println("ssId : " + ssId);
			
			//id에 해당하는 비밀번호를 가져온다.
			String dbPw = memberService.getPwByid(ssId);
			
			//현재 비밀번호가 세션에 저장돼있는 id에 해당하는 비밀번호와 동일한지 대조
			if(encryptPw.equals(dbPw) ) {	//동일하면,
				
				//session에 저장돼있는 id정보를 이용하여 DB에서 phone 정보를 가져온다.
				String phone = memberService.getPhoneByid(ssId);
				System.out.println("phone : " + phone);
				
				//휴대폰 본인인증을 위해서 인증번호 전송
				Random r = new Random();
				String num = Integer.toString(r.nextInt(999999) ); // 랜덤난수설정
				System.out.println("authKey : " + num);
				
				SmsService smsSend = new SmsService();

				//smsSend.sendSms(phone, num);	
				
				session.setAttribute("authKey", num);

				return true;
				
			} else {
				return false;
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return false;

	}
	
	@PostMapping("/member/delete")
	public String deleteProcess(HttpSession session) {
		return "redirect:/member/delete";
	}
	
	//----------------------------------------------------------
	
	@GetMapping("/member/authPhoneForDelete")
	public String authPhoneForDelete() {
		logger.info("/member/authPhoneForDelete [GET]");
		return "/member/authPhoneForDelete";
	}
	
	@RequestMapping(value = "/member/check_auth_num", method = RequestMethod.POST)
	@ResponseBody
	public boolean checkAuthNumForDelete(String auth, HttpSession session) {
		
		String serverAuthKey  = (String)session.getAttribute("authKey");
		String userAuthNum  = auth;
		
		if(userAuthNum.equals(serverAuthKey)) {
				
			//session에 저장돼있는 id 정보를 가져온다.
			String ssId = ((String)session.getAttribute("id"));
			System.out.println("ssId : " + ssId);

			Boolean chkDelete = memberService.delete(ssId);
			System.out.println("chkDelete : " + chkDelete);
			
			if(chkDelete) {	

				//회원 삭제 성공 시,
				session.invalidate();
			
				//rttr.addFlashAttribute("msg", "이용해주셔서 감사합니다.");
				return true;
				
			}else {
				
				return false;
					
			}
				
		}else {

			return false;
		
		}
		
	}
	
	@PostMapping("/member/authPhoneForDelete")
	public String authPhoneForDelete(HttpSession session) {
		return "redirect:/member/authPhoneForDelete";
	}
	
//		-------------------------------------------------------------------------------

	@GetMapping("/member/test")
	public void test() {
		logger.info("/member/test [GET]");
	}
	
	@PostMapping("/member/test")
	public String testProcess() {
		return "redirect:/member/test";
	}
	
	

}

