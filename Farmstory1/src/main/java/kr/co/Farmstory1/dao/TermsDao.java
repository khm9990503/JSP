package kr.co.Farmstory1.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.Farmstory1.db.DBCP;
import kr.co.Farmstory1.db.Sql;

public class TermsDao {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private static TermsDao instance = new TermsDao();
	public static TermsDao getInstance () {
		return instance;
	}
	private TermsDao() {}
	
	public List<String> selectTerms() {
		logger.info("selectTerms start...");
		List<String> ts = null;
		try {
			 Connection conn = DBCP.getConnection();
			 Statement stmt = conn.createStatement();
			 ResultSet rs = stmt.executeQuery(Sql.SELECT_TERMS);
			 ts = new ArrayList<>();
			 while(rs.next()) {
				 ts.add(rs.getString(1));
				 ts.add(rs.getString(2));
			 }
			 rs.close();
			 stmt.close();
			 conn.close();
			 
		} catch (Exception e) {
			logger.error(e.getMessage());
		} 
		return ts;
	}
}
