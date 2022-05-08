<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, com.ssafy.happyhouse.model.*"%>
<%@ include file="header.jsp" %>
<%-- <c:if test="${empty userInfo}">
   <script>
   alert("로그인 상태에서 볼 수 있는 페이지입니다.");
   location.href = "${root}/index.jsp";
   </script>
</c:if> --%>
<%
	String code = (String)request.getParameter("code");
%>
	<main id="main"> <!-- ======= Breadcrumbs Section ======= -->
	<section class="breadcrumbs">
		<div class="container">
			<div class="d-flex justify-content-between align-items-center">
				<h2>선호 지역 주변 실거래가 조회</h2>
				<ol>
					<li><a href="index.jsp">Home</a></li>
					<li>선호 지역 주변 실거래가 조회</li>
				</ol>
			</div>
		</div>
	</section>
	
	
	<!-- Breadcrumbs Section --> <!-- ======= Portfolio Details Section ======= -->


	<div class="container">
		<div class="login-page">
			<div class="form">
				<form name="register-form" class="search-form" action="main"
					method="get">
					<!--
					<input type="hidden" name="act" value="store" />
					<input type="hidden" name="cmd" value="searchByCodes" />
					 <input id="pageNo" name="pageNo" type="text" placeholder="pageNo" />
              <input id="numOfRows" name="numOfRows" type="text" placeholder="numOfRows" />
              <input id="LAWD_CD" name="LAWD_CD" type="text" placeholder="LAWD_CD" />
              <input id="DEAL_YMD" name="DEAL_YMD" type="DEAL_YMD" placeholder="DEAL_YMD" />
               -->

					<div>
						<h3>자주가는 지역을 선택해주세요</h3>
						<p style="margin-bottom: 0;">자주가는 지역을 고려한 최적의 매물을 추천해드립니다.</p>
					</div>
				</form>
			</div>
		</div>
		
		<div class="row">
			<div id="map" class="col-sm-8 my-5" style="width:600px;"></div>
			<div class="col-sm-4" style="margin-left:auto;">
				<p class="apart_list_title my-5">
					선호 지역
					<span id="clearAllBtn" style="float:right">전체삭제</span>
				</p>
				<div id="resultList">
					선호 지역을 지도에서 선택해주세요.
				</div>
			</div>
			
		</div>
		
		<div style='text-align:center; border-radius: 5px;'class="container p-3 bg-primary text-white" >
			<span>반경</span>
			<input type="number" id="getDistance" style="width: 50px;text-align: center;padding-left: 15px;">
			<span>km 이내 아파트 </span>
			<input type="button" id="getBest" class="btn btn-light ml-3" value="추천 받기">
		</div>
		<div id="resultDiv" style="display:none">
			<div id="resultMap" style="width:600px; height:500px;" class="col-sm-8 my-5 mx-auto"></div>
			
			<div style="margin-left:auto;">
				<p class="apart_list_title my-2">
					 추천 아파트
				</p>
				<table class="table mt-2">
						<colgroup>
							<col width="100">
							<col width="150">
							<col width="*">
							<col width="*">
							<col width="120">
							<col width="120">
						</colgroup>	
						<thead>
							<tr>
								<th>번호</th>
								<th>아파트이름</th>
								<th class="text-center">주소</th>
								<th>건축연도</th>
								<th>최근거래금액</th>
							</tr>
						</thead>
						<tbody id="searchResult">
						
						</tbody>
					</table>
			</div>
		</div>
		<div class="m-5"></div>
	</div>
	<!-- End Portfolio Details Section --> </main>




	<!-- End #main -->
	
	<script src="${root}/assets/js/serviceBest.js"></script>
	
<%@ include file="footer.jsp" %>
	
