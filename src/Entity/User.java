package Entity;

public class User {
	
	private int u_id;
	private String u_name;
	private String password;
	private int gender;
	private String phone;
	private String email;
	
	public int getUserId(){
		return this.u_id;
	}
	public void setUserId(int UserId){
		this.u_id = UserId;
	}
	public String getUserName(){
		return this.u_name;
	}
	public void setUserName(String UserName){
		this.u_name = UserName;
	}
	public String getPassword(){
		return this.password;
	}
	public void setPassword(String Password){
		this.password = Password;
	}
	public int getGender(){
		return gender;
	}
	public void setGender(int Gender){
		this.gender = Gender;
	}
	public String getPhone(){
		return this.phone;
	}
	public void setPhone(String Phone){
		this.phone = Phone;
	}
	public String getEmail(){
		return this.email;
	}
	public void setEmail(String Email){
		this.email = Email;
	}

}
