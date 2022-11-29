package kr.co.Farmstory2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.Farmstory2.dao.UserDAO;


@WebServlet("/user/findPwChange.do")
public class FindPwChangeController extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String success = req.getParameter("success");
		String vo = req.getParameter("vo");
		
		req.setAttribute("success", success);
		req.setAttribute("vo", vo);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user/findPwChange.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pass = req.getParameter("pass2");
		String uid = req.getParameter("uid");
		
		int result = UserDAO.getInstance().updateUserPw(pass, uid);
		
		if(result > 0) {
			resp.sendRedirect("/Farmstory2/user/login.do?success=301");
		}else {
			resp.sendRedirect("/Farmstory2/user/findPwChange.do?success=100");
		}
	}
}
