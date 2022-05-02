<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<c:if test="${empty userInfo}">
	<script>
	alert("로그인 상태에서 볼 수 있는 페이지입니다.");
	location.href = "${root}/index.jsp";
	</script>
</c:if>

<script>
function deleteInfo(no) {
	console.log(no);
	if(confirm("정말로 탈퇴하실건가요?")) {
		$("#myPage-action").val("delete")
		$("#myPageform").attr("action", "${root}/user").submit();
	}
}

$(document).ready(function () {
    $("#info-check-btn").click(function () {
        $("#myPageform").attr("action", "${root}/user").submit();
    });
});
</script>
    
    <main id="main">
     <!-- ======= Breadcrumbs Section ======= -->
     <section class="breadcrumbs">
       <div class="container">
         <div class="d-flex justify-content-between align-items-center">
           <h2>마이페이지</h2>
           <ol>
             <li><a href="index.jsp">Home</a></li>
             <li>마이페이지</li>
           </ol>
         </div>
       </div>
     </section>
     <!-- End Breadcrumbs Section -->

     <section class="myPage-check-container">
       <form id="myPageform" method="post">
       <input type="hidden" id="myPage-action" name="act" value="modify">
       <div class="row">
         <table class="myPage-check col-6" style="float: none; margin: 0 auto">
         <tbody>
         	<tr>
         		<th>아이디</th>
         		<td><input type="text" value="${userInfo.userId}" disabled></td>
         		<td><input type="hidden" name="userId" value="${userInfo.userId}" ></td>
         	</tr>
         	<tr>
         		<th>성함</th>
         		<td><input type="text" class="modify" name="userName" value="${userInfo.userName}" disabled></td>
         	</tr>
         	<tr>
         		<th>전화번호</th>
         		<td><input type="text" class="modify" name="userPhoneNum" value="${userInfo.userPhoneNum}" disabled></td>
         	</tr>
         	<tr>
         		<th>생일</th>
         		
         		<td><input type="date" name="userBirth" value="${userInfo.userBirth}" disabled></td>
         	</tr>
         	<tr>
         		<th>이메일</th>
         		<td><input type="email" class="modify" name="userEmail" value="${userInfo.userEmail}" disabled></td>
         	</tr>
         	
         </tbody>
           <!-- <h1>아이디</h1> -->
         </table>
         
       </div>
       <div class="col-6" style="float: none; margin: 0 auto">
       	<a style="float:right;" href="user?act=mvModifyPwd">비밀번호 변경</a>
       </div>
       <div class="col-lg-12 d-flex justify-content-center btn-box">
         <button id="info-check-btn" class="d-none">확인</button>
         <button id="info-modify-btn" >수정</button>
         <button id="info-delete-btn" onClick="javascript:deleteInfo('${userInfo.userId}');">탈퇴</button>
       </div>
       </form>
     </section>
   </main>
   
<%@ include file="footer.jsp" %>