package Entity;

public class Comment {
	private String o_id;
	private String u_name;
	private int c_star;
	private String c_comment;
	
	public String getOId(){
		return this.o_id;
	}
	public void setOId(String OId){
		this.o_id = OId;
	}
	public String getUName(){
		return this.u_name;
	}
	public void setUName(String UName){
		this.u_name = UName;
	}
	public int getCStar(){
		return this.c_star;
	}
	public void setCStar(int CStar){
		this.c_star = CStar;
	}
	public String getCComment(){
		return this.c_comment;
	}
	public void setCComment(String CComment){
		this.c_comment = CComment;
	}
	

}
