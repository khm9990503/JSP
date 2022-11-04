<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
<script type="text/javascript" src="/JBoard1/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	var oEditors = [];
	$(function(){
		   nhn.husky.EZCreator.createInIFrame({
		      oAppRef: oEditors,
		      elPlaceHolder: "ir1",
		      //SmartEditor2Skin.html 파일이 존재하는 경로
		      sSkinURI: "/JBoard1/se2/SmartEditor2Skin.html",  
		      htParams : {
		          // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		          bUseToolbar : true,             
		          // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		          bUseVerticalResizer : true,     
		          // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		          bUseModeChanger : true,         
		          fOnBeforeUnload : function(){
		               
		          }
		      }, 
		      fOnAppLoad : function(){
		          //textarea 내용을 에디터상에 바로 뿌려주고자 할때 사용
		          oEditors.getById["ir1"].exec("PASTE_HTML", ["내용을 입력하세요."]);
		      },
		      fCreator: "createSEditor2"
		      });
		   
			//전송버튼 클릭이벤트
		    $(".btnComplete").click(function(){
		        //id가 smarteditor인 textarea에 에디터에서 대입
		         oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
		         
		        // 이부분에 에디터 validation 검증
		         
		        //폼 submit
		        $("#frm").submit();
		    });
	});
</script>
      <main id="board" class="write">
          <h3>글쓰기</h3>
          <section>
              <form action="/JBoard1/proc/writeProc.jsp" method="post" enctype="multipart/form-data" id="frm">
              	<input type="hidden" name="uid" value="<%=sessUser.getUid()%>"/>
                  <table>
                      <tr>
                          <th>제목</th>
                          <td><input type="text" name="title" placeholder="제목을 입력하세요."/></td>
                      </tr>
                      <tr>
                          <th>내용</th>
                          <td>
                              <textarea name="ir1" id="ir1" rows="10" cols="100" style="width:100%;"></textarea>
                          </td>
                      </tr>
                      <tr>
                          <th>파일</th>
                          <td>
                              <input type="file" name="fname"/>
                          </td>
                      </tr>
                  </table>
                  <div>
                      <a href="./list.jsp" class="btn btnCancel">취소</a>
                      <input type="submit" class="btn btnComplete" value="작성완료">
                  </div>
              </form>
          </section>
      </main>
      <%@ include file="./_footer.jsp" %>