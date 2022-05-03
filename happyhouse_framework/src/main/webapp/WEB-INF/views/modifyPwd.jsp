<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %> 
<script type="text/javascript">
        $(document).ready(function () {
			
        	// 비밀번호 찾기
        	
        	$("#modifyPwd-btn").click(function () {
	        		let modifyinfo = JSON.stringify({
	        			"userId" : $("#modUserId").val(), 
	        			"userPwd" :$("#newpwd").val()
					   });
	        		
        			$.ajax({
        				url:'${root}/user/modify',  
        				type:'PUT',
        				contentType:'application/json;charset=utf-8',
        				dataType:'json',
        				data: modifyinfo,
        				success:function(response) {
        					$("#modifyMsg").text(response.status);
        					/* location.href="/user/modifypwd"; */
        				},
        				error:function(xhr,status,msg){
        					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
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
       		<div class="row">
         	  <table class="myPage-check col-6" style="float: none; margin: 0 auto">
         	  	<tbody>
	         	  	<!-- <tr>
	         	  		<th> 기존 비밀번호 </th>
	         	  		<td><input id="ckpwd" name="ckpwd" type="password" placeholder="기존 비밀번호" /></td>
	         	  	</tr> -->
	         	  	<tr>
		         		<td><input id="modUserId" type="hidden" name="userId" value="${userInfo.userId}" ></td>
		         	</tr>
	         	  	<tr>
	         	  		<th> 새 비밀번호 </th>
	         	  		<td><input id="newpwd" name="newpwd" type="password" placeholder="새 비밀번호" required="required"/></td>
	         	  	</tr>
	         	  	<tr>
	         	  		<th> </th>
		              	<td><div id="modifyMsg" class="p-3"> </div></td>
		         	</tr>
         	  	</tbody>
              </table>
	            </div>
              <div class="col-2 mt-3" style="float: none; margin: 0 auto">
              	<button id="modifyPwd-btn" class="modifyPwd-btn login-btn" type="button">비밀번호 변경</button>
              </div>
            </form>
          </div>
        </div>
      </section>
    </main>
    
<%@ include file="footer.jsp" %>    