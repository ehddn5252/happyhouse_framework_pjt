<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<c:if test="${empty userInfo}">
	<script>
	alert("로그인 상태에서 볼 수 있는 페이지입니다.");
	location.href = "${root}/index.jsp";
	</script>
</c:if>

<script type="text/javascript">

$(document).on("click", "#registerInterestBtn1", function() {
	console.log("==============");
	console.log(" click registerInterestBtn ");
	var areaName = $("#sido option:checked").text()+" "+$("#sigugun option:checked").text()+" " +$("#dong option:checked").text();

	console.log(areaName);
	// ${userInfo.userId}
    $.ajax({
    	url: "/interest/insert",
    
    	data: JSON.stringify({'userId': '<c:out value='${userInfo.userId}'/>', 'sidoCode': $("#sido").val(), 'sigugunCode':$("#sigugun").val(),'dongCode':$("#dong").val(), 'areaName':areaName}),
      	contentType:'application/json;charset=utf-8',
    	type: 'post',
      	/* beforeSend : function(xhr)
        {  
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        } 
      	,*/
      	success: function (response){
			console.log("success ajax in registerInterestBtn1");
      	},
        error:function (e) {
        	/* location.href="/error/error.jsp"; */
        	console.log("error code");
        	console.log(e);

        }
	});
});


</script>

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

                <button id="registerInterestBtn1" class="btn btn-primary m-3" type="button">
                  관심 지역 등록
                </button>
                <button class="btn btn-outline-primary m-3" onclick="location.href = '/store'" type="button">
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
