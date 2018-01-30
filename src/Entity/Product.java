package Entity;

import java.util.ArrayList;
import java.util.Date;

public class Product {
	private String p_id;
	private String sku;
	private int b_id;
	private int k_id;
	private String p_name;
	private int p_gender;
	private double p_price;
	private double p_discountPrice;
	private int p_size;
	private int p_storage;
	private Date p_inDate;
	private String p_color;
	private String p_memo;
	
	private ArrayList<String> p_pics;
	
	public String getPId(){
		return this.p_id;
	}
	public void setPId(String PId){
		this.p_id = PId;
	}
	public String getSKU(){
		return this.sku;
	}
	public void setSKU(String SKU){
		this.sku = SKU;
	}
	public int getBId(){
		return this.b_id;
	}
	public void setBId(int BId){
		this.b_id = BId;
	}
	public int getKId(){
		return this.k_id;
	}
	public void setKId(int KId){
		this.k_id = KId;
	}
	public String getPName(){
		return this.p_name;
	}
	public void setPName(String PName){
		this.p_name = PName;
	}
	public int getPGender(){
		return this.p_gender;
	}
	public void setPGender(int PGender){
		this.p_gender = PGender;
	}
	public double getPPrice(){
		return this.p_price;
	}
	public void setPPrice(double PPrice){
		this.p_price = PPrice;
	}
	public double getPDiscountPrice(){
		return this.p_discountPrice;
	}
	public void setPDiscountPrice(double PDiscountPrice){
		this.p_discountPrice = PDiscountPrice;
	}
	public int getPSize(){
		return this.p_size;
	}
	public void setPSize(int PSize){
		this.p_size = PSize;
	}
	public int getPStorage(){
		return this.p_storage;
	}
	public void setPStorage(int PStorage){
		this.p_storage = PStorage;
	}
	public Date getPInDate(){
		return this.p_inDate;
	}
	public void setPInDate(Date PInDate){
		this.p_inDate = PInDate;
	}
	public String getPColor(){
		return this.p_color;
	}
	public void setPColor(String PColor){
		this.p_color = PColor;
	}
	public String getPMemo(){
		return this.p_memo;
	}
	public void setPMemo(String PMemo){
		this.p_memo = PMemo;
	}
	public ArrayList<String> getPPics(){
		return this.p_pics;
	}
	public void setPPics(ArrayList<String> PPics){
		this.p_pics = PPics;
	}
}
