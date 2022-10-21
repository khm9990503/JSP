package config;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBC {
	
	private static JDBC instance = new JDBC();
	
	public static JDBC getInstance() {
		return instance;
	}
	
	private JDBC() {}
	
	private final String host = "jdbc:mysql://127.0.0.1:3306/java1_bookstore";
	private final String user = "root";
	private final String pass = "1234";
	
	public Connection getConnection() throws SQLException, ClassNotFoundException {
		// 1단계
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 2단계
		return DriverManager.getConnection(host,user,pass);
	}
	
}