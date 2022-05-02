<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %> 
<script type="text/javascript">
        $(document).ready(function () {
			
        	// 비밀번호 찾기
        	$("#modifyPwd-btn").click(function () {
        			var newpwd = $("#newpwd").val();
	                $.ajax({
	                	url: '${root}/user',
	                	data: {'act': 'modifypwd', 'newpwd': newpwd},
	                  	type: 'GET',
	                  	dataType: 'text',
	                  	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                  	success: function (response) {
	                  		if (response === "success"){
	                  			alert("비밀번호가 변경되었습니다.");
	                  			location.href = "index.jsp";
	                  		} else {
	                  			alert("오류가 발생했습니다.");
	                  		}
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
            <h2>비밀번호 변경</h2>
            <ol>
              <li><a href="index.html">Home</a></li>
              <li>비밀번호 변경</li>
            </ol>
          </div>
        </div>
      </section>
      <!-- End Breadcrumbs Section -->

      <section class="signup-container">
        <div class="login-page">
          <!-- <h1>Welcome</h1> -->
          <div class="signup-form">
          <form id="myPageform" method="post">
       		<input type="hidden" id="myPage-action" name="act" value="modify">
       		<div class="row">
         	  <table class="myPage-check col-6" style="float: none; margin: 0 auto">
         	  	<tbody>
	         	  	<!-- <tr>
	         	  		<th> 기존 비밀번호 </th>
	         	  		<td><input id="ckpwd" name="ckpwd" type="password" placeholder="기존 비밀번호" /></td>
	         	  	</tr> -->
	         	  	<tr>
	         	  		<th> 새 비밀번호 </th>
	         	  		<td><input id="newpwd" name="newpwd" type="password" placeholder="새 비밀번호" required="required"/></td>
	         	  	</tr>
         	  	</tbody>
              </table>
	            </div>
              <div class="col-2 mt-3" style="float: none; margin: 0 auto">
              	<button id="modifyPwd-btn" class="modifyPwd-btn login-btn" type="button">비밀번호 변경</button>
              </div>
              
	            <input type="text" style="display:none;"/>
            </form>
          </div>
        </div>
      </section>
    </main>
    
<%@ include file="footer.jsp" %>    