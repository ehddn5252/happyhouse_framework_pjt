<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>
<%-- <c:if test="${!empty userInfo}">
	<script>
	alert("로그아웃 상태에서 볼 수 있는 페이지입니다.");
	location.href = "${root}/index.jsp";
	</script>
</c:if> --%>
<script type="text/javascript">
        $(document).ready(function () {
        	//
			$("#registerBtn").attr("disabled","disabled");
                    		
        	var isId = false;
        	// 아이디 중복검사
        	$("#registId").keyup(function () {
        		var ckid = $("#registId").val();
        		if(ckid.length < 6 || ckid.length > 16) {
        			$("#idresult").text("아이디는 6자이상 16자이하입니다.").removeClass('text-primary').removeClass('text-danger').addClass('text-dark');
        			isId = false;
        			$("#registerBtn").attr("disabled","disabled");
        		} else {
	                $.ajax({
	                	url: '${root}/user',
	                	data: {'act': 'idcheck', 'ckid': ckid},
	                  	type: 'GET',
	                  	dataType: 'text',
	                  	success: function (response) {
	                    	var cnt = parseInt(response);
	                    	if(cnt == 0) {
	                    		$("#idresult").text(ckid + "는 사용가능합니다.").removeClass('text-dark').removeClass('text-danger').addClass('text-primary');
	                    		isId = true;
	                    		$("#registerBtn").removeAttr("disabled");
	                    	} else {
	                    		$("#idresult").text(ckid + "는 사용할 수 없습니다.").removeClass('text-dark').removeClass('text-primary').addClass('text-danger');
	                    		isId = false;
	                    		$("#registerBtn").attr("disabled","disabled");
	                    	}
	                  	}
					});
        		}
			});
        	
        	// 이름 아이디 비밀번호 입력 안하면 
            $("#registerBtn").click(function () {
                if (!$("#username").val()) {
                    alert("이름 입력!!!");
                    return;
                } else if (!isId) {
                    alert("아이디 확인!!!");
                    return;
                } else if (!$("#userpwd").val()) {
                    alert("비밀번호 입력!!!");
                    return;
                } else if ($("#userpwd").val() != $("#pwdcheck").val()) {
                    alert("비밀번호 확인!!!");
                    return;
                } else {
                	$("#email").val($("#emailid").val() + "@" + $("#emaildomain").val());
                    $("#memberform").attr("action", "${root}/user/register").submit();
                }
            });
        	// 회원가입
            $("#registerBtn").click(function () {
                $("#memberform").attr("action", "${root}/user").submit();
            });
        });
    </script>

<main id="main">
      <!-- ======= Breadcrumbs Section ======= -->
      <section class="breadcrumbs">
        <div class="container">
          <div class="d-flex justify-content-between align-items-center">
            <h2>회원가입</h2>
            <ol>
              <li><a href="index.jsp">Home</a></li>
              <li>회원가입</li>
            </ol>
          </div>
        </div>
      </section>
      <!-- End Breadcrumbs Section -->

      <section class="signup-container">
    
      
        <div class="registercontainer">
		    <div class="title">회원가입</div>
		    <div class="content">
		      <form action="user" method="post">
		      	<input type="hidden" name="act" value="register">
		        <div class="user-details">
		          <div class="input-box">
		            <span class="details">성함</span>
		            <input type="text" name="name" placeholder="Enter your name" required>
		          </div>
		          <div class="input-box">
		            <span class="details">전화번호</span>
		            <input type="text" name="phonenum" placeholder="Enter your phone number" required>
		          </div>
		          <div class="input-box">
		            <span class="details">이메일</span>
		            <input type="email" name="email" placeholder="Enter your email" required>
		          </div>
		          <div class="input-box">
		            <span class="details">생일</span>
		            <input type="date" name="birth" required>
		          </div>
		          <div class="input-box">
		            <span class="details">아이디</span>
		            <input id="registId" type="text" name="id" placeholder="Enter your id" required autocomplete="off">
		            <div id="idresult" class="mt-1"></div>
		          </div>
		          <div class="input-box">
		            <span class="details">비밀번호</span>
		            <input type="password" name="password" placeholder="Enter your password" required>
		          </div>
		        </div>
		        <div class="gender-details" >
		          <input type="radio" name="gender" id="dot-1" value="남">
		          <input type="radio" name="gender" id="dot-2" value="여">
		          <input type="radio" name="gender" id="dot-3" value="비밀">
		          <span class="gender-title">성별</span>
		          <div class="category">
		            <label for="dot-1">
		            <span class="dot one"></span>
		            <span class="gender">남</span>
		          </label>
		          <label for="dot-2">
		            <span class="dot two"></span>
		            <span class="gender">여</span>
		          </label>
		          <label for="dot-3">
		            <span class="dot three"></span>
		            <span class="gender">비밀</span>
		            </label>
		          </div>
		        </div>
		        <div class="button">
		          <input type="submit" id="registerBtn" value="제출">
		        </div>
		      </form>
		    </div>
		  </div>
        
      </section>
      
    </main>
    
<%@ include file="footer.jsp" %>