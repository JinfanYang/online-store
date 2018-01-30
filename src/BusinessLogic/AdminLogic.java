package BusinessLogic;

import java.sql.ResultSet;
import java.sql.SQLException;

import dbUtil.DbHelper;
import dbUtil.IConnectionProvider;
import dbUtil.JdbcProvider;

public class AdminLogic {
	private IConnectionProvider connectionProvider = null;
    private String sourceName = "estore";
    private DbHelper dbHelper;
    public AdminLogic(){
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
    
    //µÇÂ¼
    public Entity.Admin login(String loginName, String password) throws Exception {
		ResultSet rs = dbHelper.query("SELECT * FROM admin WHERE A_Name = ? AND A_Password = ?", loginName, password);
		Entity.Admin admin = new Entity.Admin();
		if (rs.next())
		{
			admin.setAId(rs.getInt(1));
			admin.setAName(rs.getString(2));
			admin.setAPassword(rs.getString(3));
			return admin;
		}
		return null;
	}
    
    //Ôö
    public int add(Entity.Admin item) throws SQLException {
		return dbHelper.insertPrepareSQL(
				"INSERT INTO admin(A_Name, A_Password) VALUES(?,?,?)",
				item.getAName(),
				item.getAPassword());
	}
	
    //É¾
    public void remove(int id) throws Exception{
		String sql = "DELETE FROM admin WHERE A_Id=?";
		dbHelper.updatePrepareSQL(sql, id);
	}
	
	//²é
	public String findByName(String name) throws Exception {
		// TODO Auto-generated method stub
		ResultSet rs = dbHelper.query("SELECT * FROM admin WHERE A_Name = ?", name);
		if (rs.next()){
			return rs.getString(3);
		}
			
		return null;
	}
	
	//²é
	public String findById(int id) throws Exception {
		// TODO Auto-generated method stub
		ResultSet rs = dbHelper.query("SELECT * FROM admin WHERE A_Id = ?", id);
		if (rs.next()){
			return rs.getString(3);
		}
				
		return null;
	}
	
	
	public int findIdByName(String name) throws Exception {
		// TODO Auto-generated method stub
		ResultSet rs = dbHelper.query("SELECT id FROM admin WHERE A_Name = ?", name);
		if (rs.next()){
			return rs.getInt(1);
		}
		return 0;
	}

	//ÐÞ¸ÄÃÜÂë
	public void changeps(String psn,int id) throws SQLException {
		// TODO Auto-generated method stub
		dbHelper.updatePrepareSQL("UPDATE admin SET A_Password=? where A_Id=?",psn,id);
	}
}
