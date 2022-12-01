package kr.co.Farmstory2.dao;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.Farmstory2.db.DBHelper;
import kr.co.Farmstory2.db.Sql;
import kr.co.Farmstory2.vo.ArticleVO;
import kr.co.Farmstory2.vo.FileVO;


public class ArticleDAO extends DBHelper{
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance () {
		return instance;
	}
	private ArticleDAO() {}
	
	// logger
		Logger logger = LoggerFactory.getLogger(this.getClass());
		
	// 기본 CRUD
	
	public int insertArticle(ArticleVO article) {
		int parent = 0;
		try {
			logger.info("insertArticle start...");
			conn = getConnection();
			conn.setAutoCommit(false); // 트렌젝션 시작
			
			stmt = conn.createStatement();
			psmt = conn.prepareStatement(Sql.INSERT_ARTICLE);
			
			psmt.setString(1, article.getCate());
			psmt.setString(2, article.getTitle());
			psmt.setString(3, article.getContent());
			psmt.setInt(4, article.getFname() == null ? 0 : 1);
			psmt.setString(5, article.getUid());
			psmt.setString(6, article.getRegip());
			psmt.executeUpdate();
			rs = stmt.executeQuery(Sql.SELECT_MAX_NO);
			
			conn.commit();			// 트렌젝션 끝 All or Nothing
			
			if(rs.next()) {
				parent = rs.getInt(1);
			}
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return parent;
	}
	public void insertFile(int parent, String newName, String fname) {
		try {
			logger.info("insertFile start...");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.INSERT_FILE);
			psmt.setInt(1, parent);
			psmt.setString(2, newName);
			psmt.setString(3, fname);
			psmt.executeUpdate();
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
	public ArticleVO insertComment(ArticleVO comment) {
		ArticleVO article = null;
		try{
			logger.info("insertComment start...");
			conn = getConnection();
			conn.setAutoCommit(false); // 트렌젝션 시작
			
			psmt = conn.prepareStatement(Sql.INSERT_COMMENT);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.UPDATE_COMMENT_COUNT_PLS);
			Statement stmt = conn.createStatement();
			
			psmt.setInt(1, comment.getParent());
			psmt.setString(2, comment.getContent());
			psmt.setString(3, comment.getUid());
			psmt.setString(4, comment.getRegip());
			
			psmt2.setInt(1, comment.getParent());
			
			psmt.executeUpdate();
			psmt2.executeUpdate();
			rs = stmt.executeQuery(Sql.SELECT_COMMENT_LATEST);
			
			conn.commit();			// 트렌젝션 끝 All or Nothing
			
			if(rs.next()) {
				article = new ArticleVO();
				article.setNo(rs.getInt(1));
				article.setParent(rs.getInt(2));
				article.setContent(rs.getString(6));
				article.setRdate(rs.getString(11).substring(2,10));
				article.setNick(rs.getString(12));
			}
			
			close();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		return article;
	}
	public ArticleVO selectArticle(String no) {
		logger.info("selectArticle start...");
		ArticleVO article= null;
		try{
			conn = getConnection();
			
			psmt = conn.prepareStatement(Sql.SELECT_ARTICLE);
			psmt.setString(1, no);
			rs = psmt.executeQuery();
			
			if(rs.next()){
				article = new ArticleVO();
				article.setNo(rs.getInt(1));
				article.setParent(rs.getInt(2));
				article.setComment(rs.getInt(3));
				article.setCate(rs.getString(4));
				article.setTitle(rs.getString(5));
				article.setContent(rs.getString(6));
				article.setFile(rs.getInt(7));
				article.setHit(rs.getInt(8));
				article.setUid(rs.getString(9));
				article.setRdate(rs.getString(11));
				article.setFno(rs.getInt(12));
				article.setOriName(rs.getString(13));
				article.setDownload(rs.getInt(14));
			}
			close();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		return article;
	}
	public List<ArticleVO> selectArticles(String cate, int start) {
		List<ArticleVO> articles = new ArrayList<>();
		try {
			logger.info("selectArticles start...");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_ARTICLES);
			psmt.setString(1, cate);
			psmt.setInt(2, start);
			rs= psmt.executeQuery();
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setComment(rs.getInt(3));
				vo.setCate(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
				vo.setHit(rs.getInt(8));
				vo.setUid(rs.getString(9));
				vo.setRdate(rs.getString(11));
				vo.setNick(rs.getString(12));
				
				articles.add(vo);
			}
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return articles;
	}
	public List<ArticleVO> selectArticlesByKeyword(String cate, String search, int start) {
		List<ArticleVO> articles = new ArrayList<>();
		try {
			logger.info("selectArticlesByKeyword start...");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_ARTICLES_BY_KEYWORD);
			psmt.setString(1, "%"+search+"%");
			psmt.setString(2, "%"+search+"%");
			psmt.setString(3, cate);
			psmt.setInt(4, start);
			rs= psmt.executeQuery();
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setComment(rs.getInt(3));
				vo.setCate(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
				vo.setHit(rs.getInt(8));
				vo.setUid(rs.getString(9));
				vo.setRdate(rs.getString(11));
				vo.setNick(rs.getString(12));
				
				articles.add(vo);
			}
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return articles;
	}
	// 파일 불러오기
	public FileVO selectFile(String fno) {
		logger.info("selectFile start...");
		FileVO fb = null;
		try{
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_FILE);
			psmt.setString(1, fno);
			rs = psmt.executeQuery();
			if(rs.next()){
				fb = new FileVO();
				fb.setFno(rs.getInt(1));
				fb.setParent(rs.getInt(2));
				fb.setNewName(rs.getString(3));
				fb.setOriName(rs.getString(4));
				fb.setDownload(rs.getInt(5));
				fb.setRdate(rs.getString(6));
			}
			close();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		return fb;
	}
	// 댓글 불러오기
	public List<ArticleVO> selectComments(String parent) {
		logger.info("selectComments start...");
		List<ArticleVO> comments = new ArrayList<>();
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_COMMENTS);
			psmt.setString(1, parent);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO comment = new ArticleVO();
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
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return comments;
	}
	// 전체 게시물 카운트
	public int selectCountTotal(String cate) {
		int total = 0;
		try {
			logger.info("selectCountTotal start...");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_COUNT_TOTAL);
			psmt.setString(1, cate);
			rs = psmt.executeQuery();
			if(rs.next()) {
				total = rs.getInt(1);
			}
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return total;
	}
	public int selectCountTotalBySearch(String search, String cate) {
		int total = 0;
		try {
			logger.info("selectCountTotal start...");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_COUNT_TOTAL_BY_KEYWORD);
			psmt.setString(1, "%"+search+"%");
			psmt.setString(2, "%"+search+"%");
			psmt.setString(3, cate);
			rs = psmt.executeQuery();
			if(rs.next()) {
				total = rs.getInt(1);
			}
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return total;
	}
	public List<ArticleVO> selectLatestS() {
		List<ArticleVO> latests = new ArrayList<>();
		try {
			logger.info("selectLatestS start...");
			
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(Sql.SELECT_LATEST_STORY);
			
			while(rs.next()) {
				ArticleVO ab = new ArticleVO();
				ab.setNo(rs.getInt(1));
				ab.setTitle(rs.getString(2));
				ab.setRdate(rs.getString(3).substring(2,10));
				latests.add(ab);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("selectLatestS size : "+latests.size());
		return latests;
	}
	
	public List<ArticleVO> selectLatestN(String cate) {
		List<ArticleVO> latests = new ArrayList<>();
		try {
			logger.info("selectLatestN start...");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_LATEST_NOTICE);
			psmt.setString(1, cate);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO ab = new ArticleVO();
				ab.setNo(rs.getInt(1));
				ab.setTitle(rs.getString(2));
				
				latests.add(ab);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("selectLatestN size : "+latests.size());
		return latests;
	}
	// 조회수 업데이트
	public void updateArticleHit(String no) {
		logger.info("updateArticleHit start...");
		try{
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE_HIT);
			psmt.setString(1, no);
			psmt.executeUpdate();
			
			close();
			
		}catch(Exception e){
			logger.error(e.getMessage());
		}
	}
	public int updateArticle(String title, String content, String no) {
		logger.info("updateArticle start...");
		int result = 0;
		try{
			conn = getConnection();
			
			psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, no);
			result = psmt.executeUpdate();
			
			psmt.close();
			conn.close();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		return result;
	}
	public void deleteArticle(String no) {
		logger.info("deleteArticle start...");
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.DELETE_ARTICLE);
			psmt.setString(1, no);
			psmt.setString(2, no);
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	public String deleteFile(String no) {
		logger.info("deleteFile start...");
		String newName = null;
		try {
			conn = getConnection();
			
			conn.setAutoCommit(false);
			
			PreparedStatement psmt1 = conn.prepareStatement(Sql.SELECT_FILE_WITH_PARENT);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.DELETE_FILE);
			psmt1.setString(1, no);
			psmt2.setString(1, no);
			
			rs = psmt1.executeQuery();
			psmt2.executeUpdate();
			
			conn.commit();
			
			if(rs.next()) {
				newName = rs.getString(3);
			}
			
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return newName;
	}
	// 댓글 삭제
	public int deleteComment(String no, String parent) {
		logger.info("deleteComment start...");
		int result = 0;
		try{
			conn = getConnection();
			conn.setAutoCommit(false); // 트렌젝션 시작
			
			psmt = conn.prepareStatement(Sql.DELETE_COMMENT);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.UPDATE_COMMENT_COUNT_MNS);
			psmt.setString(1, no);
			psmt2.setString(1, parent);
		
			result = psmt.executeUpdate();
			psmt2.executeUpdate();
			
			conn.commit(); // 트렉젝션 끝
			
			close();
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		return result;
	}
	// 다운로드 카운트 업데이트
	public void updateFileDownload(String fno) {
		logger.info("updateFileDownload start...");
		try{
			conn =getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_FILE_DOWNLOAD);
			psmt.setString(1, fno);
			psmt.executeUpdate();
			
			close();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
	}
	// 댓글 수정
	public int updateComment(String no, String content) {
		logger.info("updateComment start...");
		int result = 0;
		try{
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_COMMENT);
			psmt.setString(1, content);
			psmt.setString(2, no);
			result = psmt.executeUpdate();
			psmt.close();
			conn.close();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		return result;
	}
}
