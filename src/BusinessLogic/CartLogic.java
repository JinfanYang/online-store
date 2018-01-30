package BusinessLogic;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dbUtil.DbHelper;
import dbUtil.IConnectionProvider;
import dbUtil.JdbcProvider;

public class CartLogic {
	private IConnectionProvider connectionProvider = null;
    private String sourceName = "estore";
    private DbHelper dbHelper;
    public CartLogic(){
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
    
    //增
    public int add(Entity.Cart item) throws Exception {
    	String sql = "SELECT * FROM cart WHERE U_Id=? AND SKU=?";
    	ResultSet rs = dbHelper.query(sql, item.getUId(), item.getSKU());
    	if(rs.next()){
    		int number = rs.getInt(3);
    		sql = "UPDATE cart SET C_Number=? WHERE U_Id=? AND SKU=?";
    		return dbHelper.updatePrepareSQL(sql, number+1, item.getUId(), item.getSKU());
    	}
    	else{
    		return dbHelper.insertPrepareSQL(
    				"INSERT INTO cart(U_Id, SKU, C_Number) VALUES(?,?,?)",
    				item.getUId(),
    				item.getSKU(),
    				item.getCNumber());
    	}
	}
    
    //删
    public int remove(int userid, String sku) throws SQLException {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM cart WHERE U_Id=? AND SKU = ?";
		return dbHelper.updatePrepareSQL(sql, userid, sku);
	}
    
    //改
    public int save(int userId, String sku, int no) throws SQLException{
    	String sql = "UPDATE cart SET C_Number=? WHERE U_Id=? AND SKU=?";
    	return dbHelper.updatePrepareSQL(sql, no, userId, sku);
    }
    
    //查
	public List<Entity.Cart> findByUserId(int userId) throws Exception{
		String sql = "SELECT * FROM cart WHERE userId=?";
		ResultSet rs = dbHelper.query(sql,userId);
		List<Entity.Cart> items = new ArrayList<Entity.Cart>();
		while (rs.next()){
			Entity.Cart item = new Entity.Cart();
			item.setUId(rs.getInt(1));
			item.setSKU(rs.getString(2));
			item.setCNumber(rs.getInt(3));
			
			items.add(item);
		}
		
		return items;
	}
	
	//查一个商品订了多少件
	public int getNumber(int userId, String sku) throws Exception{
		int count = 0;
		String sql = "SELECT C_Number FROM cart WHERE U_Id=? AND SKU=?";
		ResultSet rs = dbHelper.query(sql, userId, sku);
		if(rs.next()){
			count = rs.getInt(1);
		}
		return count;
	}
	
	//查cart物品数
	public int countByUserId(int userId) throws Exception{
		int count=0;
		String sql = "SELECT COUNT(*) FROM cart WHERE U_Id=?";
		ResultSet rs = dbHelper.query(sql, userId);
		if(rs.next()){
			count = rs.getInt(1);
		}
		return count;	
	}
	
	//算cart物品总价格
	public double totalByUserId(int userId) throws Exception{
		double total=0;
		List<ArrayList<Double>> prices = new ArrayList<ArrayList<Double>>(); 
		String sql = "SELECT * FROM cart,products WHERE cart.SKU=products.SKU AND cart.U_Id=?";
		ResultSet rs = dbHelper.query(sql, userId);
		while(rs.next()){
			ArrayList<Double> temp = new ArrayList<Double>();
			temp.add((double)rs.getInt(3));
			if(rs.getDouble(11)  != 0){
				temp.add(rs.getDouble(11));
			}
			else{
				temp.add(rs.getDouble(10));
			}
			prices.add(temp);
		}
		for(int i = 0; i<prices.size(); i++){
			total += prices.get(i).get(0) * prices.get(i).get(1);
		}
		return total;
	}
	
	public List<ArrayList<String>> findCPInfo(int userId) throws Exception{
		List<ArrayList<String>> cpInfo = new ArrayList<ArrayList<String>>();
		String sql = "SELECT * FROM cart,products,productspic WHERE cart.SKU = products.SKU AND products.P_Id = productspic.P_Id AND cart.U_Id=?";
		ResultSet rs = dbHelper.query(sql, userId);
		while(rs.next()){
			ArrayList<String> temp = new ArrayList<String>();
			//sku
			temp.add(rs.getString(2));
			//name
			temp.add(rs.getString(8));
			//price
			if(rs.getDouble(11)>0){
				temp.add(String.valueOf(rs.getDouble(11)));
			}
			else{
				temp.add(String.valueOf(rs.getDouble(10)));
			}
			temp.add(String.valueOf(rs.getInt(3)));//quantity
			temp.add(String.valueOf(rs.getInt(12)));//size
			temp.add(rs.getString(15));//color
			temp.add(rs.getString(18));//pic
			
			cpInfo.add(temp);
		}
		return cpInfo;
	}
	

}
