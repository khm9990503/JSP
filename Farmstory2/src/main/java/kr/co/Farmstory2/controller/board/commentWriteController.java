package kr.co.Farmstory2.controller.board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import kr.co.Farmstory2.dao.ArticleDAO;
import kr.co.Farmstory2.vo.ArticleVO;


@WebServlet("/board/commentWrite.do")
public class commentWriteController extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String pg		 = req.getParameter("pg");
		String parent	 = req.getParameter("parent");
		String uid		 = req.getParameter("uid");
		String content	 = req.getParameter("content");
		String regip	 = req.getRemoteAddr();
		
		ArticleVO comment = new ArticleVO();
		comment.setParent(parent); // int parent가 아닌 String parent
		comment.setUid(uid);
		comment.setContent(content);
		comment.setRegip(regip);
		
		ArticleVO article = ArticleDAO.getInstance().insertComment(comment);
		//response.sendRedirect("../view.jsp?no="+parent+"&pg="+pg);
		
		//json 출력
		JsonObject json = new JsonObject();
		json.addProperty("result", 1);
		json.addProperty("pg", pg);
		json.addProperty("no", article.getNo());
		json.addProperty("parent", article.getParent());
		json.addProperty("nick", article.getNick());
		json.addProperty("date", article.getRdate());
		json.addProperty("content", article.getContent());
		String jsonData = json.toString();
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		PrintWriter writer = resp.getWriter();
		writer.print(jsonData);
	}
}
