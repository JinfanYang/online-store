package Entity;

public class DeliveryAddress {
	private int uid;
	private String d_name;
	private String d_address;
	private String d_phone;
	private int d_no;
	
	public int getUId(){
		return this.uid;
	}
	public void setUId(int UId){
		this.uid = UId;
	}
	public String getDName(){
		return this.d_name;
	}
	public void setDName(String DName){
		this.d_name = DName;
	}
	public String getDAddress(){
		return this.d_address;
	}
	public void setDAddress(String DAddress){
		this.d_address = DAddress;
	}
	public String getDPhone(){
		return this.d_phone;
	}
	public void setDPhone(String DPhone){
		this.d_phone = DPhone;
	}
	public int getDNo(){
		return this.d_no;
	}
	public void setDNo(int DNo){
		this.d_no = DNo;
	}
}
