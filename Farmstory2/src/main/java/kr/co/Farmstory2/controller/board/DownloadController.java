package kr.co.Farmstory2.controller.board;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.Farmstory2.dao.ArticleDAO;
import kr.co.Farmstory2.vo.FileVO;


@WebServlet("/board/download.do")
public class DownloadController extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String fno = req.getParameter("fno");
		
		// DAO 객체 생성
		ArticleDAO dao = ArticleDAO.getInstance();
		// 파일 가져오기
		FileVO fb = dao.selectFile(fno);
		// 파일 다운로드 카운트 +1
		dao.updateFileDownload(fno);
		
		// 파일 다운로드 헤더정보 수정
		resp.setContentType("application/octet-stream");
		resp.setHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode(fb.getOriName(), "utf-8"));
		resp.setHeader("Content-Transfer-Encoding", "binary");
		resp.setHeader("Pragma", "no-cache");
		resp.setHeader("Cache-Control", "private");

		// 파일 다운로드 스트림 작업
		ServletContext application = req.getServletContext();
		String savePath = application.getRealPath("/file");
		File file = new File(savePath+"/"+fb.getNewName());
		
		BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
		BufferedOutputStream bos = new BufferedOutputStream(resp.getOutputStream());
		
		while(true){
			int data = bis.read();
			
			if(data==-1){
				break;
			}
			
			bos.write(data);
		}
		
		bos.close();
		bis.close();
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
