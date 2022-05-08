<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5604814141adf4eb08f174929c528f6e&libraries=services"></script>
<%@ include file="header.jsp"%>

<script src="assets/js/hangjungdong.js"></script>


<%-- 
 <c:if test="${empty userInfo}">
   <script>
   alert("로그인 상태에서 볼 수 있는 페이지입니다.");
   location.href = "${root}/index.jsp";
   </script>
</c:if>  --%>
 
</head>
<!-- End Header -->
<main id="main">
	<!-- ======= Breadcrumbs Section ======= -->
	<section class="breadcrumbs">
		<div class="container">
			<div class="d-flex justify-content-between align-items-center">
				<h2>실거래가 조회</h2>
				<ol>
					<li><a href="index.jsp">Home</a></li>
					<li>실거래가 조회</li>
				</ol>
			</div>
		</div>
	</section>
	<!-- Breadcrumbs Section -->

	<!-- ======= Portfolio Details Section ======= -->

	
		<section id="index_section">
		<div class="row">
			<div class="card col-sm-6 mt-1" style="min-height: 850px;">
				<div class="card-body">
				<div class="row">
					<div class="row form-group form-inline justify-content-center">
						<div class="col">
						<label class="mr-2" for="sido">시도 : </label>
						<select class="col form-control" id="sido">
							<option value="0">선택</option>
						</select>
						</div>
						<div class="col">
						<label class="mr-2 ml-3" for="gugun">구군 : </label>
						<select class="form-control" id="gugun">
							<option value="0">선택</option>
						</select>
						</div>
						<div class="col">
						<label class="mr-2 ml-3" for="dong">읍면동 : </label>
						<select class="form-control" id="dong">
							<option value="0">선택</option>
						</select>
						</div>
						</div>
						
						<div class= "row">
						
						<iframe id="iframe1" name="iframe1" style="display:none"></iframe>
					
						<!--<form action="" method="get"> -->
						
						<form id="findAptBtn" name="form" method="get" target="iframe1">
						<div class="col">
						<label class="mr-2 ml-3 mt-3" for="dong"> 아파트 명: </label>
						<input type="text" id="searchAptName" class="form-control" style="border: 1px solid #964B00;" name="aptName" placeholder="apt">
						</div>
						<div class="col">
						<div class="button">
		          		<input type="submit" id="findAptBtn" value="아파트 명으로 검색">
		        		</div>
		        		</div>
						</form>
						
						
						</div>
						<!-- <button type="button" id="aptSearchBtn">검색</button> -->
					</div>
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
						<tbody id="searchResult"></tbody>
					</table>
				
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5604814141adf4eb08f174929c528f6e"></script>
				<script type="text/javascript">
				


				let colorArr = ['table-primary','table-success','table-danger'];
				$(document).ready(function(){			
					$.get(root + "/apart/map/sido"
						,function(data, status){
							$.each(data, function(index, vo) {
								$("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
							});
						}
						, "json"
					);
				});
				$(document).on("change", "#sido", function() {
					$.get(root + "/apart/map/gugun"
							,{sido: $("#sido").val()}
							,function(data, status){
								$("#gugun").empty();
								$("#gugun").append('<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#gugun").append("<option value='"+vo.gugunCode+"'>"+vo.gugunName+"</option>");
								});
							}
							, "json"
					);
				});

				$(document).on("change", "#gugun", function() {
					$.get(root + "/apart/map/dong"
							,{gugun: $("#gugun").val()}
							,function(data, status){
								$("#dong").empty();
								$("#dong").append('<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#dong").append("<option value='"+vo.dongCode+"'>"+vo.dongName+"</option>");
								});
							}
							, "json"
					);
				});
				
				
				/* donglist 생성 - 민지 */
				$(document).on("change", "#gugun", function() {
					$.get(root + "/apart/map/apt/avg"
							,{gugun: $("#gugun").val()}
							,function(data, status){
								console.log(data);
								displayMarkers(data);
							}
							, "json"
					);
				});
				
				$(document).on("change", "#dong", function() {
					$.get(root + "/apart/map/apt"
							,{dong: $("#dong").val()}
							,function(data, status){

								$("tbody").empty();
								$.each(data, function(index, vo) {

									let str = `
										<tr class="${colorArr[index%3]}">
										<td>${"${vo.aptCode}"}</td>

										<td> ${"${vo.aptName}"}</td>
										<td>${"${vo.sidoName} ${vo.gugunName} ${vo.dongName} ${vo.jibun}"}</td>
										<td>${"${vo.buildYear}"}</td>
										<td>${"${vo.recentPrice}"}</td>
									`;
									$("tbody").append(str);
								});
								displayMarkers(data);
							}
							, "json"
					);
				});
				
				$(document).on("click","#findAptBtn",function () {
		        	// 아파트
        			console.log("==============")
        			var apt_val = $("#searchAptName").val();
	                console.log(apt_val);
	                
					$.get(root + "/apart/map/aptName"
							,{aptName: apt_val,
							  dong: $("#dong").val()}
							,function(data, status){
								$("tbody").empty();
								$.each(data, function(index, vo) {
									
									let str = `
										<tr class="${colorArr[index%3]}">
										<td>${"${vo.aptCode}"}</td>
										<td>${"${vo.aptName}"}</td>
										<td>${"${vo.sidoName} ${vo.gugunName} ${vo.dongName} ${vo.jibun}"}</td>
										<td>${"${vo.buildYear}"}</td>
										<td>${"${vo.recentPrice}"}</td>
									`;
									$("tbody").append(str);
								});
								displayMarkers(data);
							}
							, "json"
					);
	        	});


				</script>
			</div>
		</div>
		<div class="col-sm-6" >
			<div style="width:90% height:80%" id="map" ;"></div>
		</div>
		</div>
		<script type="text/javascript" src="js/map2.js"></script>
	</section>
	<!-- End Portfolio Details Section -->
</main>

<!-- End #main -->

<%@ include file="footer.jsp"%>