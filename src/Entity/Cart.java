package Entity;

public class Cart {
	private int u_id;
	private String sku;
	private int c_number;
	
	public int getUId(){
		return this.u_id;
	}
	public void setUId(int UId){
		this.u_id = UId;
	}
	public String getSKU(){
		return this.sku;
	}
	public void setSKU(String SKU){
		this.sku = SKU;
	}
	public int getCNumber(){
		return this.c_number;
	}
	public void setCNumber(int CNumber){
		this.c_number = CNumber;
	}
}
