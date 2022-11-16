package kr.co.Farmstory1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.Farmstory1.bean.ArticleBean;
import kr.co.Farmstory1.bean.FileBean;
import kr.co.Farmstory1.db.DBCP;
import kr.co.Farmstory1.db.Sql;



public class ArticleDAO {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	private ArticleDAO() {}
	
	// 기본 CRUD
	public int insertArticle(ArticleBean article) {
		int parent = 0;
		try{
			logger.info("insertArticle start...");
			Connection conn = DBCP.getConnection();
			conn.setAutoCommit(false); // 트렌젝션 시작
			
			Statement stmt = conn.createStatement();
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_ARTICLE);
			
			psmt.setString(1, article.getCate());
			psmt.setString(2, article.getTitle());
			psmt.setString(3, article.getContent());
			psmt.setInt(4, article.getFname() == null ? 0 : 1);
			psmt.setString(5, article.getUid());
			psmt.setString(6, article.getRegip());
			
			psmt.executeUpdate(); // insert
			ResultSet rs = stmt.executeQuery(Sql.SELECT_MAX_NO); // select
			
			conn.commit();			// 트렌젝션 끝 All or Nothing
			
			if(rs.next()){
				parent = rs.getInt(1);
			}
			rs.close();
			stmt.close();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		return parent;
	}
	
	public void insertFile(int parent, String newName, String fname) {
		try{
			logger.info("insertFile start...");
			Connection conn = DBCP.getConnection();
			
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_FILE);
			psmt.setInt(1, parent);
			psmt.setString(2, newName);
			psmt.setString(3, fname);
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	public ArticleBean insertComment(ArticleBean comment) {
		ArticleBean article = null;
		try{
			logger.info("insertComment start...");
			Connection conn = DBCP.getConnection();
			conn.setAutoCommit(false); // 트렌젝션 시작
			
			PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_COMMENT);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.UPDATE_COMMENT_COUNT_PLS);
			Statement stmt = conn.createStatement();
			
			psmt.setInt(1, comment.getParent());
			psmt.setString(2, comment.getContent());
			psmt.setString(3, comment.getUid());
			psmt.setString(4, comment.getRegip());
			
			psmt2.setInt(1, comment.getParent());
			
			psmt.executeUpdate();
			psmt2.executeUpdate();
			ResultSet rs = stmt.executeQuery(Sql.SELECT_COMMENT_LATEST);
			
			conn.commit();			// 트렌젝션 끝 All or Nothing
			
			if(rs.next()) {
				article = new ArticleBean();
				article.setNo(rs.getInt(1));
				article.setParent(rs.getInt(2));
				article.setContent(rs.getString(6));
				article.setRdate(rs.getString(11).substring(2,10));
				article.setNick(rs.getString(12));
			}
			
			rs.close();
			stmt.close();
			psmt.close();
			psmt2.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		return article;
	}
	
	public ArticleBean selectArticle(String no) {
		logger.info("selectArticle start...");
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
			logger.error(e.getMessage());
		}
		return AB;
	}
	
	public List<ArticleBean> selectArticles(int start) {
		logger.info("selectArticles start...");
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
			logger.error(e.getMessage());
		}
		return articles;
	}
	
	public FileBean selectFile(String fno) {
		logger.info("selectFile start...");
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
			logger.error(e.getMessage());
		}
		return fb;
	}
	
	public List<ArticleBean> selectComments(String parent) {
		logger.info("selectComments start...");
		List<ArticleBean> comments = new ArrayList<>();
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_COMMENTS);
			psmt.setString(1, parent);
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleBean comment = new ArticleBean();
				comment.setNo(rs.getInt(1));
				comment.setParent(rs.getInt(2));
				comment.setComment(rs.getInt(3));
				comment.setCate(rs.getString(4));
				comment.setTitle(rs.getString(5));
				comment.setContent(rs.getString(6));
				comment.setFile(rs.getInt(7));
				comment.setHit(rs.getInt(8));
				comment.setUid(rs.getString(9));
				comment.setRegip(rs.getString(10));
				comment.setRdate(rs.getString(11).substring(2,10));
				comment.setNick(rs.getString(12));
				
				comments.add(comment);
			}
			rs.close();
			psmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		return comments;
	}
	
	public int updateArticle(String title, String content, String no) {
		logger.info("updateArticle start...");
		int result = 0;
		try{
			Connection conn = DBCP.getConnection();
			
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, no);
			result = psmt.executeUpdate();
			
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		return result;
	}
	public String deleteFile(String no) {
		logger.info("deleteFile start...");
		String newName = null;
		try {
			Connection conn = DBCP.getConnection();
			
			conn.setAutoCommit(false);
			
			PreparedStatement psmt1 = conn.prepareStatement(Sql.SELECT_FILE_WITH_PARENT);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.DELETE_FILE);
			psmt1.setString(1, no);
			psmt2.setString(1, no);
			
			ResultSet rs = psmt1.executeQuery();
			psmt2.executeUpdate();
			
			conn.commit();
			
			if(rs.next()) {
				newName = rs.getString(3);
			}
			
			psmt1.close();
			psmt2.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		return newName;
	}
	public void deleteArticle(String no) {
		logger.info("deleteArticle start...");
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.DELETE_ARTICLE);
			psmt.setString(1, no);
			psmt.setString(2, no);
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	public int deleteComment(String no, String parent) {
		logger.info("deleteComment start...");
		int result = 0;
		try{
			Connection conn = DBCP.getConnection();
			conn.setAutoCommit(false); // 트렌젝션 시작
			
			PreparedStatement psmt = conn.prepareStatement(Sql.DELETE_COMMENT);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.UPDATE_COMMENT_COUNT_MNS);
			psmt.setString(1, no);
			psmt2.setString(1, parent);
		
			result = psmt.executeUpdate();
			psmt2.executeUpdate();
			
			conn.commit(); // 트렉젝션 끝
			
			psmt.close();
			psmt2.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		return result;
	}
	// 전체 게시물 카운트
	public int selectCountTotal() {
		logger.info("selectCountTotal start...");
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
			logger.error(e.getMessage());
		}
		return total;
	}
	
	// 조회수 업데이트
	public void updateArticleHit(String no) {
		logger.info("updateArticleHit start...");
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE_HIT);
			psmt.setString(1, no);
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	// 다운로드 카운트 업데이트
	public void updateFileDownload(String fno) {
		logger.info("updateFileDownload start...");
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_FILE_DOWNLOAD);
			psmt.setString(1, fno);
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	public int updateComment(String no, String content) {
		logger.info("updateComment start...");
		int result = 0;
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_COMMENT);
			psmt.setString(1, content);
			psmt.setString(2, no);
			result = psmt.executeUpdate();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		return result;
	}
}
