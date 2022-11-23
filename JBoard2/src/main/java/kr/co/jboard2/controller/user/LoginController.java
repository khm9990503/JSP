package kr.co.jboard2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jboard2.dao.UserDAO;
import kr.co.jboard2.utils.CookieManager;
import kr.co.jboard2.vo.UserVO;

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
		HttpSession sess = req.getSession();
		sess.removeAttribute("vo");
		
		String success = req.getParameter("success");
		
		req.setAttribute("success", success);
		
		String loginId = CookieManager.readCookie(req, "loginId");

		String cookieCheck = "";
		if(!loginId.equals("")){
			cookieCheck = "checked";
		}
		req.setAttribute("loginId", loginId);
		req.setAttribute("cookieCheck", cookieCheck);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/user/login.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인
		String uid = req.getParameter("uid");
		String pass = req.getParameter("pass");
		
		UserVO vo = UserDAO.getInstance().selectUser(uid,pass);
		
		// 아이디 기억
		String saveUid = req.getParameter("saveUid");
		if(saveUid!=null && saveUid.equals("Y")) {
			CookieManager.makeCookie(resp, "loginId", uid, 86400);
		}else {
			CookieManager.deleteCookie(resp, "loginId");
		}
		
		if(vo!=null) {
			HttpSession session = req.getSession(); // 현재 클라이언트 세션을 구함
			session.setAttribute("sessUser", vo);
			resp.sendRedirect("/JBoard2/list.do");
		}else {
			resp.sendRedirect("/JBoard2/user/login.do?success=100");
		}
		
		
	}
}
