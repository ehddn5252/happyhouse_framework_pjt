<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5604814141adf4eb08f174929c528f6e&libraries=services"></script>
<%@ include file="header.jsp"%>
<script src="assets/js/hangjungdong.js"></script>

<c:if test="${empty userInfo}">
   <script>
   alert("로그인 상태에서 볼 수 있는 페이지입니다.");
   location.href = "${root}/index.jsp";
   </script>
</c:if> 
 

<script type="text/javascript">
			$(document)
				.ready(function () {
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
						// 마커 이미지의 이미지 주소입니다
						var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 


						// 주소-좌표 변환 객체를 생성합니다
						var geocoder = new kakao.maps.services.Geocoder();
						if(roadNameList==null)return;
						for (let i = 0; i < roadNameList.length; ++i) {
							// 주소로 좌표를 검색합니다

							var imageSize = new kakao.maps.Size(24, 35); 
						    
						    // 마커 이미지를 생성합니다    
						    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
							geocoder.addressSearch(roadNameList[i], function (result, status) {

								// 정상적으로 검색이 완료됐으면 
								if (status === kakao.maps.services.Status.OK) {
									var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
									// 결과값으로 받은 위치를 마커로 표시합니다
									var title=apartList[i]+"\n"+priceList[i];
									var marker = new kakao.maps.Marker({
										map: map,
										position: coords,
										title:title
									});
/* 
									// 인포윈도우로 장소에 대한 설명을 표시합니다
						 			let mark = "<div>아파트명:"+apartList[i]+"<br>"+"아파트 가격:"+priceList[i]+"</div>";

									var infowindow = new kakao.maps.InfoWindow({
										content:mark
									});
									infowindow.open(map, marker); */

									// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
									map.setCenter(coords);
								}
							});
						}
					}
					


					$("#searchBtn").click(function () {
						let roadNameList = []; 
						let priceList = [];
						let apartList = [];
						let areaList = [];
						let nowIndex = 0;
						
						var sido = $("#sido option:selected").val();
						var sigugun = $("#sigugun option:selected").val();
						var dong = $("#dong option:selected").text();

						$.ajax({
							type:'get',
				            url:'houseDeal',	
				           	data: {
				           		act:"searchByRegion",
				           		sido:sido,
				           		sigugun:sigugun,
				           		dong: dong,
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
				            		str += "<td>"+fullName+"</td>";
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

					
					
						//sido option 추가
						$.each(hangjungdong.sido, function (idx, code) {
							//append를 이용하여 option 하위에 붙여넣음
							$("#sido")
								.append(fn_option(code.sido, code.codeNm));
						});

						//sido 변경시 시군구 option 추가
						$("#sido")
							.change(
								function () {
									$("#sigugun").show();
									$("#sigugun").empty();
									$("#sigugun").append(
										fn_option("", "구군선택")); //
									$.each(
											hangjungdong.sigugun,
											function (idx, code) {
												if ($(
													"#sido > option:selected")
													.val() == code.sido)
													$(
														"#sigugun")
														.append(
															fn_option(
																code.sigugun,
																code.codeNm));
											});

									//세종특별자치시 예외처리
									//옵션값을 읽어 비교
									if ($("#sido option:selected")
										.val() == "36") {
										$("#sigugun").hide();
										//index를 이용해서 selected 속성(attr)추가
										//기본 선택 옵션이 최상위로 index 0을 가짐
										$("#sigugun option:eq(1)")
											.attr("selected",
												"selected");
										//trigger를 이용해 change 실행
										$("#sigugun").trigger("change");
									}
								});

						//시군구 변경시 행정동 옵션추가
						$("#sigugun").change(function () {
									//option 제거
									$("#dong").empty();
									$.each(hangjungdong.dong,function (idx, code) {
												if ($(
													"#sido > option:selected")
													.val() == code.sido
													&& $(
														"#sigugun > option:selected")
														.val() == code.sigugun)
													$("#dong")
														.append(
															fn_option(
																code.dong,
																code.codeNm));
											});
									//option의 맨앞에 추가
									$("#dong").prepend(
										fn_option("", "동선택"));
									//option중 선택을 기본으로 선택
									$('#dong option:eq("")').attr(
										"selected", "selected");
								});

						$("#dong").change(function () {
							var sido = $("#sido option:selected").val();
							var sigugun = $("#sigugun option:selected").val();
							var dong = $("#dong option:selected").text();
							var dongCode = sido + sigugun + dong + "00";
							console.log(sido);
							console.log(sigugun);
							console.log(dong);
						});

						/*  */

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
<script>
			function fn_option(code, name) {
				return '<option value="' + code + '">' + name + "</option>";
			}

		  
		</script>
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

	<div class="container">
		<div class="login-page">
			<div class="form">
				<form id="transactionForm" name="transactionForm"
					class="search-form">
					<input type="hidden" name="act" id="act" value="searchByRegion">

					<div>
						<p class="search-element">도시</p>
						<select class="selectpicker" id="sido" value="부산광역시" name="sido"
							placeholder="시">
							<option value="">시도선택</option>
						</select> <select class="selectpicker" id="sigugun" value="연제구"
							name="sigugun" placeholder="구군">
							<option value="">구군선택</option>
						</select> <select class="selectpicker" id="dong" value="사직동" name="dong"
							placeholder="동">
							<option value="">동선택</option>
						</select>
					</div>

					<button id="searchBtn" class="searchBtn" type="button">검색</button>
					<!-- <a id="listBtn2" class="search-element" type="button">검색</button> -->
					
				</form>

			</div>
		</div>
		<div class="row">
		<div class="col-sm-4">
			<h3 class="apart_list_title my-5">지역 검색</h3>
			<div >
				<table class="table table-striped">
				<thead id = "storeinfo-thead"></thead>
				<tbody id="storeinfo-tbody"></tbody>
				</table>
			</div>
		</div>
		<div id="map" class="col-sm-8 my-5"></div>
	</div> 
	</div>
	
	  <!--       <div class="row">
          <div class="col-sm-4">
            <p class="apart_list_title my-5">아파트 정보 목록</p>
            <div id="aptinfo"></div>
          </div>
          <div id="map" class="col-sm-8 my-5"></div>
        </div> -->
	
	
	

	<!-- End Portfolio Details Section -->
</main>

<!-- End #main -->

<%@ include file="footer.jsp"%>