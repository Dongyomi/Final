package web.dto;

import java.sql.Date;

public class Member {
	
	//영민님 최소한으로만 만들었습니다
	
	private int memberNo;
	private int memberRank;
	private String id;
	private String pw;
	private String name;
	private String nick;
	private String email;
	private String phone;
	private String addr1;
	private String addr2;
	private String addr3;
	private Date mdate;
	private long kakao_id;
	
	@Override
	public String toString() {
		return "Member [memberNo=" + memberNo + ", memberRank=" + memberRank + ", id=" + id + ", pw=" + pw + ", name="
				+ name + ", nick=" + nick + ", email=" + email + ", phone=" + phone + ", addr1=" + addr1 + ", addr2="
				+ addr2 + ", addr3=" + addr3 + ", mdate=" + mdate + ", kakao_id=" + kakao_id + "]";
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getMemberRank() {
		return memberRank;
	}

	public void setMemberRank(int memberRank) {
		this.memberRank = memberRank;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getAddr3() {
		return addr3;
	}

	public void setAddr3(String addr3) {
		this.addr3 = addr3;
	}

	public Date getMdate() {
		return mdate;
	}

	public void setMdate(Date mdate) {
		this.mdate = mdate;
	}

	public long getKakao_id() {
		return kakao_id;
	}

	public void setKakao_id(long kakao_id) {
		this.kakao_id = kakao_id;
	}
	
}
