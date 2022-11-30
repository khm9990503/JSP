package kr.co.jboard2.controller.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import kr.co.jboard2.dao.UserDAO;
import kr.co.jboard2.vo.UserVO;

@WebServlet("/user/info.do")
public class InfoController extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/user/info.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수신
		String pass = req.getParameter("pass");
		String uid = req.getParameter("uid");
		
		UserVO vo = UserDAO.getInstance().selectUser(uid, pass);
		int result = 0;
		// 출력
		JsonObject jsonData = new JsonObject();
		if(vo!=null) {
			result = 1;
		}
		jsonData.addProperty("result", result);
		PrintWriter out = resp.getWriter();
		out.print(jsonData.toString());
	}
}
