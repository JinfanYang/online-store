package BusinessLogic;

import dbUtil.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class KindLogic {
	private IConnectionProvider connectionProvider = null;
    private String sourceName = "estore";
    private DbHelper dbHelper;
	
    //connect to database
    public KindLogic(){
		try {
	        connectionProvider = new JdbcProvider(
	                "com.mysql.jdbc.Driver",
	                "jdbc:mysql://127.0.0.1:3306/",
	                "root","123456");
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    }
		dbHelper = new DbHelper(connectionProvider, sourceName);
    }

  //add kind Ôö
    public int add(int kcatalog1, int kcatalog2, String kcatalog3) throws Exception {
    	String sql = "SELECT * FROM kinds WHERE K_Catalog1=? AND K_Catalog2=? AND K_Catalog3=?";
    	ResultSet rs = dbHelper.query(sql, kcatalog1, kcatalog2, kcatalog3);
    	if(rs.next()){
    		return 0;
    	}
    	else{
    		return dbHelper.insertPrepareSQL(
    				"INSERT INTO kinds(K_Catalog1, K_Catalog2, K_Catalog3) VALUES(?,?,?)",
    				kcatalog1, kcatalog2, kcatalog3);
    	}
	}
    
    //delete kind É¾
    public void remove(int id) throws Exception{
		String sql = "DELETE FROM kinds WHERE K_Id=?";
		dbHelper.updatePrepareSQL(sql, id);
	}
    
    //find all kind
    public List<String> findAllKind() throws Exception{
    	String sql = "SELECT K_Catalog3 FROM kinds Group By K_Catalog3 ";
   		ResultSet rs = dbHelper.query(sql);
   		List<String> items = new ArrayList<String>();
   		while (rs.next()){
   			items.add(rs.getString(1));
   		}
   		return items;
    }
    
    //find all male kind
   	public List<Entity.Kind> findMKind() throws Exception{
   		String sql = "SELECT * FROM kinds WHERE K_Catalog1 = 0";
   		ResultSet rs = dbHelper.query(sql);
   		List<Entity.Kind> items = new ArrayList<Entity.Kind>();
   		while (rs.next()){
   			items.add(this.BuildItem(rs));
   		}
   		return items;
   	}
   	
   	public List<Entity.Kind> findMKind1() throws Exception{
   		String sql = "SELECT * FROM kinds WHERE K_Catalog1 = 0 AND K_Catalog2 = 0";
   		ResultSet rs = dbHelper.query(sql);
   		List<Entity.Kind> items = new ArrayList<Entity.Kind>();
   		while (rs.next()){
   			items.add(this.BuildItem(rs));
   		}
   		return items;
   	}
   	
   	public List<Entity.Kind> findMKind2() throws Exception{
   		String sql = "SELECT * FROM kinds WHERE K_Catalog1 = 0 AND K_Catalog2 = 1";
   		ResultSet rs = dbHelper.query(sql);
   		List<Entity.Kind> items = new ArrayList<Entity.Kind>();
   		while (rs.next()){
   			items.add(this.BuildItem(rs));
   		}
   		return items;
   	}   	
   	
   	//find all female kind
   	public List<Entity.Kind> findFKind() throws Exception{
   		String sql = "SELECT * FROM kinds WHERE K_Catalog1 = 1";
   		ResultSet rs = dbHelper.query(sql);
   		List<Entity.Kind> items = new ArrayList<Entity.Kind>();
   		while (rs.next()){
   			items.add(this.BuildItem(rs));
   		}
   		return items;
   	}
   	
   	public List<Entity.Kind> findFKind1() throws Exception{
   		String sql = "SELECT * FROM kinds WHERE K_Catalog1 = 1 AND K_Catalog2 = 0";
   		ResultSet rs = dbHelper.query(sql);
   		List<Entity.Kind> items = new ArrayList<Entity.Kind>();
   		while (rs.next()){
   			items.add(this.BuildItem(rs));
   		}
   		return items;
   	}
   	
   	public List<Entity.Kind> findFKind2() throws Exception{
   		String sql = "SELECT * FROM kinds WHERE K_Catalog1 = 1 AND K_Catalog2 = 1";
   		ResultSet rs = dbHelper.query(sql);
   		List<Entity.Kind> items = new ArrayList<Entity.Kind>();
   		while (rs.next()){
   			items.add(this.BuildItem(rs));
   		}
   		return items;
   	}
   	
   	//find all kid kind
   	public List<Entity.Kind> findKKind() throws Exception{
   		String sql = "SELECT * FROM kinds WHERE K_Catalog1 = 2";
   		ResultSet rs = dbHelper.query(sql);
   		List<Entity.Kind> items = new ArrayList<Entity.Kind>();
   		while (rs.next()){
   			items.add(this.BuildItem(rs));
   		}
   		return items;
   	}
   	
   	public List<Entity.Kind> findKKind1() throws Exception{
   		String sql = "SELECT * FROM kinds WHERE K_Catalog1 = 2 AND K_Catalog2 = 0";
   		ResultSet rs = dbHelper.query(sql);
   		List<Entity.Kind> items = new ArrayList<Entity.Kind>();
   		while (rs.next()){
   			items.add(this.BuildItem(rs));
   		}
   		return items;
   	}
   	
   	public List<Entity.Kind> findKKind2() throws Exception{
   		String sql = "SELECT * FROM kinds WHERE K_Catalog1 = 2 AND K_Catalog2 = 1";
   		ResultSet rs = dbHelper.query(sql);
   		List<Entity.Kind> items = new ArrayList<Entity.Kind>();
   		while (rs.next()){
   			items.add(this.BuildItem(rs));
   		}
   		return items;
   	}
   	
   	public int countProduct(int kid) throws Exception{
   		int count = 0;
    	String sql = "SELECT * FROM products WHERE K_Id = ? GROUP BY P_Id";
    	ResultSet rs = dbHelper.query(sql, kid);
    	while(rs.next()){
    		count = count + 1;
    	}
    	return count;
   	}
   	
   	public int countOrder(int kid) throws Exception{
   		int count = 0;
    	String sql = "SELECT COUNT(*) FROM orders,products WHERE orders.SKU = products.SKU AND products.K_Id=?";
    	ResultSet rs = dbHelper.query(sql, kid);
    	if(rs.next()){
    		count = rs.getInt(1);
    	}
    	return count;
   	}
   	
   	private Entity.Kind BuildItem(ResultSet rs) throws SQLException{
		Entity.Kind item = new Entity.Kind();
		item.setKId(rs.getInt(1));
		item.setKCatalog1(rs.getInt(2));
		item.setKCatalog2(rs.getInt(3));
		item.setKCatalog3(rs.getString(4));
		
		return item;
	} 
}
