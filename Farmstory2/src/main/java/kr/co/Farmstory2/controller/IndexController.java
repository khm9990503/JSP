package kr.co.Farmstory2.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import kr.co.Farmstory2.dao.ArticleDAO;
import kr.co.Farmstory2.vo.ArticleVO;

@WebServlet("/index.do")
public class IndexController extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수신
		
		ArticleDAO ad = ArticleDAO.getInstance();
		List<ArticleVO> latests = ad.selectLatestS();
		List<ArticleVO> latestN = ad.selectLatestN("notice");
		List<ArticleVO> latestO = ad.selectLatestN("one");
		List<ArticleVO> latestQ = ad.selectLatestN("question");
		
		// 출력
		req.setAttribute("latests", latests);
		req.setAttribute("latestN", latestN);
		req.setAttribute("latestO", latestO);
		req.setAttribute("latestQ", latestQ);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/index.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
