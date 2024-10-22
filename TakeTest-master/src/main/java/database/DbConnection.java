package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbConnection implements AutoCloseable {

	public Connection con;
	public Statement stm;
	public PreparedStatement pstm;
	public ResultSet rs;

	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public DbConnection() {
		try {
			final String url = "jdbc:mysql://localhost:3306/mind_gauge";
			final String user = "root" ;
			final String password = "Kashish11@";
			con = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void close() throws Exception {
		con.close();
	}
}
