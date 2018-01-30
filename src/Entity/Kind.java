package Entity;

public class Kind {

	private int k_id;
	private int k_catalog1;
	private int k_catalog2;
	private String k_catalog3;
	
	public int getKId(){
		return this.k_id;
	}
	public void setKId(int KId){
		this.k_id = KId;
	}
	public int getKCatalog1(){
		return this.k_catalog1;
	}
	public void setKCatalog1(int KCatalog1){
		this.k_catalog1 = KCatalog1;
	}
	public int getKCatalog2(){
		return this.k_catalog2;
	}
	public void setKCatalog2(int KCatalog2){
		this.k_catalog2 = KCatalog2;
	}
	public String getKCatalog3(){
		return this.k_catalog3;
	}
	public void setKCatalog3(String KCatalog3){
		this.k_catalog3 = KCatalog3;
	}
}
