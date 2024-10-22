package dao;

import java.sql.SQLException;
import database.DbConnection;

public class AdminDao {

	public boolean isValidAdmin(String username, String password) throws Exception {
		
		String query = "SELECT * FROM admin WHERE username = ? AND password = ?";

		try(DbConnection db = new DbConnection();){
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setString(1, username);
			db.pstm.setString(2, password);
			db.rs = db.pstm.executeQuery();
			return db.rs.next();
		} 
		catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

	}
}
