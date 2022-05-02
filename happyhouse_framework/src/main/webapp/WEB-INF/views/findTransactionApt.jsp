<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5604814141adf4eb08f174929c528f6e&libraries=services"></script>
<%@ include file="header.jsp"%>


<c:if test="${empty userInfo}">
   <script>
   alert("로그인 상태에서 볼 수 있는 페이지입니다.");
   location.href = "${root}/index.jsp";
   </script>
</c:if> 

<script type="text/javascript">


	$(document).ready(function() {

		function mapMarking(infoList) {
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
					level: 3 // 지도의 확대 레벨
				};

			let roadNameList = infoList[0];
			let priceList = infoList[1];
			let apartList = infoList[2];
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption);

			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			for (let i = 0; i < roadNameList.length; ++i) {
				// 주소로 좌표를 검색합니다
				geocoder.addressSearch(roadNameList[i], function (result, status) {

					// 정상적으로 검색이 완료됐으면 
					if (status === kakao.maps.services.Status.OK) {
						var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						// 결과값으로 받은 위치를 마커로 표시합니다
						let mark = "<div>"+apartList[i]+"<br>"+priceList[i]+"</div>";
						let title = apartList[i]+"\n" +priceList[i];
						var marker = new kakao.maps.Marker({
							map: map,
							position: coords,
							title:title
						});
						
						// 인포윈도우로 장소에 대한 설명을 표시합니다
/* 
						var infowindow = new kakao.maps.InfoWindow({
							content:mark
						});
						infowindow.open(map, marker);
 */
						// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
						map.setCenter(coords);
						
					}
				});
				
				
			}
		};

		
		
		$("#searchBtn").click(function () {
			let roadNameList = []; 
			let priceList = [];
			let apartList = [];
			let areaList = [];
			let nowIndex = 0;
			
			var aptName = $("#aptName").val();
			$.ajax({
				type:'get',
	            url:'houseDeal',	
	           	data: {
	           		act:"searchByApt",
	           		aptName:aptName,
					},
				dataType:'text',
	            success: function(data, textStatus) {
	            	// console.log(JSON.parse(data)); 	// String을 JSON으로
	            	var res = JSON.parse(data);
	             	var tbodyEl = $("#storeinfo-tbody");
	            	var theadEl = $("#storeinfo-thead");
	            	theadEl.empty();
	            	theadEl.append("<tr><th>도로명</th><th>지역크기</th><th>가격</th><th>아파트명</th></tr>");
	            	var str ="";
	            	var infoList=[]
					for( item in res ){
						
						console.log(res[item].cityName)
						let fullName = makeRoadName(res[item].roadName,res[item].bunCode,res[item].buBunCode)
	            		console.log("fullName");
						console.log(fullName);
						roadNameList.push(fullName);
						areaList.push(res[item].area);
						priceList.push(res[item].dealAmount);
						apartList.push(res[item].aptName);
						
						
	            		str += "<tr>";
	            		str += "<td>"+res[item].roadName+"</td>";
	            		str += "<td>"+res[item].area+"</td>";
						str += "<td>"+res[item].dealAmount+"</td>";
						str += "<td>"+res[item].aptName+"</td>";
						str += "</tr>";
						
	            	}
	            	tbodyEl.empty().append(str);
	            	mapMarking([roadNameList, priceList, apartList]);

	            },
	            error:function (data, textStatus) {
	                console.log(data);
	            }
			})
			/* mapMarking(roadNameList); */
		});
		

		  function getRoadNameNum(fullRoadNameNum) {
			    let shortRoadNameNum = ""
			    let continueFlag = true;
			    if(fullRoadNameNum ==null){
			    	return;
			    }
			    for (let i = 0; i < fullRoadNameNum.length; ++i) {
			      if (continueFlag && fullRoadNameNum[i] == '0') {
			        continue;
			      }
			      else {
			        continueFlag = false;
			        shortRoadNameNum += fullRoadNameNum[i];
			      }
			    }
			    if (shortRoadNameNum == "") {
			      shortRoadNameNum = "0";
			    }
			    return shortRoadNameNum;
			  }
			
			  function makeRoadName(roadName,bunCode,buBunCode) {
				  let fullName = roadName + " " + getRoadNameNum(bunCode) + "-" + getRoadNameNum(buBunCode);
				  return fullName;
			}

	});
</script>

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

		<div class="container">
		<div class="login-page">
			<div class="form">
				<form id="transactionForm" name="transactionForm" class="search-form">

					<input type="hidden" name="act" id="act" value="searchByApt">
					<div class="form-group">
						<p class="search-element">아파트명</p>
						 <input type="text"
							class="form-control" id="aptName" name="aptName"
							placeholder="아파트명" style="border:solid 1px #132a4b">
					</div>
					<div class="mt-3">
					<button id="searchBtn" class="searchBtn" type="button">검색</button>
					</div>

				</form>
			</div>
		</div>	
		<div class="row">
			<div class="col-sm-4">
				<h3 class="apart_list_title my-5">지역 검색</h3>
				<div>
					<table class="table table-striped">
					<thead id = "storeinfo-thead"></thead>
					<tbody id="storeinfo-tbody"></tbody>
					
					</table>
				</div>
			</div>
			<div id="map" class="col-sm-8 my-5"></div>
		
		</div>
	</div>




	<!-- End Portfolio Details Section -->
</main>

<!-- End #main -->
<%@ include file="footer.jsp"%>
