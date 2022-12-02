package kr.co.Farmstory2.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.Farmstory2.dao.ArticleDAO;
import kr.co.Farmstory2.vo.ArticleVO;


public enum ArticleService {
	
	INSTANCE;
	
	private ArticleDAO dao = ArticleDAO.getInstance();
	
	
	public int insertArticle(ArticleVO article) {
		return dao.insertArticle(article);
	}
	public void insertFile(int parent, String newName, String fname) {
		dao.insertFile(parent, newName, fname);
	}
	public ArticleVO selectArticle(String no) {
		return dao.selectArticle(no);
	}
	public List<ArticleVO> selectArticles(String cate, int start) {
		return dao.selectArticles(cate, start);
	}
	public List<ArticleVO> selectArticlesByKeyword(String cate, String keyword, int start) {
		return dao.selectArticlesByKeyword(cate, keyword, start);
	}
	
	public void updateArticle() {}
	public void deleteArticle() {}
	
	
	//전체 게시물 갯수
	public int getTotal(String search, String cate) {
		int total = 0;
		if(search == null) {
			total = dao.selectCountTotal(cate);
		}else {
			total = dao.selectCountTotalBySearch(search, cate);
		}
		return total;
	}
	// 시작 페이지 번호
	public int getPageStartNum(int total, int start) {
		int pageStartNum = total - start;
		return pageStartNum;
	}
	// 마지막 페이지 번호
	public int getLastPageNum(int total) {
		int lastPageNum = 0;
		if(total % 10 == 0){
			lastPageNum = total / 10;
		}else{
			lastPageNum = total / 10 + 1;
		}
		return lastPageNum;
	}
	// 페이지 그룹 start, end 번호
	public int[] getPageGroupNum(int currentPage, int lastPageNum) {
		int currentPageGroup = (int)Math.ceil(currentPage / 10.0);
		int pageGroupStart = (currentPageGroup - 1) * 10 + 1;
		int pageGroupEnd = currentPageGroup * 10;
		
		if(pageGroupEnd > lastPageNum){
			pageGroupEnd = lastPageNum;
		}
		
		int[] result = {pageGroupStart, pageGroupEnd};
		
		return result;
	}
	
	// 파일 관련 서비스
	
	public MultipartRequest uploadFile(HttpServletRequest req ,String savePath) throws IOException {
		
		int maxSize = 1024 * 1024 * 10; // 최대 파일 업로드 허용치 10mb
		MultipartRequest mr = new MultipartRequest(req, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		return mr;
	}
	
	public String renameFile(ArticleVO vo, String savePath) {
		
	// 파일명 수정
	int idx = vo.getFname().lastIndexOf(".");
	String ext = vo.getFname().substring(idx);//확장자
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_");
	String now = sdf.format(new Date());
	String newName = now + vo.getUid() + ext; // 202210261113_a108.txt
	
	File oriFile = new File(savePath+"/"+vo.getFname());
	File newFile = new File(savePath+"/"+newName);
	
	oriFile.renameTo(newFile);
	
	return newName;
	}
}
