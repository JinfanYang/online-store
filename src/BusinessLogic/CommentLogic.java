package BusinessLogic;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dbUtil.DbHelper;
import dbUtil.IConnectionProvider;
import dbUtil.JdbcProvider;

import Entity.Comment;

public class CommentLogic {
	private IConnectionProvider connectionProvider = null;
    private String sourceName = "estore";
    private DbHelper dbHelper;
    public CommentLogic(){
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
    
    //add
    public int addComment(Entity.Comment acomment) throws SQLException{
    	int i = 0;
    	String sql = "INSERT INTO comments(O_Id, U_Name, Co_Star, Co_Comment) VALUES(?,?,?,?)";
    	i += dbHelper.insertPrepareSQL(sql, 
    			acomment.getOId(),
    			acomment.getUName(),
    			acomment.getCStar(),
    			acomment.getCComment());
    	
    	sql = "UPDATE orders SET O_Status=6 WHERE O_Id=?";
    	i += dbHelper.updatePrepareSQL(sql, acomment.getOId());
    	
    	return i;
    }
    
    public List<Comment> findComment(String pid) throws Exception{
    	List<Comment> comments = new ArrayList<Comment>();
    	String sql = "SELECT * FROM comments, orders, products WHERE comments.O_Id = orders.O_Id AND orders.SKU = products.SKU AND products.P_Id = ?";
    	ResultSet rs = dbHelper.query(sql, pid);
    	while(rs.next()){
    		Comment acomment = new Comment();
    		acomment.setOId(rs.getString(1));
    		acomment.setUName(rs.getString(2));
    		acomment.setCStar(rs.getInt(3));
    		acomment.setCComment(rs.getString(4));
    		comments.add(acomment);
    	}
    	return comments;
    }

}
