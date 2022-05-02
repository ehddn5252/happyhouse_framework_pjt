<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>    
<c:if test="${!empty userInfo}">
	<script>
	alert("로그아웃 상태에서 볼 수 있는 페이지입니다.");
	location.href = "${root}/index.jsp";
	</script>
</c:if>
<script type="text/javascript">
        $(document).ready(function () {
			
        	// 비밀번호 찾기
        	$("#findPwd-btn").click(function () {
        			var userid = $("#findPwd-id").val();
	                $.ajax({
	                	url: '${root}/user',
	                	data: {'act': 'findpwd', 'userid': userid},
	                  	type: 'GET',
	                  	dataType: 'text',
	                  	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                  	success: function (response) {
	                  		console.log(response);
	                    	$("#msg").text(response).removeClass('text-dark');
	                  	},
	                  	error: function (error) {
	                  		request.setAttribute("msg", "글목록 얻기중 에러가 발생했습니다.");
	        				request.getRequestDispatcher("/error/error.jsp").forward(request, response);
	                  	}
					});
        		});
        	});
    </script>    
    
    <main id="main">
      <!-- ======= Breadcrumbs Section ======= -->
      <section class="breadcrumbs">
        <div class="container">
          <div class="d-flex justify-content-between align-items-center">
            <h2>비밀번호 찾기</h2>
            <ol>
              <li><a href="index.jsp">Home</a></li>
              <li>비밀번호 찾기</li>
            </ol>
          </div>
        </div>
      </section>
      <!-- End Breadcrumbs Section -->

      <section class="signup-container">
        <div class="login-page">
          <!-- <h1>Welcome</h1> -->
          <div class="signup-form">
            <form name="register-form" class="register-form">
              <input id="findPwd-id" name="id" type="text" placeholder="id" />

              <button id="findPwd-btn" class="findPwd-btn" type="button">비밀번호 찾기</button>
	            <div id="msg" class="mt-2">
	              <!-- 패스워드 출력될 곳 -->
	            </div>
	            <input type="text" style="display:none;"/>
            </form>
          </div>
        </div>
      </section>
    </main>
    
<%@ include file="footer.jsp" %>    