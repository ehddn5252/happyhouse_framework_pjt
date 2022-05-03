<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <title>HappyHouse</title>


    <!-- Favicons -->
    <link href="${root}/assets/img/favicon.png" rel="icon" />
    <link href="${root}/assets/img/apple-touch-icon.png" rel="apple-touch-icon" />

    <!-- Google Fonts -->
    <link
      href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
      rel="stylesheet"
    />

    <!-- Vendor CSS Files -->
    <link href="${root}/assets/vendor/aos/aos.css" rel="stylesheet" />
    <link href="${root}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="${root}/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet" />
    <link href="${root}/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet" />
    <link href="${root}/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet" />
    <link href="${root}/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet" />

    <!-- Template Main CSS File -->
    <link href="${root}/assets/css/custom.css" rel="stylesheet" />
    <link href="${root}/assets/css/interest.css" rel="stylesheet" />
    <link href="${root}/assets/css/listMap.css" rel="stylesheet" />
    <link href="${root}/assets/css/myPage.css" rel="stylesheet" />
    <link href="${root}/assets/css/notice.css" rel="stylesheet" />
    <link href="${root}/assets/css/register.css" rel="stylesheet" />
    <link href="${root}/assets/css/registerInterest.css" rel="stylesheet" />
    <link href="${root}/assets/css/style.css" rel="stylesheet" />
    <link href="${root}/assets/css/transaction.css" rel="stylesheet" />

    <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
    <!-- =======================================================
  * Template Name: Squadfree - v4.7.0
  * Template URL: https://bootstrapmade.com/squadfree-free-bootstrap-template-creative/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
  </head>
<c:if test="${cookie.ssafy_id.value ne null}">
	<c:set var="idck" value=" checked"/>
	<c:set var="saveid" value="${cookie.ssafy_id.value}"/>
</c:if>

	<script>
		$(document).ready(function () {
			if ($("#userId").val() != "") {
			      $("#userId").addClass("focus");
			      $("#userId").parent().addClass("focus-box");
			    }
			
		  $(".flip").click(function () {
		    $(".panel").slideToggle("slow");
		  });
		// 포커스일 때 포커스 기능 추가(login, password 글자 위로)
		  $(".login-form input:not(#idsave)").on("focus", function () {
		    $(this).addClass("focus");
		    $(this).parent().addClass("focus-box");
		  });
		  $(".login-form input:not(#idsave)").on("blur", function () {
		    if ($(this).val() == "") {
		      $(this).removeClass("focus");
		      $(this).parent().removeClass("focus-box");
		    }
		  });
		  if ($("#navbar").hasClass("navbar-mobile")) {
		    console.log("활성화");
		    $(".mobile-nav-toggle").css("display", "block");
		  }

		  
		  $(".login-form").submit(function(e){
			  e.preventDefault();
		  })

		  
		  $("#login-btn").on("click", function () {
			  
			  $.ajax({
	          	url: '${root}/user/login',
	          	data: {'act': 'login', 'userId': $("#userId").val(), 'userPwd': $("#userPwd").val(), 'idsave': $("#idsave").is(":checked")},
	            	type: 'Post',
	            	dataType: 'text',
	            	success: function (response) {
	              		if (response==1){location.reload();}
	              		else {
	              			$("#error-msg").text("회원 정보가 일치하지 않습니다.");
	              		} 
	              	},
	          		error: function (error){
	          			console.log(error);
	          		}
	           	});
			  
			  
		  });
		  
		});
	</script>
	
	<c:if test="${empty userInfo}">
			<script>
			$(document).ready(function () {
		    $(".loginOnly").addClass("d-none");
		    $(".logoutOnly").removeClass("d-none");
			});
		    </script>
	</c:if>
	<c:if test="${!empty userInfo}">
		<script>
		$(document).ready(function () {
		    $(".loginOnly").removeClass("d-none");
		    $(".logoutOnly").addClass("d-none");
		    });
	    </script>
	
	</c:if>	    


<body>

