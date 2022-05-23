package web.dto;

public class Reply {

	private int rum;
	private int replyno;
	private int boardno;
	private String id;
	private String content;
	private String bdate;
	private String reparent;
	private String redepth;
	private String reorder;
	private String nick;
	
	
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	@Override
	public String toString() {
		return "Reply [rum=" + rum + ", replyno=" + replyno + ", boardno=" + boardno + ", id=" + id + ", content="
				+ content + ", bdate=" + bdate + ", reparent=" + reparent + ", redepth=" + redepth + ", reorder="
				+ reorder + ", nick=" + nick + "]";
	}
	public int getRum() {
		return rum;
	}
	public void setRum(int rum) {
		this.rum = rum;
	}
	public int getReplyno() {
		return replyno;
	}
	public void setReplyno(int replyno) {
		this.replyno = replyno;
	}
	public int getBoardno() {
		return boardno;
	}
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;
	}
	public String getReparent() {
		return reparent;
	}
	public void setReparent(String reparent) {
		this.reparent = reparent;
	}
	public String getRedepth() {
		return redepth;
	}
	public void setRedepth(String redepth) {
		this.redepth = redepth;
	}
	public String getReorder() {
		return reorder;
	}
	public void setReorder(String reorder) {
		this.reorder = reorder;
	}
	
	
	
	
}
