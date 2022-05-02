<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="header.jsp" %>  
<c:if test="${empty userInfo}">
	<script>
	alert("로그인 상태에서 볼 수 있는 페이지입니다.");
	location.href = "${root}/index.jsp";
	</script>
</c:if>
    <!-- End Header -->
    <main id="main">
      <!-- ======= Breadcrumbs Section ======= -->
      <section class="breadcrumbs">
        <div class="container">
          <div class="d-flex justify-content-between align-items-center">
            <h2>공지사항</h2>
            <ol>
              <li><a href="index.jsp">Home</a></li>
              <li>공지사항</li>
            </ol>
          </div>
        </div>
      </section>
      <!-- End Breadcrumbs Section -->

      <section class="notice-container">
        <div class="row">
                  
         <c:if test="${!empty nview}">	
				
          <form name="notice-form" class="notice-form" >
            <div id="notice-idx" style="display: none">${nview.noticeID}</div>
            <div class="md-4">
              <label for="addNotice-title" class="form-label fw-bold">제목</label>
              <input id="addNotice-title" class="form-control" name="title" value ="${nview.noticeTitle}" type="text" disabled/>
            </div>
            <div class="mt-4">
              <label for="addNotice-content" class="form-label fw-bold">내용</label>
              <textarea
                class="form-control"
                id="addNotice-content"
                name="content"
                rows="5"
            	disabled
              >   ${nview.noticeContent}</textarea>
            </div>
            <div class="notice-check-btn-box text-center mt-5">
              <button class="modify-nocice-btn before-modify btn btn-primary m-2" type="button">수정</button>
              <button class="delete-nocice-btn before-modify btn btn-danger m-2" type="button">삭제</button>

              <button class="modify-check-nocice-btn d-none after-modify btn btn-outline-primary" type="button">수정 완료</button>
            </div>
            <div class="nav justify-content-end">
              <a
                class="check-nocice-btn" 
                 onclick="location.href='NoticeMain2?act=selectAll'"
                type="button"
              >
                	공지사항 목록 보기
              </a>
            </div>
          </form>
          
          
          </c:if> 		
        </div>
      </section>
    </main>

<%@ include file="footer.jsp" %>
