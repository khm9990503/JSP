package kr.co.jboard1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.co.jboard1.bean.ArticleBean;
import kr.co.jboard1.bean.FileBean;
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
	public ArticleBean selectArticle(String no) {
		ArticleBean AB= null;
		
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLE);
			psmt.setString(1, no);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()){
				AB = new ArticleBean();
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
				AB.setFno(rs.getInt(12));
				AB.setOriName(rs.getString(13));
				AB.setDownload(rs.getInt(14));
			}
			rs.close();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return AB;
	}
	
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
	
	public FileBean selectFile(String fno) {
		FileBean fb = null;
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_FILE);
			psmt.setString(1, fno);
			ResultSet rs = psmt.executeQuery();
			if(rs.next()){
				fb = new FileBean();
				fb.setFno(rs.getInt(1));
				fb.setParent(rs.getInt(2));
				fb.setNewName(rs.getString(3));
				fb.setOriName(rs.getString(4));
				fb.setDownload(rs.getInt(5));
				fb.setRdate(rs.getString(6));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return fb;
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
	
	// 조회수 업데이트
	public void updateArticleHit(String no) {
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE_HIT);
			psmt.setString(1, no);
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	// 다운로드 카운트 업데이트
	public void updateFileDownload(String fno) {
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_FILE_DOWNLOAD);
			psmt.setString(1, fno);
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
