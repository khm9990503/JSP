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
	request.setCharacterEncoding("UTF-8");
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
		
		// 댓글 삭제하기
		$(document).on('click','.delete',function(e){
			e.preventDefault();
			
			let article = $(this).closest('article');
			let result = confirm('정말 삭제 하시겠습니까?');
			
			if(result){
				let no = $(this).attr('data-no');
				let parent = $(this).attr('data-parent');
				
				let jsonData = {
						"no":no,
						"parent":parent
				};
				
				$.ajax({
					url:'/JBoard1/proc/commentDeleteProc.jsp',
					type:'GET',
					data:jsonData,
					dataType:'json',
					success:function(data){
						
						if(data.result > 0){
							alert('댓글 삭제 완료!');
							article.hide();
							
						}
					}
				});
			}
		});
		
		// 댓글 수정하기
		$(document).on('click','.modify',function(e){
			e.preventDefault();
			
			let txt = $(this).text();
			let p = $(this).parent().prev();
			if(txt=="수정"){
				// 수정모드
				$(this).text('수정완료');
				p.attr('contentEditable',true);
				p.focus();
			}else{
				// 수정완료
				$(this).text('수정');
				p.attr('contentEditable',false);
				
				let no = $(this).attr('data-no');
				let content = p.text();
				
				let jsonData = {
						"content":content,
						"no":no
				};
				
				$.ajax({
					url:'/JBoard1/proc/commentModifyProc.jsp',
					type:'POST',
					data:jsonData,
					dataType:'json',
					success:function(data){
						
						if(data.result > 0){
							alert('댓글 수정 완료!');
						}
						
					}
				});
			}
			
			
		});
		
		// 댓글 쓰기
		
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
						article += "<span class='nick'>"+data.nick+"</span>&nbsp;";
						article += "<span class='date'>"+data.date+"</span>";
						article += "<p class='comment'>"+data.content+"</p>";
						article += "<div>";
						article += "<a href='#' class='delete' data-no='"+data.no+"'>삭제</a>&nbsp;";
						article += "<a href='#' class='modify' data-no='"+data.no+"'>수정</a>";
						article += "</div>";
						article += "</article>";
					
					$('.commentList > .empty').hide();
					$('.commentList').append(article);
					$('textarea[name=content]').val('');
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
                    	<% if(sessUser.getUid().equals(AB.getUid())){ %>
                        <a href="/JBoard1/proc/deleteProc.jsp?no=<%= AB.getNo() %>&pg=<%=pg %>" class="btn btnDelete">삭제</a>
                        <a href="/JBoard1/modify.jsp?no=<%=AB.getNo() %>&pg=<%=pg %>" class="btn btnModify">수정</a>
                        <% } %>
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
                    <p class="comment"><%=comment.getContent() %></p>
                    <div>
                    	<% if(sessUser.getUid().equals(comment.getUid())){ %>
                        <a href="#" class="delete" data-no="<%=comment.getNo() %>" data-parent="<%=comment.getParent() %>">삭제</a>
                        <a href="#" class="modify" data-no="<%=comment.getNo() %>">수정</a>
                        <% } %>
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