package kr.co.Farmstory2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.Farmstory2.dao.UserDAO;
import kr.co.Farmstory2.vo.UserVO;


@WebServlet("/user/login.do")
public class LoginController extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String success = req.getParameter("success");
		
		req.setAttribute("success", success);
		
		// 로그인 여부에 따라 페이지 이동
		HttpSession sess = req.getSession();
		UserVO sessUser = (UserVO) sess.getAttribute("sessUser");
		
		if(sessUser!=null) {
			resp.sendRedirect("/Farmstory2/board/list.do");
		}else {
			RequestDispatcher dispatcher = req.getRequestDispatcher("/user/login.jsp");
			dispatcher.forward(req, resp);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인
		String uid = req.getParameter("uid");
		String pass = req.getParameter("pass");
		
		UserDAO dao = UserDAO.getInstance();
		UserVO vo = dao.selectUser(uid,pass);
		
		// 아이디 기억
		String auto = req.getParameter("auto");
		
		
		if(vo!=null) {
			//회원 맞음
			HttpSession session = req.getSession(); // 현재 클라이언트 세션을 구함
			session.setAttribute("sessUser", vo);
			
			// 자동 로그인
			if(auto!=null) {
				String sessId = session.getId();

				//쿠키생성
				Cookie cookie = new Cookie("SESSID",sessId);
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24*3);
				resp.addCookie(cookie);
				
				//세션정보 데이터베이스 저장
				dao.updateUserForSession(uid,sessId);
			}
			
			resp.sendRedirect("/Farmstory2/index.do");
		}else {
			//회원 아님
			resp.sendRedirect("/Farmstory2/user/login.do?success=100");
		}
		
		
	}
}
