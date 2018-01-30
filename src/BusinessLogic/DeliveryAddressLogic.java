package BusinessLogic;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

import dbUtil.DbHelper;
import dbUtil.IConnectionProvider;
import dbUtil.JdbcProvider;

public class DeliveryAddressLogic {
	private IConnectionProvider connectionProvider = null;
    private String sourceName = "estore";
    private DbHelper dbHelper;
    public DeliveryAddressLogic(){
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
    
    //find all address
    public List<Entity.DeliveryAddress> findAddress(int userId) throws Exception{
    	String sql = "SELECT * FROM deliveryaddress WHERE U_Id=?";
    	ResultSet rs = dbHelper.query(sql, userId);
    	List<Entity.DeliveryAddress> address = new ArrayList<Entity.DeliveryAddress>();
    	while(rs.next()){
    		Entity.DeliveryAddress aaddress = new Entity.DeliveryAddress();
    		aaddress.setUId(rs.getInt(1));
    		aaddress.setDName(rs.getString(2));
    		aaddress.setDAddress(rs.getString(3));
    		aaddress.setDPhone(rs.getString(4));
    		aaddress.setDNo(rs.getInt(5));
    		address.add(aaddress);
    	}
    	return address;
    }
    
    //add all address
    public int addAddress(Entity.DeliveryAddress newAddress) throws SQLException{
    	String sql = "INSERT INTO deliveryaddress(U_Id, D_Name, D_Address, D_Phone) values(?, ?, ?, ?)";
    	return dbHelper.insertPrepareSQL(sql, 
    			newAddress.getUId(),
    			newAddress.getDName(),
    			newAddress.getDAddress(),
    			newAddress.getDPhone());	
    }
    
}