<!-- 메뉴바 만들기 -->
<header id="header" class="fixed-top">
      <div class="container d-flex align-items-center">
        <div class="logo me-auto">
          <h1 class="text-light">
            <a href="/"
              ><span
                >Happy<span id="logo-a " style="color: rgb(217, 219, 252); font-size: 26px"
                  >House</span
                ></span
              ></a
            >
          </h1>
          <!-- Uncomment below if you prefer to use an image logo -->
          <!-- <a href="index.jsp"><img src="${root}/assets//img/logo.png" alt="" class="img-fluid"></a>-->
        </div>

        <nav id="navbar" class="navbar order-last order-lg-0">
          <ul>
            <li><a class="nav-link scrollto" href="index.jsp">메인화면</a></li>
            <li><a class="nav-link scrollto" href="index.jsp#services">서비스 소개</a></li>
            <li><a class="nav-link scrollto loginOnly" href="${root}/NoticeMain2?act=selectAll">공지사항</a></li>
            <!-- <li><a class="nav-link scrollto loginOnly" href="findTransaction.jsp">주택실거래가조회</a></li> -->
            <li class="dropdown loginOnly">
              <a href="houseDeal?act=goPage">
                <span>실거래가 조회</span> <i class="bi bi-chevron-down"></i
              ></a>
              <ul>
                <li><a href="houseDeal?act=goPage">동별 주택 실거래가 조회</a></li>
                <li><a href="houseDeal?act=goPageApt">아파트별 주택 실거래가 조회</a></li>
                            </ul>
            </li>
            <!-- 로그인 안 한 상태 inactive -->
            <li class="dropdown loginOnly">
              <a href="main?act=store&cmd=mvInterest"
                ><span>관심지역조회</span> <i class="bi bi-chevron-down"></i
              ></a>
              <ul>
                <li><a href="/interest/list">관심 지역 목록</a></li>
                <li><a href="interest?act=mvAddInterest">관심 지역 등록</a></li>
                <li><a href="/interest/store">주변탐방 업종 정보 조회</a></li>
                <li><a href="/interest/env">주변환경 정보 조회</a></li>
              </ul>
            </li>
          </ul>
          <i class="bi bi-list mobile-nav-toggle"></i>
        </nav>

        <div class="dropdown dropdown-menu-right info-btn-container loginOnly">
          <a class="log-btn dropdown-toggle btn-default btn-sm flip" data-bs-toggle="dropdown">
            회원 정보
          </a>
          <div
            class="dropdown-menu dropdown-menu-end dropdown-animation panel menu-form info-container show"
            style="display: none"
          >
            <a class="mypage-btn" href="/user/userinfo">MyPage</a>
            <button class="btn mypage-btn" onclick="location.href='/user/logout'" type="button">Logout</button>
          </div>
        </div>

        <div class="dropdown dropdown-menu-right log-btn-container logoutOnly">
        
          <a class="log-btn dropdown-toggle btn-default btn-sm flip" data-bs-toggle="dropdown">
            Login
          </a>
          
          
          
          
          <!-- ㄱ -->
          <div
            class="dropdown-menu dropdown-menu-end dropdown-animation panel menu-form show"
            style="display: none"
          >
            <form class="login-form">
              <h2>Login</h2>
              <!-- 아이디 저장 -->
              
              <div class="txtb">
                <input id="userId" name="userId" type="text" autocomplete="off" value="${saveid}"/>
                <span data-placeholder="ID" ></span>
              </div>
              <div class="txtb">
                <input id="userPwd" name="userPwd" type="password" />
                <span data-placeholder="Password"></span>
              </div>
              <div class="form-group form-check text-right">
                  <label class="form-check-label">
                      <input class="form-check-input" type="checkbox" id="idsave" name="idsave" value="saveok"${idck}> 아이디저장
                  </label>
              </div>
             <!--  <button type="submit" class="login-btn" id="login-btn"  >Login</button> -->
              <button class="login-btn" id="login-btn"  >Login</button>
              <div id="error-msg"> </div>
              <div class="bottom-text">
                <p class="mt-2 mb-2">
                  Don’t have account ? <a href="/user/register">Sign up</a> <br />
                </p>
                <p class="mt-2 mb-2">
                  Forget your password ?
                  <a href="/user/findpwd">Find Password</a>
                </p>
              </div>
            </form>
          </div>
        </div>

        <!-- .navbar -->
      </div>
    </header>
    
    
    
    
    
    
    
    
        <!-- ======= Footer ======= -->
 