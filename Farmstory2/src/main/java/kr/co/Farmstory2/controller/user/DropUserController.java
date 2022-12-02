package kr.co.Farmstory2.controller.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;

import kr.co.Farmstory2.dao.UserDAO;


@WebServlet("/user/dropUser.do")
public class DropUserController extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uid = req.getParameter("uid");
		
		int result = UserDAO.getInstance().dropUser(uid);
		// 회원탈퇴 시 로그아웃
		// session 제거
		req.getSession().removeAttribute("sessUser");
		req.getSession().invalidate();
		
		// 로그아웃을 위한 쿠키 제거
		Cookie cookie = new Cookie("SESSID", null);
		cookie.setPath("/");
		cookie.setMaxAge(0);
		resp.addCookie(cookie);
		
		// 데이터베이스 세션 로그아웃
		UserDAO.getInstance().updateUserSessionOut(uid);
		
		// 출력
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		PrintWriter out = resp.getWriter();
		out.print(json.toString());
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
