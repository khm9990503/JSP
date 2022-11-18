package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBHelper;
import vo.BookVO;

public class BookDAO extends DBHelper{
	private static BookDAO instance = new BookDAO();
	public static BookDAO getInstance() {
		return instance;
	}
	private BookDAO () {}
	
	// 기본 CRUD
	public void insertBook(BookVO book) {
		try{
			conn = getConnection();
			// 3단계
			String sql = "INSERT INTO `book` VALUES (?,?,?,?)";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,book.getBookId());
			psmt.setString(2,book.getBookname());
			psmt.setString(3,book.getPublisher());
			psmt.setInt(4,book.getPrice());
			
			// 4단계
			psmt.executeUpdate();
			// 5단계
			// 6단계
			close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public BookVO selectBook(String bookId) {
		BookVO book = null;
		try{
			conn = getConnection();
			stmt = conn.createStatement();
			String sql = "select * from `book` where `bookId`='"+bookId+"'";
			rs = stmt.executeQuery(sql);
			book = new BookVO();
			if(rs.next()){
				book.setBookId(rs.getInt(1));
				book.setBookname(rs.getString(2));
				book.setPublisher(rs.getString(3));
				book.setPrice(rs.getInt(4));
			}
			rs.close();
			stmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return book;
	}
	public List<BookVO> selectBooks() {
		List<BookVO> books = null;
		try{
			conn = getConnection();
			stmt = conn.createStatement();
			String sql = "SELECT * FROM `book`";
			rs = stmt.executeQuery(sql);
			books = new ArrayList<>();
			while(rs.next()){
				BookVO book = new BookVO();
				book.setBookId(rs.getInt(1));
				book.setBookname(rs.getString(2));
				book.setPublisher(rs.getString(3));
				book.setPrice(rs.getInt(4));
				
				books.add(book);
			}
			close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return books;
	}
	public void modifyBook(BookVO book) {
		try{
			
			conn = getConnection();
			
			String sql = "UPDATE `book` SET `bookname`=?, `publisher`=?, `price`=? ";
		   		   sql+= "WHERE `bookId`=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,book.getBookname());
			psmt.setString(2,book.getPublisher());
			psmt.setInt(3,book.getPrice());
			psmt.setInt(4,book.getBookId());
			
			
			psmt.executeUpdate();
			
			
			close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public void deleteBook(String bookId) {
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			stmt.executeUpdate("delete from `book` where `bookId`='"+bookId+"'");
			
			close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
