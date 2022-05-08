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

	//회원 탈퇴.
	$(document).on("click", "#info-delete-btn", function() {
		if(confirm("정말 삭제?")) {
			let delid = $("#modUserId").val();
			$.ajax({
				url:'${root}/user/delete/' + delid,  
				type:'DELETE',
				contentType:'application/json;charset=utf-8',
				dataType:'json',
				success:function() {
					location.href="${root}/";
				},
				error:function(xhr,status,msg){
					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
				}
			}); 
		}
	});
	
	
	$(document).on("click", "#info-check-btn", function() {
		/* let mid = $(this).parents("tr").attr("data-id"); */
		let modifyinfo = JSON.stringify({
					"userId" : $("#modUserId").val(), 
					"phoneNum" : $("#phoneNum").val(), 
					"userName" : $("#userName").val(), 
					"userEmail" : $("#userEmail").val(),
					"userBirth" : $("#userBirth").val()
				   });
		$.ajax({
			url:'${root}/user/modify',  
			type:'PUT',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			data: modifyinfo,
			success:function() {
				location.href="/user/userinfo";
			},
			error:function(xhr,status,msg){
				console.log("상태값 : " + status + " Http에러메시지 : "+msg);
			}
		});
	});

/* $(document).ready(function () {
    $("#info-check-btn").click(function () {
        $("#myPageform").attr("action", "/user/modify").submit();
    });
}); */
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
       <form id="myPageform">
       <div class="row">
         <table class="myPage-check col-6" style="float: none; margin: 0 auto">
         <tbody>
         	<tr>
         		<th>아이디</th>
         		<td><input type="text" value="${userInfo.userId}" disabled></td>
         		<td><input id="modUserId" type="hidden" name="userId" value="${userInfo.userId}" ></td>
         	</tr>
         	<tr>
         		<th>성함</th>
         		<td><input id="userName" type="text" class="modify" name="userName" value="${userInfo.userName}" disabled></td>
         	</tr>
         	<tr>
         		<th>전화번호</th>
         		<td><input id="phoneNum" type="text" class="modify" name="phoneNum" value="${userInfo.phoneNum}" disabled></td>
         	</tr>
         	<tr>
         		<th>생일</th>
         		
         		<td><input id="userBirth" type="date" name="userBirth" value="${userInfo.userBirth}" disabled></td>
         	</tr>
         	<tr>
         		<th>이메일</th>
         		<td><input id="userEmail" type="email" class="modify" name="userEmail" value="${userInfo.userEmail}" disabled></td>
         	</tr>
         	
         </tbody>
           <!-- <h1>아이디</h1> -->
         </table>
         
       </div>
       <div class="col-6" style="float: none; margin: 0 auto">
       	<a style="float:right;" href="/user/modifypwd">비밀번호 변경</a>
       </div>
       <div class="col-lg-12 d-flex justify-content-center btn-box">
         <button type="button" id="info-check-btn" class="d-none">확인</button>
         <button type="button" id="info-modify-btn" >수정</button>
         <button type="button" id="info-delete-btn">탈퇴</button>
       </div>
       </form>
     </section>
   </main>
   
<%@ include file="footer.jsp" %>