<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<c:if test="${empty userInfo}">
	<script>
	alert("로그인 상태에서 볼 수 있는 페이지입니다.");
	location.href = "${root}/index.jsp";
	</script>
</c:if>

<main id="main">
      <!-- ======= Breadcrumbs Section ======= -->
      <section class="breadcrumbs">
        <div class="container">
          <div class="d-flex justify-content-between align-items-center">
            <h2>관심지역 등록</h2>
            <ol>
              <li><a href="index.jsp">Home</a></li>
              <li>관심지역 등록</li>
            </ol>
          </div>
        </div>
      </section>
      <!-- Breadcrumbs Section -->

      <!-- ======= Portfolio Details Section ======= -->
      <div class="container">
        <!-- ======= Breadcrumbs Section ======= -->
        <section class="signup-container">
          <div class="login-page">
            <!-- <h1>Welcome</h1> -->
            <div class="register-form">
              <form name="register-form">
                <div>
                  <select id="sido" class="search-element">
                    <option value="">시도선택</option>
                  </select>
                  <select id="sigugun" class="search-element" name="gu">
                    <option value="">구군선택</option>
                  </select>
                  <select id="dong" name="dong">
                    <option value="">동선택</option>
                  </select>
                </div>

                <button id="registerInterestBtn" class="btn btn-primary m-3" type="button">
                  관심 지역 등록
                </button>
                <button class="btn btn-outline-primary m-3" onclick="location.href = 'main?act=store&cmd=mvInterest'" type="button">
                  관심 지역 조회
                </button>
              </form>
            </div>
          </div>
        </section>
      </div>
      <!-- End Portfolio Details Section -->
    </main>
	<!-- End #main -->

<%@ include file="footer.jsp" %>
