$(document).ready(function () {
  $("#inteestConfirm").click(function () {
    var interestList = localStorage.getItem("interest");
    if (interestList == null) {
      alert("관심 지역을 설정하세요");
    }
    let interestListJson = JSON.parse(interestList);
    let index = 0;
    let appendList = "";
    for (let i of interestListJson) {
      let sido = i["sido"];
      let sigugun = " " + i["sigugun"];
      let dong = " " + i["dong"];
      let fullName = `${sido}${sigugun}${dong}`;
      appendList += `
        <div class="intrestList jumbotron .col-sm-2">
        <ul class="list-group">
        <li class="list-group-item list-group-item-primary">시: ${sido}</li>
        <li class="list-group-item list-group-item-primary">구: ${sigugun}</li>
        <li class="list-group-item list-group-item-primary">동: ${dong}</li>
        </ul>
        </div>
        <button type="button" class="intrestRegion" value="${fullName}">검색</button>
        `;
      index++;
    }

    $("#interestList").empty().append(appendList);

    $(".intrestRegion").click(function () {
      let s = this.getAttribute("value");
      let cityCode = s[0] + s[1] + s[2] + s[3] + s[4];
      let city = checkCity(cityCode);

      for (let index = 5; index < s.length; ++index) {
        city += s[index];
      }

      });
    });

  });

  $("#moveRegisterInterest").click(function () {
    location.href = "registerInterest.html";
  });

/*
1. 위치 정보로 좌표를 얻는다.
2. 좌표로부터 상가 정보를 얻는다.
3. 상가 정보를 맵에 추가한다.
*/

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
