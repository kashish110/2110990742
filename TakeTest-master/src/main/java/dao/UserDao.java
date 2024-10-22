package dao;

import java.sql.SQLException;

import database.DbConnection;

public class UserDao {
	
	public static int getUserId(String mobile, String password) {
		
		String query = "SELECT user_id FROM user WHERE mobile = ? AND password = ?";
		try(DbConnection db = new DbConnection();){
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setString(1, mobile);
			db.pstm.setString(2, password);
			db.rs = db.pstm.executeQuery();
			if(db.rs.next()) return db.rs.getInt(1);
			else return -1;
		} 
		catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	public static boolean existsMobile(String mobile) {
		
		String query = "SELECT name FROM user WHERE mobile = ? ";
		try(DbConnection db = new DbConnection();){
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setString(1, mobile);
			db.rs = db.pstm.executeQuery();
			return db.rs.next();
		} 
		catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static boolean existsEmail(String email) {
		
		String query = "SELECT name FROM user WHERE email = ? ";
		try(DbConnection db = new DbConnection();){
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setString(1, email);
			db.rs = db.pstm.executeQuery();
			return db.rs.next();
		} 
		catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public static boolean addUser(String name, String mobile, String password, String email) {
		String query = "INSERT INTO user (name, mobile, password, email) VALUES(?,?,?,?)";
		try(DbConnection db = new DbConnection()){
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setString(1, name);
			db.pstm.setString(2, mobile);
			db.pstm.setString(3, password);
			db.pstm.setString(4, email);
			int count = db.pstm.executeUpdate();
	        return count > 0;
		} 
		catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static String getUserName(String mobile) {
		
		String query = "SELECT name FROM user WHERE mobile = ?";
		try(DbConnection db = new DbConnection();){
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setString(1, mobile);
			db.rs = db.pstm.executeQuery();
			String ans = "";
			while (db.rs.next()) ans = db.rs.getString("name");
			return ans;
		} 
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static String getPhone(int user_id) {
		
		String query = "SELECT mobile FROM user WHERE user_id = ?";
		try(DbConnection db = new DbConnection();){
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setInt(1, user_id);
			db.rs = db.pstm.executeQuery();
			String ans = "";
			while (db.rs.next()) ans = db.rs.getString("mobile");
			return ans;
		} 
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}

	public static String getEmail(int user_id) {
		
		String query = "SELECT email FROM user WHERE user_id = ?";
		try(DbConnection db = new DbConnection();){
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setInt(1, user_id);
			db.rs = db.pstm.executeQuery();
			String ans = "";
			while (db.rs.next()) ans = db.rs.getString("email");
			return ans;
		} 
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
		
}



