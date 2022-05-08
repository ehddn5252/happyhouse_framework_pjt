$(document).ready(function () {
	
	/** 지도에 표시할 marker, infowindow 배열 **/
	var markers = [];
	var markers2 = [];
	var infowindows=[];
	
	/** 지도 생성, 띄우기 **/
	
	var srvmapContainer = document.getElementById('map'), // 지도를 표시할 div  
	srvmapOption = { 
        center: new kakao.maps.LatLng(37.56625660787554, 126.97883352433375), // 지도의 중심좌표
        level: 6 // 지도의 확대 레벨
    };

	var srvmap = new kakao.maps.Map(srvmapContainer, srvmapOption); // 지도를 생성합니다
	

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	//** 지도 eventListener ( 클릭한 위치의 좌표 가져오고 마커와 인포윈도우 객체 생성 후 배열에 저장 -> 리스트, map 출력) **//*
	// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보 selectedPositions 리스트에 저장
	kakao.maps.event.addListener(srvmap, 'click', function(mouseEvent) {
		
		// 최대 5개 까지 선택
		if(markers.length == 5){
			alert("최대 5개 까지 선택할 수 있습니다.");
			return;
		}
		
		// 
		var latlng = mouseEvent.latLng;

	    searchDetailAddrFromCoords(latlng, function(result, status) {
	        if (status === kakao.maps.services.Status.OK) {
	        	
	        	// 지번 주소 : result[0].address.address_name;
	    	    
			    // 마커 이미지의 이미지 주소입니다
				var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
			    
			    // 마커 이미지의 이미지 크기 입니다
			    var imageSize = new kakao.maps.Size(24, 35); 
			    
			    // 마커 이미지를 생성합니다    
			    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	            
	            // 마커를 생성하고 리스트에 저장
			    markers.push(new kakao.maps.Marker({
			        position: new kakao.maps.LatLng(latlng.getLat(),latlng.getLng()), // 마커를 표시할 위치
			        title : result[0].address.address_name, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			        image : markerImage
			    }));
			    
			    markers2.push(new kakao.maps.Marker({
					position: new kakao.maps.LatLng(latlng.getLat(),latlng.getLng()), // 마커를 표시할 위치
					title : result[0].address.address_name, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
					image : markerImage
				}));
	            
			    // 인포윈도우
			    var iwContent = '<div style="font-size: 14px;">'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			    iwContent += result[0].address.address_name;
			    iwContent += '</div>';
			    
	
			    // 인포윈도우를 생성합니다
				infowindows.push(new kakao.maps.InfoWindow({
				    position : new kakao.maps.LatLng(latlng.getLat(),latlng.getLng()), 
				    content : iwContent 
				}));
			    
	        }
		    //리스트 출력
		    showSelected()
		    
		    // 맵 표시
		    mapMarkByLatlng(markers, srvmap);
		    mapInfoByLatlng(infowindows, markers, srvmap);
	    });

	});
	
	
	// 지역 리스트 출력하는 함수
	function showSelected(){
	    var resultDiv = $("#resultList");
	    resultDiv.empty();
	    
	    
	    if(markers.length==0){
	    	return;
	    }
	    
	    var resultAddr = "";
	    for(var i = 0 ; i<markers.length; i++){
	    	resultAddr += "<div><span>";
	    	resultAddr += markers[i].getTitle();
	    	resultAddr += "</span><span id='"+i+"'aria-label='Close' class='deleteBtn btn-close' style='float: right;'></span>"
	    	resultAddr += "</div><br/>";
	    }
	    resultDiv.append(resultAddr);
	}
	
	// 지도에 마커 표시하는 함수
	function mapMarkByLatlng(markers, map){
		console.log("마커 표시");
		for (var i = 0; i < markers.length; i ++) {
		    // 마커 표시
		    markers[i].setMap(map);
		}
	}
	
	// 지도에 인포윈도우 표시하는 함수
	function mapInfoByLatlng(infowindows, markers, map){
		for (var i = 0; i < markers.length; i ++) {
		    // 인포 윈도우 표시
			infowindows[i].open(map, markers[i]); 
		}
	}
	
	// 마커 한개 제거
	$(document).on("click",".deleteBtn",function(){

		var deleteId = $(this)[0].id;
		
		markers[deleteId].setMap(null);
		infowindows[deleteId].close();
		
		markers.splice(deleteId,1);			  // 마커 제거
		infowindows.splice(deleteId,1);		  // 인포윈도우 제거
	
		showSelected();
	})
	
	
	//마커 전체 제거
	$(document).on("click","#clearAllBtn",function(){
		
		hideMarkers(); // 마커와 인포윈도우 지우기 -> 제일 먼저 해야함.
		
		markers=[];		// 마커 전체 삭제
		infowindows= [];  // 위치 전체 삭제
		
		showSelected();
	})
	

	function searchAddrFromCoords(coords, callback) {
	    // 좌표로 행정동 주소 정보를 요청합니다
	    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
	}

	function searchDetailAddrFromCoords(coords, callback) {
	    // 좌표로 법정동 상세 주소 정보를 요청합니다
	    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	}

	
	// "마커 감추기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에서 삭제하는 함수입니다
	function hideMarkers() {
	    for (var i = 0; i < infowindows.length; i++) {
	        infowindows[i].close();
	        markers[i].setMap(null);
	    } 
	}
	
	/************************************************************************************/
	$(document).on("click", "#getBest", function(){
		
		
		if(markers.length==0){
			alert("1개 이상의 선호 지역을 선택해주세요");
			return;
		}
		
		var distance = document.getElementById('getDistance').value;
		console.log(distance);
		if(distance == "" || parseInt(distance) <1){
			alert("1km 이상 조회 가능 합니다.");
			return;
		}
		
		
		var avgLat = 0, avgLng = 0 ;
		for(var i = 0; i < markers.length;i++) {
			avgLat += markers[i].getPosition().getLat();
			avgLng += markers[i].getPosition().getLng();
		}
		
		avgLat /= markers.length;
		avgLng /= markers.length;
		console.log(avgLat);
		console.log(avgLng);
		
		var content="";
		var rsMarkers=[];
		
		$("#resultDiv").attr("style","display:");
		
		$("#resultMap").empty();
		var rsMapContainer = document.getElementById('resultMap'), // 지도를 표시할 div
	    rsMapOption = { 
	        center: new kakao.maps.LatLng(avgLat, avgLng), // 지도의 중심좌표
	        level: (parseInt(distance)+4), // 지도의 확대 레벨
	    };
		var rsMap = new kakao.maps.Map(rsMapContainer, rsMapOption); // 지도를 생성합니다
		
	    $.ajax({
	    	type:'POST',
	    	url:'/service/getApt/',
	    	data : JSON.stringify({
	    		lat:avgLat,
	    		lng:avgLng,
				distance:distance
			}),
	    	contentType: 'application/json',
	    	dataType:"json",
	    	success:function(data,textStatus){
        		
        		
        		/***************** 리스트 출력, 마커 생성 *****************/

        		
        		for(var i = 0; i< data.length;i++){
        			content +=`<tr>
                		<th>${data[i].aptCode}</th>
                		<th>${data[i].aptName}</th>
                		<th>${data[i].sidoName} ${data[i].gugunName} ${data[i].dongName} ${data[i].jibun}</th>
                		<th>${data[i].buildYear}</th>
                		<th>${data[i].recentPrice}</th>
                		</tr>`;
        			//(new kakao.maps.Marker(
        			var marker = new kakao.maps.Marker({
        				map:rsMap,
    			        position: new kakao.maps.LatLng(data[i].lat,data[i].lng), // 마커를 표시할 위치
    			        title : data[i].aptName, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
    			        text : data[i].aptName
    			    });
        			
        			 var infowindow = new kakao.maps.InfoWindow({
        			        content:`<div class="mx-auto" style='text-align:center; font-size: 14px;'>${data[i].aptName}</div>` // 인포윈도우에 표시할 내용
        			    });

        			    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
        			    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
        			    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
        			    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(rsMap, marker, infowindow));
        			    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
        			
        		}
        		
        		var rstBody = $('#searchResult'); // 지도를 표시할 div
        		rstBody.empty();
        		rstBody.append(content);
        		
	    	}
	    })
	    mapMarkByLatlng(markers2,rsMap);
	    mapInfoByLatlng(infowindows,markers,rsMap);
	    
	});
	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	function makeOverListener(map, marker, infowindow) {
	    return function() {
	        infowindow.open(map, marker);
	    };
	}

	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
	}
	
});