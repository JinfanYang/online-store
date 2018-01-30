package Entity;

public class Admin {
	private int a_id;
	private String a_name;
	private String a_password;
	
	public int getAId(){
		return this.a_id;
	}
	public void setAId(int AId){
		this.a_id = AId;
	}
	public String getAName(){
		return this.a_name;
	}
	public void setAName(String AName){
		this.a_name = AName;
	}
	public String getAPassword(){
		return this.a_password;
	}
	public void setAPassword(String APassword){
		this.a_password = APassword;
	}
}