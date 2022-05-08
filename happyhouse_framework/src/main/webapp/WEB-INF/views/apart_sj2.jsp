<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5604814141adf4eb08f174929c528f6e&libraries=services"></script>
<%@ include file="header.jsp"%>

<script src="/assets/js/hangjungdong.js"></script>


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
				<h2>편의 시설 반경 내 아파트 조회</h2>
				<ol>
					<li><a href="index.jsp">Home</a></li>
					<li>실거래가 조회</li>
					<li>편의 시설 반경 내 아파트 조회</li>
				</ol>
			</div>
		</div>
	</section>
	<!-- Breadcrumbs Section -->

	<!-- ======= Portfolio Details Section ======= -->

	
		<section id="index_section">
		<div class="row">
			<div class="col-sm-7 mt-1" style="min-height: 850px;">
				<div class="card card-body mx-auto" style="width: 97%">
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
						
						<form name="form" method="get" target="iframe1">
						
						<hr>
							<div class="condition-container col-sm-11 flex-column" style="margin:auto">
							<div class="d-flex align-items-center justify-content-between">
								<b style="color:#000080;">조건 추가</b>&emsp;
								<select id="around-cdt">
									<optgroup label="교통">
										<option value="버스정류장">버스정류장</option>
										<option value="지하철역">지하철역</option>
									</optgroup>
									<optgroup label="학교">
										<option value="유치원">유치원</option>
										<option value="초등학교">초등학교</option>
										<option value="중학교">중학교</option>
										<option value="고등학교">고등학교</option>
									</optgroup>
									<optgroup label="편의시설">
										<option value="편의점">편의점</option>
										<option value="스타벅스">스타벅스</option>
										<option value="맥도날드">맥도날드</option>
									</optgroup>
									<optgroup label="응급시설">
										<option value="응급실">응급실</option>
									</optgroup>
								
								</select>
								까지&emsp;
								<select id="transportaion-cdt" style="width:100px">
									<option value="도보">도보</option>
									<option value="차량">차량</option>
								</select>
								(으)로&emsp;
								<input class="distance-input" name='distance' type="text" id="distance-cdt" >
								분 이내
								<div class="addBtn-container">
								<button id="addCdtBtn"><img src="img/toDoBtnIcon/enterBtn.png"></button>
								</div>
							</div>
								<div class="d-none mt-2" id="check-msg" style="width:100%;color:red;">거리를 입력하세요.</div>
								
							
							</div>
							<div class="col-sm-11" style="margin:auto">
								<!-- 추가된 조건들 -->
								<div id="around-conditions">
								
								</div>
							</div>
							
							
							<hr>
						
						<div class="col">
						<div class="button">
		          		<input type="submit" id="findAptBtn" value="검색">
		        		</div>
		        		</div>
		        			<!-- 
			            	<div class="form-check">
							  <input class="form-check-input" name='tmpChkbox[]' type="checkbox" value="지하철역" id="station">
							  <label class="form-check-label" for="station">
							    지하철역:  
							  </label>
							  <span class="distance-input-box">
							  도보
							  <input class="form-distance" name='stationDistance' type="text" id="stationDistance">
								분 이내
								</span>
							</div>
			            	<div class="form-check">
							  <input class="form-check-input" name='tmpChkbox[]' type="checkbox" value="버스정류장" id="busStop">
							  <label class="form-check-label" for="busStop">
							    버스정류장:  
							  </label>
							  <span class="distance-input-box">
							  도보
							  <input class="form-distance" name='busStopDistance' type="text" id="busStopDistance">
								분 이내
								</span>
							</div>
							<div class="form-check">
							  <input class="form-check-input" name='tmpChkbox[]' type="checkbox" value="응급실" id="emergency">
							  <label class="form-check-label" for="emergency">
							    응급실:  
							  </label>
							  <span class="distance-input-box">
							  도보
							  <input class="form-distance" name='emergencyDistance' type="text" id="emergencyDistance">
								분 이내
								</span>
							</div>
							<div class="form-check">
							  <input class="form-check-input" name='tmpChkbox[]' type="checkbox" value="스타벅스" id="starbucks">
							  <label class="form-check-label" for="starbucks">
							    스타벅스:  
							  </label>
							  <span class="distance-input-box">
							  도보
							  <input class="form-distance" name='starbucksDistance' type="text" id="starbucksDistance">
								분 이내
								</span>
							</div>
							<div class="form-check">
							  <input class="form-check-input" name='tmpChkbox[]' type="checkbox" value="맥도날드" id="mck">
							  <label class="form-check-label" for="mck">
							    맥도날드:  
							  </label>
							  <span class="distance-input-box">
							  도보
							  <input class="form-distance" name='mckDistance' type="text" id="mckDistance">
								분 이내
								</span>
							</div>
							<div class="form-check">
							  <input class="form-check-input" name='tmpChkbox[]' type="checkbox" value="학교" id="school">
							  <label class="form-check-label" for="school">
							    학교:  
							  </label>
							  <span class="distance-input-box">
							  도보
							  <input class="form-distance" name='schoolDistance' type="text" id="schoolDistance">
								분 이내
								</span>
							</div> -->
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
								<th style="min-width:80px;">건축연도</th>
								<th>최근거래금액</th>
								<th id="apartAround" style="min-width:200px;">주변</th>
							</tr>
						</thead>
						<tbody id="searchResult"></tbody>
					</table>
				
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5604814141adf4eb08f174929c528f6e"></script>
				<script type="text/javascript">
				var aroundStr;
				

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
					$.get("/apart/map/gugun"
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
					$.get("/apart/map/dong"
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
				
				
				$(document).on("click", "#findAptBtn", function() {
					// 건물과 이에 해당하는 거리 정보 저장한 객체 생성
					var arr = new Array();
					
					console.log("동변경");
					
					
					$(".form-check").each(function() { 
						console.log("냥");
					      var point = $(this).children(".form-check-label").text().trim(); 
					      var transportation = $(this).find(".transportation-input-box").text().trim(); 
					      var distance = $(this).find(".form-distance").val().trim(); 
					      var obj = new Object();
					      
					      obj["point"]=point;
					      obj["transportation"]=transportation;
					      obj["distance"]=distance;
					      arr.push(obj);
					    });
					
					console.log(arr);
					
					// 만약 사용자가 조건을 입력했으면 주변에 대한 정보 표시, 아니면 놉
					if (arr.length==0) {
						$("#apartAround").addClass("d-none");
					} else {
						$("#apartAround").removeClass("d-none");
					}
					
					// 수진 수정
					$.ajax({
				      	url: '/apart/map/apt',
				      	async: false,
				      	data: {'dong':$("#dong").val()},
				        	type: 'Get',
				        	dataType: 'json',
				        	success: function (data) {
				        		let cdtFitData = new Array();

								$("tbody").empty();
								$.each(data, function(index, vo) {
									
									aroundStr="";
									/* 조건에 맞는지 확인하고 맞으면 해당 리스트 출력&아니면 패스 */
									if (checkCondition(vo,arr)) {
										let str = `
											<tr class="${colorArr[index%3]}">
											<td>${"${vo.aptCode}"}</td>
											<td> ${"${vo.aptName}"}</td>
											<td>${"${vo.sidoName} ${vo.gugunName} ${vo.dongName} ${vo.jibun}"}</td>
											<td>${"${vo.buildYear}"}</td>
											<td>${"${vo.recentPrice}"}</td>
										`;
										if (arr.length!=0) {
											str += `<td>${"${aroundStr}"}</td>`;
										}
						
										$("tbody").append(str);
										cdtFitData.push(vo);
										
									}
 									
								});
								displayMarkers(cdtFitData);
				          	},
				      		error: function (error){
				      			console.log(error);
				      		}
				       	});
					console.log("로딩 완료");
				});

				</script>
			</div>
		</div>
		<div class="col-sm-5" >
			<div style="width:90% height:80%" id="map"></div>
		</div>
		</div>
		<script type="text/javascript" src="/js/map_sj2.js"></script>
		<script type="text/javascript" src="/assets/js/addAptCondition.js"></script>
	</section>
	<!-- End Portfolio Details Section -->
</main>

<!-- End #main -->

<%@ include file="footer.jsp"%>