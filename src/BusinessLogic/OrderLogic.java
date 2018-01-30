package BusinessLogic;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import dbUtil.DbHelper;
import dbUtil.IConnectionProvider;
import dbUtil.JdbcProvider;

import Entity.Order;

public class OrderLogic {
	private IConnectionProvider connectionProvider = null;
    private String sourceName = "estore";
    private DbHelper dbHelper;
    public OrderLogic(){
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
    
    //添加订单
    public int add(int userId, String sku, int addressId, String oid) throws Exception{
    	String sql = "SELECT C_Number FROM cart WHERE U_Id=? AND SKU=?";
    	ResultSet rs = dbHelper.query(sql, userId, sku);
    	int number = 0;
    	String deliveryName = "", deliveryPhone="", deliveryAddress="";
    	String picstr = "";
    	double price=0;
    	String name="";
    	if(rs.next()){
    		number = rs.getInt(1);
    	}
    	sql = "SELECT * FROM deliveryaddress WHERE D_No = ?";
    	rs = dbHelper.query(sql, addressId);
    	if(rs.next()){
    		deliveryName = rs.getString(2);
    		deliveryPhone = rs.getString(4);
    		deliveryAddress = rs.getString(3);
    	}
    	
    	sql = "SELECT * FROM products, productspic WHERE products.P_Id = productspic.P_Id AND products.SKU = ?";
    	rs = dbHelper.query(sql, sku);
    	if(rs.next()){
    		picstr = rs.getString(15);
    		if(rs.getDouble(8) >0)
    		{
    			price = rs.getDouble(8);
    		}
    		else{
    			price = rs.getDouble(7);
    		}
    		name = rs.getString(5);
    	}
    	
    	sql = "INSERT INTO orders(O_Id, U_Id, SKU, O_Name, O_Price, O_Number, O_Date, O_Status, O_DeliveryName, O_DeliveryAddress, O_DeliveryPhone, O_Pic) values(?,?,?,?,?,?,?,?,?,?,?,?)";
    	int i = dbHelper.insertPrepareSQL(sql, 
    			oid,
    			userId,
    			sku,
    			name,
    			price,
    			number,
    			new Date(),
    			0,
    			deliveryName,
    			deliveryAddress,
    			deliveryPhone,
    			picstr);
    	
    	return i;
    }
    
    //find all oid
    public List<String> findAllOid() throws Exception{
    	String sql = "SELECT O_Id FROM orders ORDER BY O_Date DESC";
    	List<String> oids = new ArrayList<String>();
    	ResultSet rs = dbHelper.query(sql);
    	while(rs.next()){
    		if(rs.getRow() == 1){
    			String[] oid = rs.getString(1).split("-");
    			oids.add(oid[0]);
    		}
    		else{
    			String aoids = rs.getString(1);
				String[] oid1 = aoids.split("-");
				boolean ifexists = false;
				for(int i = 0; i<oids.size(); i++){
					if(oid1[0].equals(oids.get(i))){
						ifexists = true;
					}
				}
				if(!ifexists){
					oids.add(oid1[0]);
				}
    		}
    	}
    	return oids;
    }
    
    //find items in one order
    public List<Order> findAllItems(String oid) throws Exception{
    	String[] oids = oid.split("-");
    	String sql = "SELECT * FROM orders WHERE O_Id like '"+ oids[0] +"%'";
    	List<Order> items = new ArrayList<Order>();
    	ResultSet rs = dbHelper.query(sql);
    	while(rs.next()){
    		Order item = new Order();
    		item.setOId(rs.getString(1));
    		item.setUId(rs.getInt(2));
    		item.setSKU(rs.getString(3));
    		item.setOName(rs.getString(4));
    		item.setOPrice(rs.getDouble(5));
    		item.setONumber(rs.getInt(6));
    		item.setODate(rs.getDate(7));
    		item.setOSentDate(rs.getDate(8));
    		item.setOConfirmDate(rs.getDate(9));
    		item.setOStatus(rs.getInt(10));
    		item.setODeliveryName(rs.getString(11));
    		item.setODeliveryAddress(rs.getString(12));
    		item.setODeliveryPhone(rs.getString(13));
    		item.setOLocation(rs.getString(14));
    		item.setOPic(rs.getString(15));
    		items.add(item);
    	}
    	return items;
    }
    
    //find all oid by userId
    public List<String> findOid(int userId) throws Exception{
    	String sql = "SELECT O_Id FROM orders WHERE U_Id=? ORDER BY O_Date DESC";
    	List<String> oids = new ArrayList<String>();
    	ResultSet rs = dbHelper.query(sql, userId);
    	while(rs.next()){
    		oids.add(rs.getString(1));
    	}
    	return oids;
    }
    
    //find all oid to pay
    public List<String> findPayOid(int userId) throws Exception{
    	String sql = "SELECT O_Id FROM orders WHERE U_Id=? AND O_Status = 0 ORDER BY O_Date DESC";
    	List<String> oids = new ArrayList<String>();
    	ResultSet rs = dbHelper.query(sql, userId);
    	while(rs.next()){
    		oids.add(rs.getString(1));
    	}
    	return oids;
    }
    
  //find all oid to remind
    public List<String> findRemindOid(int userId) throws Exception{
    	String sql = "SELECT O_Id FROM orders WHERE U_Id=? AND (O_Status = 1 OR O_Status = 2) ORDER BY O_Date DESC";
    	List<String> oids = new ArrayList<String>();
    	ResultSet rs = dbHelper.query(sql, userId);
    	while(rs.next()){
    		oids.add(rs.getString(1));
    	}
    	return oids;
    }
    
  //find all oid to confirm
    public List<String> findConfirmOid(int userId) throws Exception{
    	String sql = "SELECT O_Id FROM orders WHERE U_Id=? AND O_Status = 3 ORDER BY O_Date DESC";
    	List<String> oids = new ArrayList<String>();
    	ResultSet rs = dbHelper.query(sql, userId);
    	while(rs.next()){
    		oids.add(rs.getString(1));
    	}
    	return oids;
    }
    
  //find all oid to comment
    public List<String> findCommentOid(int userId) throws Exception{
    	String sql = "SELECT O_Id FROM orders WHERE U_Id=? AND O_Status = 4 ORDER BY O_Date DESC";
    	List<String> oids = new ArrayList<String>();
    	ResultSet rs = dbHelper.query(sql, userId);
    	while(rs.next()){
    		oids.add(rs.getString(1));
    	}
    	return oids;
    }
    
    //find all items in an oid
    public List<Order> findItems(int userId, String oid) throws Exception{
    	String[] oids = oid.split("-");
    	String sql = "SELECT * FROM orders WHERE U_Id=? AND O_Id like '"+ oids[0] +"%'";
    	List<Order> items = new ArrayList<Order>();
    	ResultSet rs = dbHelper.query(sql, userId);
    	while(rs.next()){
    		Order item = new Order();
    		item.setOId(rs.getString(1));
    		item.setUId(rs.getInt(2));
    		item.setSKU(rs.getString(3));
    		item.setOName(rs.getString(4));
    		item.setOPrice(rs.getDouble(5));
    		item.setONumber(rs.getInt(6));
    		item.setODate(rs.getDate(7));
    		item.setOSentDate(rs.getDate(8));
    		item.setOConfirmDate(rs.getDate(9));
    		item.setOStatus(rs.getInt(10));
    		item.setODeliveryName(rs.getString(11));
    		item.setODeliveryAddress(rs.getString(12));
    		item.setODeliveryPhone(rs.getString(13));
    		item.setOLocation(rs.getString(14));
    		item.setOPic(rs.getString(15));
    		items.add(item);
    	}
    	return items;
    }
    
    //find all to pay
    public List<Order> findPayItems(int userId, String oid) throws Exception{
    	String[] oids = oid.split("-");
    	String sql = "SELECT * FROM orders WHERE U_Id=? AND O_Status=0 AND O_Id like '"+ oids[0] +"%'";
    	List<Order> items = new ArrayList<Order>();
    	ResultSet rs = dbHelper.query(sql, userId);
    	while(rs.next()){
    		Order item = new Order();
    		item.setOId(rs.getString(1));
    		item.setUId(rs.getInt(2));
    		item.setSKU(rs.getString(3));
    		item.setOName(rs.getString(4));
    		item.setOPrice(rs.getDouble(5));
    		item.setONumber(rs.getInt(6));
    		item.setODate(rs.getDate(7));
    		item.setOSentDate(rs.getDate(8));
    		item.setOConfirmDate(rs.getDate(9));
    		item.setOStatus(rs.getInt(10));
    		item.setODeliveryName(rs.getString(11));
    		item.setODeliveryAddress(rs.getString(12));
    		item.setODeliveryPhone(rs.getString(13));
    		item.setOLocation(rs.getString(14));
    		item.setOPic(rs.getString(15));
    		items.add(item);
    	}
    	return items;
    }
    
    //find all to remind
    public List<Order> findRemindItems(int userId, String oid) throws Exception{
    	String[] oids = oid.split("-");
    	String sql = "SELECT * FROM orders WHERE U_Id=? AND (O_Status=1 OR O_Status=2) AND O_Id like '"+ oids[0] +"%'";
    	List<Order> items = new ArrayList<Order>();
    	ResultSet rs = dbHelper.query(sql, userId);
    	while(rs.next()){
    		Order item = new Order();
    		item.setOId(rs.getString(1));
    		item.setUId(rs.getInt(2));
    		item.setSKU(rs.getString(3));
    		item.setOName(rs.getString(4));
    		item.setOPrice(rs.getDouble(5));
    		item.setONumber(rs.getInt(6));
    		item.setODate(rs.getDate(7));
    		item.setOSentDate(rs.getDate(8));
    		item.setOConfirmDate(rs.getDate(9));
    		item.setOStatus(rs.getInt(10));
    		item.setODeliveryName(rs.getString(11));
    		item.setODeliveryAddress(rs.getString(12));
    		item.setODeliveryPhone(rs.getString(13));
    		item.setOLocation(rs.getString(14));
    		item.setOPic(rs.getString(15));
    		items.add(item);
    	}
    	return items;
    }
    
    //find all to confirm
    public List<Order> findConfirmItems(int userId, String oid) throws Exception{
    	String[] oids = oid.split("-");
    	String sql = "SELECT * FROM orders WHERE U_Id=? AND O_Status=3 AND O_Id like '"+ oids[0] +"%'";
    	List<Order> items = new ArrayList<Order>();
    	ResultSet rs = dbHelper.query(sql, userId);
    	while(rs.next()){
    		Order item = new Order();
    		item.setOId(rs.getString(1));
    		item.setUId(rs.getInt(2));
    		item.setSKU(rs.getString(3));
    		item.setOName(rs.getString(4));
    		item.setOPrice(rs.getDouble(5));
    		item.setONumber(rs.getInt(6));
    		item.setODate(rs.getDate(7));
    		item.setOSentDate(rs.getDate(8));
    		item.setOConfirmDate(rs.getDate(9));
    		item.setOStatus(rs.getInt(10));
    		item.setODeliveryName(rs.getString(11));
    		item.setODeliveryAddress(rs.getString(12));
    		item.setODeliveryPhone(rs.getString(13));
    		item.setOLocation(rs.getString(14));
    		item.setOPic(rs.getString(15));
    		items.add(item);
    	}
    	return items;
    }
    
    //find all to comment
    public List<Order> findCommentItems(int userId, String oid) throws Exception{
    	String[] oids = oid.split("-");
    	String sql = "SELECT * FROM orders WHERE U_Id=? AND O_Status=4 AND O_Id like '"+ oids[0] +"%'";
    	List<Order> items = new ArrayList<Order>();
    	ResultSet rs = dbHelper.query(sql, userId);
    	while(rs.next()){
    		Order item = new Order();
    		item.setOId(rs.getString(1));
    		item.setUId(rs.getInt(2));
    		item.setSKU(rs.getString(3));
    		item.setOName(rs.getString(4));
    		item.setOPrice(rs.getDouble(5));
    		item.setONumber(rs.getInt(6));
    		item.setODate(rs.getDate(7));
    		item.setOSentDate(rs.getDate(8));
    		item.setOConfirmDate(rs.getDate(9));
    		item.setOStatus(rs.getInt(10));
    		item.setODeliveryName(rs.getString(11));
    		item.setODeliveryAddress(rs.getString(12));
    		item.setODeliveryPhone(rs.getString(13));
    		item.setOLocation(rs.getString(14));
    		item.setOPic(rs.getString(15));
    		items.add(item);
    	}
    	return items;
    }
    
    //find an order 
    public List<Order> findById(String oid) throws Exception{
    	String[] oids = oid.split("-");
    	String sql = "SELECT * FROM orders WHERE O_Id like '"+ oids[0]+"%'";
    	ResultSet rs = dbHelper.query(sql);
    	List<Order> items = new ArrayList<Order>();
    	while(rs.next()){
    		Order item = new Order();
    		item.setOId(rs.getString(1));
    		item.setUId(rs.getInt(2));
    		item.setSKU(rs.getString(3));
    		item.setOName(rs.getString(4));
    		item.setOPrice(rs.getDouble(5));
    		item.setONumber(rs.getInt(6));
    		item.setODate(rs.getDate(7));
    		item.setOSentDate(rs.getDate(8));
    		item.setOConfirmDate(rs.getDate(9));
    		item.setOStatus(rs.getInt(10));
    		item.setODeliveryName(rs.getString(11));
    		item.setODeliveryAddress(rs.getString(12));
    		item.setODeliveryPhone(rs.getString(13));
    		item.setOLocation(rs.getString(14));
    		item.setOPic(rs.getString(15));
    		items.add(item);
    	}
    	return items;
    }
    
    //confirm order
    public int confirm(String oid) throws Exception{
    	String sql = "SELECT O_Id FROM orders WHERE O_Id like '"+oid+"%'";
    	ResultSet rs = dbHelper.query(sql);
    	List<String> oids = new ArrayList<String>();
    	int update = 0;
    	while(rs.next()){
    		oids.add(rs.getString(1));
    	}
    	
    	for(int i = 0; i<oids.size(); i++){
    		sql = "UPDATE orders SET O_ConfirmDate=?, O_Status=4 WHERE O_Id=?";
    		update = dbHelper.updatePrepareSQL(sql, new Date(), oids.get(i));
    	}
    	return update;
    }
    
    //cancel order
    public int cancel(String oid) throws Exception{
    	String[] aoid = oid.split("-");
    	String sql = "SELECT O_Id FROM orders WHERE O_Id like '"+aoid[0]+"%'";
    	ResultSet rs = dbHelper.query(sql);
    	List<String> oids = new ArrayList<String>();
    	int update = 0;
    	while(rs.next()){
    		oids.add(rs.getString(1));
    	}
    	
    	for(int i = 0; i<oids.size(); i++){
    		sql = "UPDATE orders SET O_Status=5 WHERE O_Id=?";
    		update = dbHelper.updatePrepareSQL(sql, oids.get(i));
    	}
    	
    	return update;
    }
    
    //count
    public int count() throws Exception{
    	int count = 0;
    	String sql = "SELECT COUNT(*) FROM orders";
    	ResultSet rs = dbHelper.query(sql);
    	if(rs.next()){
    		count = rs.getInt(1);
    	}
    	return count;
    }
    
    //find all orders
    public List<Order> findAllOrders() throws Exception{
    	List<Order> orders = new ArrayList<Order>();
    	String sql = "SELECT * FROM orders";
    	ResultSet rs = dbHelper.query(sql);
    	while(rs.next()){
    		Entity.Order aorder = new Entity.Order();
    		aorder.setOId(rs.getString(1));
    		aorder.setUId(rs.getInt(2));
    		aorder.setSKU(rs.getString(3));
    		aorder.setOName(rs.getString(4));
    		aorder.setOPrice(rs.getDouble(5));
    		aorder.setONumber(rs.getInt(6));
    		aorder.setODate(rs.getDate(7));
    		aorder.setOSentDate(rs.getDate(8));
    		aorder.setOConfirmDate(rs.getDate(9));
    		aorder.setOStatus(rs.getInt(10));
    		aorder.setODeliveryName(rs.getString(11));
    		aorder.setODeliveryAddress(rs.getString(12));
    		aorder.setODeliveryPhone(rs.getString(13));
    		aorder.setOLocation(rs.getString(14));
    		aorder.setOPic(rs.getString(15));
    		orders.add(aorder);
    	}
    	return orders;
    }
    
    //发货
    public int send(String oid) throws Exception{
    	int updatecount = 0;
    	String sql = "UPDATE orders SET O_Status=3 WHERE O_Id like '"+oid+"%'";
    	updatecount = dbHelper.updatePrepareSQL(sql);
    	return updatecount;
    }
    
    //更新物流信息
    public int updatelocation(String oid, String newlocation) throws Exception{
    	int updatecount = 0;
    	String sql = "SELECT O_Location FROM orders WHERE O_Id like '"+oid+"%'";
    	ResultSet rs = dbHelper.query(sql);
    	String location = "";
    	if(rs.next()){
    		location = rs.getString(1);
    	}
    	if(location == null){
    		location = newlocation;
    	}
    	else{
    		location = location + "/" + newlocation;
    	}
    	sql = "UPDATE orders SET O_Location=? WHERE O_Id like '"+oid+"%'";
    	updatecount = dbHelper.updatePrepareSQL(sql, location);
    	return updatecount;
    }
}
