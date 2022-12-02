package kr.co.Farmstory2.controller.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.Farmstory2.service.ArticleService;
import kr.co.Farmstory2.vo.ArticleVO;


@WebServlet("/board/list.do")
public class ListController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	@Override
	public void init() throws ServletException {
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// group cate 연결 작업
		
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		
		// list 작업
		String pg = req.getParameter("pg");
		String search = req.getParameter("search");
		String type = req.getParameter("search_type");
		
		int start = 0;
		int currentPage = 1;
		int currentPageGroup = 1;
		
		if(pg!=null){
			currentPage = Integer.parseInt(pg);
		}
		
		start = (currentPage - 1) * 10;
		
		//전체 게시물 갯수
		int total = service.getTotal(search, cate);
		
		//마지막 페이지 번호
		int lastPageNum = service.getLastPageNum(total);
		
		// 페이지 그룹 start, end 번호
		int[] result = service.getPageGroupNum(currentPageGroup, lastPageNum);
		
		// 페이지 시작 넘버
		int pageStartNum = service.getPageStartNum(total, start);
		
		// 게시물들 가져오기
		List<ArticleVO> articles = null;
		if(search == null) {
			articles = service.selectArticles(cate,start);
		}else {
			articles = service.selectArticlesByKeyword(cate , type, search, start);
		}
		
		req.setAttribute("group", group);
		req.setAttribute("cate", cate);
		req.setAttribute("pg", pg);
		req.setAttribute("search", search);
		req.setAttribute("start", start);
		req.setAttribute("total", total);
		req.setAttribute("lastPageNum", lastPageNum);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("currentPageGroup", currentPageGroup);
		req.setAttribute("pageGroupStart", result[0]);
		req.setAttribute("pageGroupEnd", result[1]);
		req.setAttribute("pageStartNum", pageStartNum);
		req.setAttribute("articles", articles);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/list.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
