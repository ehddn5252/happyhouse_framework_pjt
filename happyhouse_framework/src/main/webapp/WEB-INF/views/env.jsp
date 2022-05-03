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
				<h2>관심 지역 환경 조회</h2>
				<ol>
					<li><a href="index.jsp">Home</a></li>
					<li>관심 지역 환경 조회</li>
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
						<p class="search-element">도시</p>
						<select class="selectpicker" id="sido" name="sido">
							<option value="">시도선택</option>
						</select> <select class="selectpicker" id="sigugun" name="sigugun">
							<option value="">구군선택</option>
						</select> <select class="selectpicker" id="dong" name="dong">
							<option value="">동선택</option>
						</select>
						<input type="button" id="searchEnvBtn" value="검색" />
					</div>

					<!-- <button id="listBtn2" type="button" onClick="searchStore()">검색</button> -->
					
					<!-- <a id="listBtn2" class="search-element" type="button">검색</button> -->
				</form>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-4">
				<p class="apart_list_title my-5">환경 목록</p>
				<div id="storeinfo">
					<table class="table table-striped">
						<thead id="envinfo-thead">
							<tr>
								<th>원하는 지역의 환경 정보를 검색하세요.</th>
							</tr>
						</thead>
						<tbody id="envinfo-tbody">

						</tbody>
					</table>
				</div>
			</div>
			<div id="map" class="col-sm-8 my-5"></div>

		</div>
	</div>
	<!-- End Portfolio Details Section --> </main>

	<!-- End #main -->
<%@ include file="footer.jsp" %>

	<script type="text/javascript">
	let colorArr = ['table-primary','table-success','table-danger'];
	$(document).ready(function(){	
		
		$.get("/map/sido"
			,function(data, status){
				$.each(data, function(index, vo) {
					$("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
				});
			}
			, "json"
		);
	});
	$(document).on("change", "#sido", function() {
		$.get("/map/gugun"
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
		$.get("/map/dong"
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
	$(document).on("change", "#dong", function() {
		$.get("/map/apt"
				,{dong: $("#dong").val()}
				,function(data, status){
					$("tbody").empty();
					$.each(data, function(index, vo) {
						let str = `
							<tr class="${colorArr[index%3]}">
							<td>${vo.aptCode}</td>
							<td>${vo.aptName}</td>
							<td>${vo.sidoName} ${vo.gugunName} ${vo.dongName} ${vo.jibun}</td>
							<td>${vo.buildYear}</td>
							<td>${vo.recentPrice}</td>
						`;
						$("tbody").append(str);
					});
					//displayMarkers(data);
				}
				, "json"
		);
	});
	</script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fdf614748efadd63bf7ce73b5ddad4f1&libraries=services"></script>
	<script>
	$(document).ready(function () {
		
		setRegion();
		
		$("#searchEnvBtn").click(function(){
			var sido = $("#sido option:selected").val();
			var sigugun = $("#sigugun option:selected").val();
			var dong = $("#dong option:selected").val();
			
			//regionCode 생성
			var regionCode = sido+""+sigugun+""+dong+"00";

			$.ajax({
				type:'GET',
	            url:'/interestinfo/env/search/'+regionCode,	
				dataType:'text',
	            success: function(data, textStatus) {
	            	console.log(data); 	// String을 JSON으로
	            	
	            	var res = JSON.parse(data);
	            	if(res.length > 0){
		            	var tbodyEl = $("#envinfo-tbody");
		            	var theadEl = $("#envinfo-thead");
		            	theadEl.empty();
		            	theadEl.append("<tr><th>업체/기관명</th><th>종류</th></tr>");
		            	
		            	tbodyEl.empty();
		            	var str ="";
		            	
		            	var envAddress=[];
		            	for( item in res ){
		            		console.log(res[item].address);
		            		str += "<tr>";
		            		str += "<td>"+res[item].name+"</td>";
							str += "<td>"+res[item].typeName+"</td>";
							str += "</tr>";
							
							envAddress.push({title : res[item].name,
											address: res[item].address});
		            	}
		            	tbodyEl.append(str);
		            	mapMarkByAddr(envAddress);
	            	}else{
	            		var theadEl = $("#storeinfo-thead");
	            		theadEl.empty();
	            		theadEl.append("<tr><th>환경 정보가 없습니다.</th></tr>");
	            	}
	            	
	            },
	            error:function (data, textStatus) {
	            	location.href="/error/error.jsp";
	            }
			})
			
			
		})
		
		// 주소로표시
		function mapMarkByAddr(positions){
		    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		      mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 7 // 지도의 확대 레벨
		      };

		    // 지도를 생성합니다    
		    var map = new kakao.maps.Map(mapContainer, mapOption);

		    // 주소-좌표 변환 객체를 생성합니다
		    var geocoder = new kakao.maps.services.Geocoder();
		    for (let i = 0; i < positions.length; ++i) {
		      // 주소로 좌표를 검색합니다
		      geocoder.addressSearch(positions[i].address, function (result, status) {

		        // 정상적으로 검색이 완료됐으면 
		        if (status === kakao.maps.services.Status.OK) {
		          var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		          // 결과값으로 받은 위치를 마커로 표시합니다
		          var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		          });

		          // 인포윈도우로 장소에 대한 설명을 표시합니다
		          let mark = "<div style='width:150px;text-align:center;padding:6px 0;'>"+positions[i].title+"</div>";
		          var infowindow = new kakao.maps.InfoWindow({
		            content: mark
		          });
		          infowindow.open(map, marker);

		          // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		          map.setCenter(coords);
		        }
		      });
		    }
		}
		
		
		
	})
	
	function setRegion(){
		if(<%=code%> != null){
			var code = "<%=code%>";
			var sido = code.substring(0, 2);
			var sigugun = code.substring(2, 5);
			var dong = code.substring(5, 8);
			
			$("#sido option[value='"+sido+"']").attr("selected","selected");
			sidoChange();
 			$("#sigugun option[value='"+sigugun+"']").attr("selected","selected");
			sigugunChange();
			$("#dong option[value='"+dong+"']").attr("selected", "selected");
			dongChange()
		}
	}
	</script>


