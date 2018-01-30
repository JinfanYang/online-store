package dbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbHelper {
	private Connection connection;
    private PreparedStatement ps;
    private ResultSet rs;
    private String sourceName;
    private IConnectionProvider connectionProvider;
    public DbHelper(IConnectionProvider connectionProvider,String sourceName) {
        this.connectionProvider = connectionProvider;
        this.sourceName = sourceName;
    }
    
    //get connection
    public Connection getConnection() throws SQLException {
        if(sourceName == null)
            throw new SQLException("Ã»ÓÐÉèÖÃÊý¾ÝÔ´");
        int Times = 0;
        while (connection == null || connection.isClosed()) {
            try {
                closeConnection();
                connection = connectionProvider.getConnection(sourceName);
                break;
            } catch (Exception sqle) {
            }finally{
                if(Times>5){
                    throw new SQLException("»ñÈ¡Á¬½Ó´ÎÊýÒÑ¾­³¬¹ý6´Î¡£²»ÔÙ³¢ÊÔÖØÐÂ»ñÈ¡");
                }
                ++Times;
            }
        }
        return connection;
    }
    
    //find object base on sql statement
    public Object findObject(String sql,Object... objs) throws SQLException {
        try {
            getConnection();
            ps = connection.prepareStatement(sql);
            if(objs != null) {
                for(int i = 0 ; i < objs.length; i ++)
                    ps.setObject(i + 1, objs[i]);
            }
            rs = ps.executeQuery();
            if(rs.next())
                return rs.getObject(1);
            else
                return null;
        } finally {
            close();
        }
    }
    
    //find object by id
    public ResultSet findById(String sql, Object id) throws Exception {
        getConnection();
        ps = connection.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        if(id != null) {
            ps.setObject(1, id);
        }
        return ps.executeQuery();
    }
    
    //find all 
    public ResultSet query(String sql, Object... objs) throws Exception {
        getConnection();
        ps = connection.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        if(objs != null) {
            for(int i = 0; i < objs.length; i ++)
                ps.setObject(i + 1, objs[i]);
        }
        return ps.executeQuery();
    }
    
    //insert
    public int insertPrepareSQL(String sql,Object... objs) throws SQLException {
        int countRow = 0;
        int key = 0;
        try {
            getConnection();
            connection.setAutoCommit(false);
            ps = connection.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);           
            if(objs != null) {
                for(int i = 0; i < objs.length; i ++)
                    ps.setObject(i+1,objs[i]);
            }
            countRow = ps.executeUpdate();
            if(countRow > 0) {
                key = 1;
            }
            connection.commit();
        } catch (SQLException e) {
            countRow = 0;
            connection.rollback();
            closeConnection();
            throw e;
        } finally {
            if (connection != null) {
                connection.setAutoCommit(true);
            }
            close();
        }
        return key;
    }
    
    //update
    public int updatePrepareSQL(String sql,Object... objs) throws SQLException {
        int countRow = 0;
        try {
            getConnection();
            connection.setAutoCommit(false);
            ps = connection.prepareStatement(sql);
            if(objs != null) {
                for(int i = 0; i < objs.length; i ++)
                    ps.setObject(i+1,objs[i]);
            }
            countRow = ps.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            countRow = 0;
            connection.rollback();
            closeConnection();
            throw e;
        } finally {
            if (connection != null) {
                connection.setAutoCommit(true);
            }
            close();
        }
        return countRow;
    }
    
    public void closeConnection() {
        try {
        	if (connection != null) {
           		connection.close();
        	}
        	connection = null;
        } catch (Exception e) {}
    }
    
    public void close() {
        try {
            super.finalize();
            if (rs != null) {
                rs.close();
                rs = null;
            }
            if (ps != null) {
                ps.close();
                ps = null;
            }
            if (connection != null) {
                connection.close();
                connection = null;
            }
        } catch (Throwable te) {
        }
    }
}
