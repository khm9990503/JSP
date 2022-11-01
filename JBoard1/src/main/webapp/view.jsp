<%@page import="java.util.List"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	
	// DAO 객체 생성
	ArticleDAO dao = ArticleDAO.getInstance();
	// 글 조회수 1+
	dao.updateArticleHit(no);
	// 글 가져오기
	ArticleBean AB = dao.selectArticle(no);
	// 댓글 가져오기
	List<ArticleBean> comments = dao.selectComments(no);
	
%>
<%@ include file="./_header.jsp" %>
<script>
	$(document).ready(function() {
		$('.commentForm > form').submit(function() {
			
			let pg = $(this).children('input[name=pg]').val();
			let parent = $(this).children('input[name=parent]').val();
			let content = $(this).children('textarea[name=content]').val();
			let uid = $(this).children('input[name=uid]').val();
			
			let jsonData = ({
				"pg":pg,
				"parent":parent,
				"content":content,
				"uid":uid
			});
			
			console.log(jsonData);
			
			$.ajax({
				url:'/JBoard1/proc/commentWriteProc.jsp',
				method:'post',
				data:jsonData,
				dataType:'json',
				success:function(data){
					
					console.log(data);
					
					let article = "<article class='comment'>";
						article += "<span class='nick'>"+data.nick+"</span>";
						article += "<span class='date'>"+data.date+"</span>";
						article += "<textarea class='content' readonly>"+data.content+"</textarea>";
						article += "<div>";
						article += "<a href='#' class='delete'>삭제</a>";
						article += "<a href='#' class='modify'>수정</a>";
						article += "</div>";
						article += "</article>";
					
					$('.commentList > .empty').hide();
					$('.commentList').append(article);
					$('textare[name=content]').val('');
				}
			});
			
			return false;
		});
	});
</script>
        <main id="board" class="view">
            <h3>글보기</h3>
            <section>
                <form action="#">
                    <table>
                        <tr>
                            <th>제목</th>
                            <td><input type="text" name="title" value="<%=AB.getTitle()%>" readonly></td>
                        </tr>
                        <%if(AB.getFile()>0){ %>
                        <tr>
                            <th>첨부파일</th>
                            <td>
                                <a href="/JBoard1/proc/download.jsp?fno=<%=AB.getFno()%>"><%=AB.getOriName() %></a>
                                 <span><%=AB.getDownload() %></span>회 다운로드
                            </td>
                        </tr>
                        <%} %>
                        
                        
                        <tr>
                            <th>내용</th>
                            <td>
                                <textarea name="content" readonly><%=AB.getContent()%></textarea>
                            </td>
                        </tr>
                    </table>
                    <div>
                        <a href="#" class="btn btnDelete">삭제</a>
                        <a href="/JBoard1/modify.jsp" class="btn btnModify">수정</a>
                        <a href="/JBoard1/list.jsp?pg=<%=pg %>" class="btn btnList">목록</a>
                    </div>
                </form>
            </section>
            <section class="commentList">
                <h3>댓글목록</h3>
                <%for(ArticleBean comment : comments){ %>
                <article class="comment">
                    <span class="nick"><%=comment.getNick() %></span>
                    <span class="date"><%=comment.getRdate() %></span>
                    <textarea name="comment" readonly><%=comment.getContent() %></textarea>
                    <div>
                        <a href="#" class="delete">삭제</a>
                        <a href="#" class="modify">수정</a>
                    </div>
                </article>
                <%} %>
                <%if(comments.size()==0){ %>
                <p class="empty">등록된 댓글이 없습니다.</p>
                <%} %>
            </section>
            <section class="commentForm">
                <h3>댓글쓰기</h3>
                <form action="#" method="post">
                	<input type="hidden" name="pg" value="<%=pg%>">
                	<input type="hidden" name="parent" value="<%=no%>">
                	<input type="hidden" name="uid" value="<%=sessUser.getUid()%>">
                    <textarea name="content" placeholder="댓글내용 입력"></textarea>
                    <div>
                        <a href="#" class="btn btnCancel">취소</a>
                        <input type="submit" class="btn btnComplete" value="작성완료">
                    </div>
                </form>
            </section>
        </main>
        <%@ include file="./_footer.jsp" %>