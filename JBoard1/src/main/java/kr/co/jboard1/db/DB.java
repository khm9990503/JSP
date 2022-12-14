package kr.co.jboard1.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DB {
	
	private static DB instance = new DB();
	
	public static DB getInstance() {
		return instance;
	}
	
	private DB() {}
	
	private final String host = "jdbc:mysql://127.0.0.1:3306/java1_college";
	private final String user = "root";
	private final String pass = "1234";
	
	public Connection getConnection() throws SQLException, ClassNotFoundException {
		// 1단계
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 2단계
		return DriverManager.getConnection(host,user,pass);
	}
	
}
