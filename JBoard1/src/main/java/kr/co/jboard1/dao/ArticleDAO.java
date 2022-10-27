package kr.co.jboard1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.co.jboard1.bean.ArticleBean;
import kr.co.jboard1.db.DBCP;
import kr.co.jboard1.db.Sql;

public class ArticleDAO {
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	private ArticleDAO() {}
	
	// 기본 CRUD
	public void insertArticle() {}
	public void selectArticle() {}
	public List<ArticleBean> selectArticles(int start) {
		List<ArticleBean> articles = new ArrayList<>();
		try{
			Connection conn = DBCP.getConnection();
			
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLES);
			psmt.setInt(1, start);
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()){
				ArticleBean AB = new ArticleBean();
				AB.setNo(rs.getInt(1));
				AB.setParent(rs.getInt(2));
				AB.setComment(rs.getInt(3));
				AB.setCate(rs.getString(4));
				AB.setTitle(rs.getString(5));
				AB.setContent(rs.getString(6));
				AB.setFile(rs.getInt(7));
				AB.setHit(rs.getInt(8));
				AB.setUid(rs.getString(9));
				AB.setRdate(rs.getString(11));
				AB.setNick(rs.getString(12));
				
				articles.add(AB);
			}
			rs.close();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return articles;
	}
	public void updateArticle() {}
	public void deleteArticle() {}
	
	// 전체 게시물 카운트
	public int selectCountTotal() {
		int total = 0;
		try {
			Connection conn = DBCP.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(Sql.SELECT_COUNT_TOTAL);
			if(rs.next()) {
				total = rs.getInt(1);
			}
			rs.close();
			stmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return total;
	}
}
