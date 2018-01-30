package dbUtil;

import java.sql.Connection;
import java.sql.SQLException;

public interface IConnectionProvider {
	public Connection getConnection(String sourceName) throws SQLException;
}
