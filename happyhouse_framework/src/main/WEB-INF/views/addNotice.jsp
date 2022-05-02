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

      <section class="addNotice-container .notice-container">
        <div class="col-9" style="float: none; margin: 0 auto">
          <form name="addNotice-form" class="addNotice-form">
            <div id="notice-idx" style="display: none"></div>
            <div class="md-4">
              <label for="addNotice-title" class="form-label fw-bold">제목</label>
              <input
                id="addNotice-title"
                class="form-control"
                name="title"
                type="text"
                placeholder="제목"
              />
            </div>
            <div class="mt-4">
              <label for="addNotice-content" class="form-label fw-bold">내용</label>
              <textarea
                class="form-control"
                id="addNotice-content"
                name="content"
                rows="10"
              ></textarea>
            </div>
            <div class="notice-check-btn-box mt-3" style="float: right; margin: 0 auto">
              <button class="btn btn-primary" onclick="addNotice()" type="button">공지 등록</button>
            </div>
          </form>
        </div>
      </section>
    </main>
<%@ include file="footer.jsp" %>

