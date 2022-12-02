package kr.co.Farmstory2.controller.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import kr.co.Farmstory2.dao.UserDAO;
import kr.co.Farmstory2.vo.UserVO;


@WebServlet("/user/myInfo.do")
public class MyInfoController extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user/myInfo.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수신
		String uid = req.getParameter("uid");
		String pass = req.getParameter("pass");
		String name = req.getParameter("name");
		String nick = req.getParameter("nick");
		String email = req.getParameter("email");
		String hp = req.getParameter("hp");
		String zip = req.getParameter("zip");
		String addr1 = req.getParameter("addr1");
		String addr2 = req.getParameter("addr2");
		UserVO vo = new UserVO();
		UserDAO dao = UserDAO.getInstance();
		
		if(pass == null) {
			// 회원수정 누를 때
			vo.setUid(uid);
			vo.setName(name);
			vo.setNick(nick);
			vo.setEmail(email);
			vo.setHp(hp);
			vo.setZip(zip);
			vo.setAddr1(addr1);
			vo.setAddr2(addr2);
			dao.updateUser(vo);
			
			resp.sendRedirect("/Farmstory2/user/logout.do?success=401&uid="+uid);
		}else{
			// 비번수정 누를 때
			int result = dao.updateUserPw(pass, uid);
			
			JsonObject json = new JsonObject();
			json.addProperty("result", result);
			PrintWriter out = resp.getWriter();
			out.print(json.toString());
		}
		
		
	}
}
