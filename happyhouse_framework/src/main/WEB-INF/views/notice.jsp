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
          <div class="notice-list-box-toggle">
            <div class="notice-list-box">
              <div class="col-9" style="float: none; margin: 0 auto">
              
              
            <c:if test="${!empty nlist}">
		
                <table class="notice-table table table-hover">
                  <thead>
                    <th>번호</th>
                    <th>제목</th>
                    <th>내용</th>
					<th>작성자</th>             
                    <th>작성일</th>
                  </thead>
                  <tbody>
                  <c:forEach var="nlist" items="${nlist}">
				<tr>
					<td>${nlist.noticeID}</td>
					<td><a  href="${root}/NoticeMain2?act=view&noticeID=${nlist.noticeID}">${nlist.noticeTitle}</a></td>
					<td>${nlist.noticeContent}</td>
					<td>${nlist.userID}</td>
					<td>${nlist.noticeDate}</td>				
				</tr>
				</c:forEach>
                  
                  </tbody>
                  <!-- <h1>아이디</h1> -->
                </table>
               </c:if>
                
              
              </div>
            </div>
            <div class="col-9" style="float: none; margin: 0 auto">
              <button onclick="location.href='NoticeMain2?act=NoticeinsertForm'" style="float: right" class="btn btn-primary">
               	 등록
              </button>
            </div>
          </div>
          
        </div>
      </section>
    </main>

<%@ include file="footer.jsp" %>
