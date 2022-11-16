package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBHelper;
import vo.User2Vo;

public class User2Dao extends DBHelper {
	private static User2Dao instance = new User2Dao();
	public static User2Dao getInstance () {
		return instance;
	}
	private User2Dao () {}
	
	public void insertUser() {
		
	}
	public void selectUser() {
		
	}
	public List<User2Vo> selectUsers() {
		List<User2Vo> users = null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from `user2`");
			users = new ArrayList<>();
			while(rs.next()) {
				User2Vo vo = new User2Vo();
				vo.setUid(rs.getString(1));
				vo.setName(rs.getString(2));
				vo.setHp(rs.getString(3));
				vo.setAge(rs.getInt(4));
				
				users.add(vo);
			}
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return users;
	}
	public void deleteUser() {
		
	}
	public void updateUser() {
		
	}
	
}
