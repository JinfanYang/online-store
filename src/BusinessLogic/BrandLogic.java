package BusinessLogic;

import dbUtil.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BrandLogic {
	private IConnectionProvider connectionProvider = null;
    private String sourceName = "estore";
    private DbHelper dbHelper;
	
    //connect to database
    public BrandLogic(){
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
    
  //add brand Ôö
    public int add(String brand) throws Exception {
    	String sql = "SELECT * FROM brands WHERE B_Name = ?";
    	ResultSet rs = dbHelper.query(sql, brand);
    	if(rs.next()){
    		return 0;
    	}
    	else{
    		return dbHelper.insertPrepareSQL("INSERT INTO brands(B_Name) VALUES(?)",brand);
    	}
	}
    
    //delete brand É¾
    public void remove(int id) throws Exception{
		String sql = "DELETE FROM brands WHERE B_Id=?";
		dbHelper.updatePrepareSQL(sql, id);
	}
    
    //find all brand
    public List<Entity.Brand> findAllBrand() throws Exception{
    	String sql = "SELECT * FROM brands";
   		ResultSet rs = dbHelper.query(sql);
   		List<Entity.Brand> items = new ArrayList<Entity.Brand>();
   		while (rs.next()){
   			items.add(this.BuildItem(rs));
   		}
   		return items;
    }
    
    //product count
    public int countProduct(int bid) throws Exception{
    	int count = 0;
    	String sql = "SELECT * FROM products WHERE B_Id = ? GROUP BY P_Id";
    	ResultSet rs = dbHelper.query(sql, bid);
    	while(rs.next()){
    		count = count + 1;
    	}
    	return count;
    }
    
    public int countOrder(int bid) throws Exception{
    	int count = 0;
    	String sql = "SELECT COUNT(*) FROM orders,products WHERE orders.SKU = products.SKU AND products.B_Id=?";
    	ResultSet rs = dbHelper.query(sql, bid);
    	if(rs.next()){
    		count = rs.getInt(1);
    	}
    	return count;
    }
    
    private Entity.Brand BuildItem(ResultSet rs) throws SQLException{
		Entity.Brand item = new Entity.Brand();
		item.setBId(rs.getInt(1));
		item.setBName(rs.getString(2));
		
		return item;
	} 
}
