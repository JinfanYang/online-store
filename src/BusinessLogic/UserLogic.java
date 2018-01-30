package BusinessLogic;

import dbUtil.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserLogic {
	private IConnectionProvider connectionProvider = null;
    private String sourceName = "estore";
    private DbHelper dbHelper;
	
    //connect to database
    public UserLogic(){
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
    
    //login use UserName
    public Entity.User loginbyName(String u_name, String password) throws Exception {
		ResultSet rs = dbHelper.query("SELECT * FROM users WHERE U_Name = ? AND Password = ?", u_name, password);
		Entity.User item = new Entity.User();
		if (rs.next()){
			item.setUserId(rs.getInt(1));
			item.setUserName(rs.getString(2));
			item.setPassword(rs.getString(3));
			item.setGender(rs.getInt(4));
			item.setPhone(rs.getString(5));
			item.setEmail(rs.getString(6));
			
			return item;
		}
		else{
			return null;
		}
	}
    
    //login use Email
    public Entity.User loginbyEmail(String email, String password) throws Exception {
		ResultSet rs = dbHelper.query("SELECT * FROM users WHERE Email = ? AND Password = ?", email, password);
		Entity.User item = new Entity.User();
		if (rs.next()){
			item.setUserId(rs.getInt(1));
			item.setUserName(rs.getString(2));
			item.setPassword(rs.getString(3));
			item.setGender(rs.getInt(4));
			item.setPhone(rs.getString(5));
			item.setEmail(rs.getString(6));
			
			return item;
		}
		else{
			return null;
		}
	}
    
    //add user Ôö
    public int add(Entity.User item) throws SQLException {
		return dbHelper.insertPrepareSQL(
				"INSERT INTO users(U_Name, Password, Gender, Phone, Email) VALUES(?,?,?,?,?)",
				item.getUserName(),
				item.getPassword(),
				item.getGender(),
				item.getPhone(),
				item.getEmail());
	}
    
    //delete user É¾
    public void remove(int id) throws Exception{
		String sql = "DELETE FROM users WHERE U_Id=?";
		dbHelper.updatePrepareSQL(sql, id);
	}
    
    //save user ¸Ä
    public int save(Entity.User item) throws SQLException {
		return dbHelper.updatePrepareSQL(
				"UPDATE users SET U_Name=?, Password=?, Gender=?, Phone=?, Email=? WHERE U_Id=?",
				item.getUserName(),
				item.getPassword(),
				item.getGender(),
				item.getPhone(),
				item.getEmail(),
				item.getUserId());
	}
    
    //find one user ²é
    public Entity.User findById(int u_id) throws Exception{
		String sql = "SELECT * FROM users WHERE U_Id=?";
		ResultSet rs = dbHelper.findById(sql, u_id);
		if (rs.next()){
			return this.BuildItem(rs);
		}
		else
			return null;
	}
	
    //find all user
	public List<Entity.User> findAll() throws Exception{
		String sql = "SELECT * FROM users";
		ResultSet rs = dbHelper.query(sql);
		List<Entity.User> items = new ArrayList<Entity.User>();
		while (rs.next()){
			items.add(this.BuildItem(rs));
		}
		return items;
	}
	
	public int query(String sql) throws Exception{
		ResultSet rs = dbHelper.query(sql);
		if(rs.next()){
			return rs.getRow();
		}
		else{
			return 0;
		}
	}
	
	//user count
	public int count() throws Exception{
		int count = 0;
		String sql = "SELECT COUNT(*) FROM users";
		ResultSet rs = dbHelper.query(sql);
		if(rs.next()){
			count = rs.getInt(1);
		}
		return count;
	}
	
	//get a user's purchase
	public int getProducts(int uid) throws Exception{
		int count = 0;
		String sql = "SELECT COUNT(*) FROM orders WHERE U_Id = ?";
		ResultSet rs = dbHelper.query(sql, uid);
		if(rs.next()){
			count = rs.getInt(1);
		}
		return count;
	}
	
	private Entity.User BuildItem(ResultSet rs) throws SQLException{
		Entity.User item = new Entity.User();
		item.setUserId(rs.getInt(1));
		item.setUserName(rs.getString(2));
		item.setPassword(rs.getString(3));
		item.setGender(rs.getInt(4));
		item.setPhone(rs.getString(5));
		item.setEmail(rs.getString(6));
		
		return item;
	} 
}
