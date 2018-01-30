package Entity;

import java.util.Date;

public class Order {
	private String o_id;
	private int u_id;
	private String sku;
	private String o_name;
	private double o_price;
	private int o_number;
	private Date o_date;
	private Date o_sentDate;
	private Date o_confirmDate;
	private int o_status;
	private String o_deliveryName;
	private String o_deliveryAddress;
	private String o_deliveryPhone;
	private String o_location;
	private String o_pic;
	
	public String getOId(){
		return this.o_id;
	}
	public void setOId(String OId){
		this.o_id = OId;
	}
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
	public String getOName(){
		return this.o_name;
	}
	public void setOName(String OName){
		this.o_name = OName;
	}
	public double getOPrice(){
		return this.o_price;
	}
	public void setOPrice(double OPrice){
		this.o_price = OPrice;
	}
	public int getONumber(){
		return this.o_number;
	}
	public void setONumber(int ONumber){
		this.o_number = ONumber;
	}
	public Date getODate(){
		return this.o_date;
	}
	public void setODate(Date ODate){
		this.o_date = ODate;
	}
	public Date getOSentDate(){
		return this.o_sentDate;
	}
	public void setOSentDate(Date OSentDate){
		this.o_sentDate = OSentDate;
	}
	public Date getOConfirmDate(){
		return this.o_confirmDate;
	}
	public void setOConfirmDate(Date OConfirmDate){
		this.o_confirmDate = OConfirmDate;
	}
	public int getOStatus(){
		return this.o_status;
	}
	public void setOStatus(int OStatus){
		this.o_status = OStatus;
	}
	public String getODeliveryName(){
		return this.o_deliveryName;
	}
	public void setODeliveryName(String ODeliveryName){
		this.o_deliveryName = ODeliveryName;
	}
	public String getODeliveryAddress(){
		return this.o_deliveryAddress;
	}
	public void setODeliveryAddress(String ODeliveryAddress){
		this.o_deliveryAddress = ODeliveryAddress;
	}
	public String getODeliveryPhone(){
		return this.o_deliveryPhone;
	}
	public void setODeliveryPhone(String ODeliveryPhone){
		this.o_deliveryPhone = ODeliveryPhone;
	}
	public String getOLocation(){
		return this.o_location;
	}
	public void setOLocation(String OLocation){
		this.o_location = OLocation;
	}
	public String getOPic(){
		return this.o_pic;
	}
	public void setOPic(String OPic){
		this.o_pic = OPic;
	}

}
