<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, com.ssafy.happyhouse.model.*"%>
<%@ include file="header.jsp" %>
<c:if test="${empty userInfo}">
   <script>
   alert("로그인 상태에서 볼 수 있는 페이지입니다.");
   location.href = "${root}/index.jsp";
   </script>
</c:if>
<%
	String sido = (String)request.getAttribute("sido");
	String sigugun = (String)request.getAttribute("sigugun");
	String dong = (String)request.getAttribute("dong");
%>
	<main id="main"> <!-- ======= Breadcrumbs Section ======= -->
	<section class="breadcrumbs">
		<div class="container">
			<div class="d-flex justify-content-between align-items-center">
				<h2>관심 지역 상권 조회</h2>
				<ol>
					<li><a href="index.jsp">Home</a></li>
					<li>관심 지역 상권 조회</li>
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
					</div>

					<!-- 상권 정보 -->

					<label><input type="checkbox" name="mainCode" value="'N'">관광/여가/오락</label>
					<label><input type="checkbox" name="mainCode" value="'D'">소매</label>
					<label><input type="checkbox" name="mainCode" value="'Q'">음식</label>
					<label><input type="checkbox" name="mainCode" value="'F'">생활서비스</label>
					<label><input type="checkbox" name="mainCode" value="'O'">숙박</label>
					<label><input type="checkbox" name="mainCode" value="'P'">스포츠</label>
					<label><input type="checkbox" name="mainCode" value="'R'">학문/교육</label>
					<label><input type="checkbox" name="mainCode" value="'L'">부동산</label>

					<!-- <button id="listBtn2" type="button" onClick="searchStore()">검색</button> -->
					<input type="button" id="searchStoreBtn" value="조회" />
					<!-- <a id="listBtn2" class="search-element" type="button">검색</button> -->
				</form>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-4">
				<p class="apart_list_title my-5">상권 목록</p>
				<div id="storeinfo">
					<table class="table table-striped">
						<thead id="storeinfo-thead">
							<tr>
								<th>원하는 상권 정보를 검색하세요.</th>
							</tr>
						</thead>
						<tbody id="storeinfo-tbody">

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
	<!-- 연의 추가  -->
    
	<script>
	$(document).ready(function () {
		
		setRegion();
		
		
		$("#searchStoreBtn").click(function(){
			var sido = $("#sido option:selected").val();
			var sigugun = $("#sigugun option:selected").val();
			var dong = $("#dong option:selected").val();
			
			//regionCode 생성
			var regionCode = sido+""+sigugun+""+dong+"00";
			
			// checked 넘겨주기위한 string 생성 (?checked='R'&checked='L'....)
			var checkedList = "?";
			$("input[name='mainCode']:checked").each(function(){
				var val = $(this).val();
				checkedList += ("checked="+val+"&") ;
			})
			
			
			$.ajax({
				type:'get',
	            url:'main'+checkedList,	
	           	data: {
	           		act:"store",
	           		cmd:"searchStore",
	           		regionCode  :regionCode,
					},
				dataType:'text',
	            success: function(data, textStatus) {
	            	var res = JSON.parse(data);// String을 JSON으로
	            	var tbodyEl = $("#storeinfo-tbody");
	            	var theadEl = $("#storeinfo-thead");
	            	theadEl.empty();
	            	theadEl.append("<tr><th>상호명</th><th>도로명 주소</th></tr>");
	            	
	            	tbodyEl.empty();
	            	var str ="";
	            	var positions=[];
	            	if(res!=null){
	            		for( item in res ){
		            		str += "<tr>";
		            		str += "<td>"+res[item].storename+"</td>";
							str += "<td>"+res[item].address+"</td>";
							str += "</tr>";
							
							positions.push({title:res[item].storename,
											latlng: new kakao.maps.LatLng(res[item].lat, res[item].lng)});
		            	}
		            	tbodyEl.append(str);
		            	mapMarkByLatlng(positions);
	            	}else{
	            		console.log("데이터 없음")
	            	}
	            	
	            },
	            error:function (data, textStatus) {
	                console.log(data);
	                console.log("에러");
	            }
			})
			
			
		})
		
		function mapMarkByLatlng(positions){
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		    mapOption = { 
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 5 // 지도의 확대 레벨
		    };

			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

			// 마커 이미지의 이미지 주소입니다
			var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
			    
			for (var i = 0; i < positions.length; i ++) {
			    
			    // 마커 이미지의 이미지 크기 입니다
			    var imageSize = new kakao.maps.Size(24, 35); 
			    
			    // 마커 이미지를 생성합니다    
			    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
			    
			    // 마커를 생성합니다
			    var marker = new kakao.maps.Marker({
			        map: map, // 마커를 표시할 지도
			        position: positions[i].latlng, // 마커를 표시할 위치
			        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			        image : markerImage // 마커 이미지 
			    });
			}
			map.setCenter(positions[0].latlng);
		
		}
		
		
		
	})
	
	function setRegion(){
		$("#sido option[value='<%=sido%>']").attr("selected","selected");
		sidoChange();
		$('#sigugun option[value=<%=sigugun%>]').attr("selected","selected");
		sigugunChange();
		$('#dong option[value=<%=dong%>]').attr("selected", "selected");
		dongChange();
	}
	</script>
