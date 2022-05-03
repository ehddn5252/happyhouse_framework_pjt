<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="header.jsp"%>

<%-- <c:if test="${empty userInfo}">
   <script>
   alert("로그인 상태에서 볼 수 있는 페이지입니다.");
   location.href = "${root}/index.jsp";
   </script>
</c:if> --%>
<main id="main"> <!-- ======= Breadcrumbs Section ======= -->
<section class="breadcrumbs">
	<div class="container">
		<div class="d-flex justify-content-between align-items-center">
			<h2>관심지역 리스트</h2>
			<ol>
				<li><a href="index.jsp">Home</a></li>
				<li>관심지역 리스트</li>
			</ol>
		</div>
	</div>
</section>
<!-- Breadcrumbs Section --> <!-- ======= Portfolio Details Section ======= -->
<div class="container">
	<div class="form-control form-control-sm p-4 text-center"
		style="border-color: white">
		<button id="showInterestList" class="btn border btn-lg btn-primary"
			style="width: 40%; background-color: #00bfff; min-width: 180px">관심
			지역 확인</button>
	</div>
	<!-- End Breadcrumbs Section -->
	<div class="row">
		<div class="col-sm-5">
			<form id="infoForm" action="" method="get">

				<!-- 연의 추가 관심 지역 리스트 servlet으로 가기 위한 param -->

				<input type="hidden" name="act" value="">
                <input type="hidden" name="cmd" value="">
                <input type="hidden" name="regionCode" value="">
                <input type="hidden" name="interestID" value="">

				<div class="container-sm m-5 id="interestList">
					<table class="table">
						<tbody id="arealist">
							
						</tbody>
					</table>

				</div>
			</form>

		</div>
		<div class="col-sm-7">
			<div id="map" style="width: 80%; height: 500px"></div>
		</div>
	</div>s
</div>
<!-- End Portfolio Details Section -->
</main>

<!-- End #main -->
<%@ include file="footer.jsp" %>

<!-- 연의 추가 관심 지역 리스트 script -->
<script>
$(function(){
		$(document).on('click',".storeBtn", function(){
			$("#infoForm").attr("action","main");
		    $("input[name=act]").val("store");
		    $("input[name=cmd]").val("mvStore");
		    $("input[name=regionCode]").val($(this).parent().siblings().children("span").attr("id"));
		    $("#infoForm").submit();
	    });
		$(document).on('click',".envBtn", function(){
			$("#infoForm").attr("action","main");
	        $("input[name=act]").val("env");
	        $("input[name=cmd]").val("mvEnv");
	        $("input[name=regionCode]").val($(this).parent().siblings().children("span").attr("id"));
	        $("#infoForm").submit();
	    })
	    
	    $(document).on('click',".deleteBtn", function(){
	        if(confirm("해당 지역을 관심지역에서 삭제시키시겠습니까?")) {
		    	$("#infoForm").attr("action","interest");
		        $("input[name=act]").val("deleteInterest");
		        $("input[name=interestID]").val($(this).attr("id"));
		        $("#infoForm").submit();
	    	}
	    })
	    
	    $("#showInterestList").click(function(){
	        $.ajax({
	        	type:'get',
	        	url:'/interest/list',

	        	dataType:'text',
	        	success:function(data,textStatus){
	        		var res = JSON.parse(data);
	        		console.log(res);
	        		var tbodyEl = $("#arealist");
	        		var str="";
	        		tbodyEl.empty();
	        		
	        		var areaAddr=[];
	        		for(item in res){
	        			var regionCode = res[item].sidoCode +""+ res[item].sigugunCode+""+ res[item].dongCode+"00";
	        			
	        			str += "<tr>";
	        			str += "<td><span id='"+regionCode+"'>"+res[item].areaname+"</span></td>";
	        			str += "<td><a type=\"button\" class=\"storeBtn btn btn-warning btn-sm\">상권정보</a>&nbsp;";
	        			str += "<a type=\"button\" class=\"envBtn btn btn-success btn-sm\">환경정보</a>&nbsp;";
	        			str += 	"<a type=\"button\" id='"+res[item].interestid+"' class=\"deleteBtn btn-outline-light text-dark btn-sm\">삭제</a></td>";
	        			str += "</tr>";
	        			areaAddr.push({address : res[item].areaname});
	        			mapMarkByAddr(areaAddr);
	        		}
	        		
	        		
	        		tbodyEl.append(str);
	        		
	            },
	            error:function (data, textStatus) {
	                console.log(data);
	                console.log("관심 지역 조회 중 에러 발생");
	            }
	        })
	            			
	    })
	    
	    function mapMarkByAddr(positions){
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			  mapOption = {
				center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				level: 13 // 지도의 확대 레벨
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
				  let mark = "<div style='width:150px;text-align:center;padding:6px 0;'>"+positions[i].address+"</div>";
				  var infowindow = new kakao.maps.InfoWindow({
					content: mark
				  });
				  infowindow.open(map, marker);

				  // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				  map.setCenter(new kakao.maps.LatLng(36.4203054, 128.1597271));
				  
				  
				}
			  });
			}
		}
});
</script>