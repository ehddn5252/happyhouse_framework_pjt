// document.cookie = "safeCookie1=foo; SameSite=Lax"; 
// document.cookie = "safeCookie2=foo"; 
// document.cookie = "crossCookie=bar; SameSite=None; Secure";

$(document).ready(function () {
  function mapMarking(infoList) {
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
      mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
      };

    let roadNameList = infoList[0];
    let apartList = infoList[1];
    let priceList = infoList[2];
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
          var marker = new kakao.maps.Marker({
            map: map,
            position: coords
          });

          // 인포윈도우로 장소에 대한 설명을 표시합니다
          let mark = `<div style="width:150px;text-align:center;padding:6px 0;">${apartList[i] + "\n거래가: " + priceList[i]}</div>`;
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

  $('#listBtn2').click(function () {
    // 요건 안바뀜
    var ServiceKey = 'yOYPxjA2Luqpjh8gS0r0pw69WoBHUn5HXJzTznjhCK78Aab2ZiFJ5pAGNq/LoVzbI1pCfMG10RPiGyk+qfFAIQ==';
    //var pageNo = '1';
    var numOfRows = '10';
    // let city = document.getElementById("city");//'202002';
    // let sigugun = document.getElementById("sigugun");//'202002';
    // let dong = document.getElementById("dong");//'202002';
    //var LAWD_CD = $(`#city option:checked`).text() +" " + $(`#sigugun option:checked`).text() +" " + $(`#dong option:checked`).text();
    var LAWD_CD = $(`#sido`).val() + $(`#sigugun`).val();
    var contractDay = document.getElementById("contractDay");//'202002';
    var DEAL_YMD = contractDay.value;//'202002'; // 요건 어떻게 할까?

    // server에서 넘어온 data
    $.ajax({
      url: 'http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev',
      type: 'GET',
      data: {
        "ServiceKey": ServiceKey,
        // "pageNo": pageNo,
        "numOfRows": numOfRows,
        "LAWD_CD": LAWD_CD,
        "DEAL_YMD": DEAL_YMD
      },
      dataType: 'xml',
      success: function (response) {
        console.log(response);
        var roadNameList = makeList2(response);
        mapMarking(roadNameList);
      },
      error: function (xhr, status, msg) {
        console.log('상태값 : ' + status + ' Http 에러메시지 : ' + msg);
      },
    });
  });

  function getRoadNameNum(fullRoadNameNum) {
    let shortRoadNameNum = ""
    let continueFlag = true;
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

  function makeList2(data) {
    let aptlist = ``;
    let dong = document.getElementById("dong").value.trim();//'익선동';
    //let apartment = document.getElementById("apartment").value;//'202002';
    let roadNameList = [];
    let priceList = [];
    let apartList = [];
    let areaList = [];
    let nowIndex = 0;
    $(data).find('item').each(function () {
      let cityName = checkCity($(this).find('도로명시군구코드').text());
      let fullName = makeRoadName($(this));
      let price = $(this).find('거래금액').text();
      let bubDong = $(this).find('법정동').text();
      let area = $(this).find('전용면적').text();
      let apart = $(this).find('아파트').text();
      if (dong != "$(this).find('법정동').text().trim() == dong") {
        roadNameList.push(cityName + " " + bubDong);
      }
      else if (dong == "") {
        roadNameList.push(fullName);
      }
      priceList.push(price);
      apartList.push(apart);
      areaList.push(area);
      // <button  onclick="apartSearchClick(\'${apart}\',\'${data}\');" value="${apart}">아파트 검색2</button>
      aptlist += `
      <div class="col-sm-8 contentDiv border border-secondary">
      <div class="divider border border-secondary bg-light">
      <li class ="now${nowIndex}">
      <ul>아파트 : ${apart}</ul>
      <ul>법정동 : ${bubDong}</ul>
      <ul>전용면적: ${area}</ul>
      <ul>주소: ${fullName}</ul>
      <input type="button" class="btnApart " name=\"${apart}\" value = "아파트검색"/>
      </li>
      </div>
      </div>
      `

      nowIndex += 1;
      $('#aptinfo').empty().append(aptlist);
    });

    $('.btnApart').click(function () {
      let apart = $(this).attr("name");
      // this.getElementsByClassName('btnApart');
      console.log("apart");
      console.log(apart);
      $('#aptinfo *').remove();
      apartSearchClick(apart, data);
      
      function apartSearchClick(apart, data) {
        aptlist = ``;
        let roadNameList = [];
        let priceList = [];
        let nowIndex = 0;
        $(data).find('item').each(function () {
          let cityName = checkCity($(this).find('도로명시군구코드').text());
          let fullName = makeRoadName($(this));
          let price = $(this).find('거래금액').text();
          let bubDong = $(this).find('법정동').text();
          let area = $(this).find('전용면적').text();
          let localApartName = $(this).find('아파트').text();
          console.log("aptlist");
          console.log(aptlist);
          if (localApartName == apart) {
            roadNameList.push(fullName);
            priceList.push(price);
            aptlist += `
            <div class="col-sm-8 contentDiv border border-secondary">
            <div class="divider border border-secondary bg-light">
            <li class ="now${nowIndex}">
            <ul>아파트 : ${apart}</ul>
            <ul>법정동 : ${bubDong}</ul>
            <ul>전용면적: ${area}</ul>
            <ul>주소: ${fullName}</ul>
            <input type="button" class="btnApart" name=\"${apart}\" value = "아파트검색"/>
            </li>
            </div>
            </div>
            `
            $('#aptinfo').empty().append(aptlist).css('color', "black");
            nowIndex += 1;
          }

        })
        mapMarkingApart(roadNameList, priceList, apart)
      }

      function mapMarkingApart(roadNameList, priceList, apart) {
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
          mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
          };

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
              var marker = new kakao.maps.Marker({
                map: map,
                position: coords
              });

              // 인포윈도우로 장소에 대한 설명을 표시합니다
              let mark = `<div style="width:150px;text-align:center;padding:6px 0;">${apart + "\n거래가: " + priceList[i]}</div>`;
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
    });
    return [roadNameList, priceList, apartList];
  }

  function makeRoadName(XMLObject) {
    let roadName = $(XMLObject).find('도로명').text();
    let roadNameNum = $(XMLObject).find('도로명건물본번호코드').text();
    let roadNameSubNum = $(XMLObject).find('도로명건물부번호코드').text();
    let cityName = checkCity($(XMLObject).find('도로명시군구코드').text());
    let fullName = cityName + " " + roadName + " " + getRoadNameNum(roadNameNum) + "-" + getRoadNameNum(roadNameSubNum);
    return fullName;
  }
});

window.onload = function () {
  if (!document.querySelector(".content-user-list-ul")) return;
  // 비동기 통신을 위해 새로운 xmlhttp 요청 생성
  const xhr = new XMLHttpRequest();
  // 요청 method
  const method = "GET";
  // 파일 위치
  const url = "data\\user.json";

  // 위의 method 와 url 로 비동기 요청 초기화
  xhr.open(method, url, true);
  // 요청 헤더 설정
  xhr.setRequestHeader("Content-Type", "application/text");
  // 요청 동작 설정
  xhr.onreadystatechange = function () {
    if (xhr.readyState === xhr.DONE) {
      // 요청 상태가 OK 이면
      if (xhr.status === 200) {
        // Json 객체 형태로 응답 받기
        const resJson = JSON.parse(xhr.responseText);
        const userData = resJson.users;
        // 자동차 data 삽입할 html 요소 찾기
        let userList = document.querySelector(".content-user-list-ul");
        for (let i = 0; i < userData.length; i++) {
          let carItem = `
              <li>
                <div class="list-item">
                  <div>
                    <img src="${userData[i]["img"]}" alt="" />
                  </div>
                  <div class="user-info">
                    <div>
                      <div>${userData[i]["id"]}</div>
                      <div>${userData[i]["name"]}</div>
                      <div>${userData[i]["email"]}</div>
                      <div>${userData[i]["age"]} 세</div>
                    </div>
                  </div>
                </div>
              </li>
              `;
          userList.innerHTML += carItem;
        }
      }
    }
  };

  // 요청 보내기
  xhr.send();
};

function checkCity(cityCode) {
  let cityName = "";
  switch (cityCode) {
    case "27110":
      cityName = "대구광역시";
      break;
    case "30110":
      cityName = "대전광역시";
      break;
    case "26110":
      cityName = "부산광역시";
      break;
    case "11110":
      cityName = "서울특별시";
      break;
    case "36110":
      cityName = "세종특별자치시";
      break;
    case "31110":
      cityName = "울산광역시";
      break;
    case "28110":
      cityName = "인천광역시";
      break;
    case "46110":
      cityName = "전라남도";
      break;
    case "45111":
      cityName = "전라북도";
      break;
    case "50110":
      cityName = "제주특별자치도";
      break;
    case "44131":
      cityName = "충청남도";
      break;
    case "43111":
      cityName = "충청북도";
      break;
  }
  return cityName;
}
