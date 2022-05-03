$(document).ready(function () {
  //sido option 추가
  $.each(hangjungdong.sido, function (idx, code) {
    //append를 이용하여 option 하위에 붙여넣음
    $("#sido").append(fn_option(code.sido, code.codeNm));
  });

  //sido 변경시 시군구 option 추가
  $("#sido").change(function () {
    $("#sigugun").show();
    $("#sigugun").empty();
    $("#sigugun").append(fn_option("", "구군선택")); //
    $.each(hangjungdong.sigugun, function (idx, code) {
      if ($("#sido > option:selected").val() == code.sido)
        $("#sigugun").append(fn_option(code.sigugun, code.codeNm));
    });

    //세종특별자치시 예외처리
    //옵션값을 읽어 비교
    if ($("#sido option:selected").val() == "36") {
      $("#sigugun").hide();
      //index를 이용해서 selected 속성(attr)추가
      //기본 선택 옵션이 최상위로 index 0을 가짐
      $("#sigugun option:eq(1)").attr("selected", "selected");
      //trigger를 이용해 change 실행
      $("#sigugun").trigger("change");
    }
  });

  //시군구 변경시 행정동 옵션추가
  $("#sigugun").change(function () {
    //option 제거
    $("#dong").empty();
    $.each(hangjungdong.dong, function (idx, code) {
      if (
        $("#sido > option:selected").val() == code.sido &&
        $("#sigugun > option:selected").val() == code.sigugun
      )
        $("#dong").append(fn_option(code.dong, code.codeNm));
    });
    //option의 맨앞에 추가
    $("#dong").prepend(fn_option("", "동선택"));
    //option중 선택을 기본으로 선택
    $('#dong option:eq("")').attr("selected", "selected");
  });

  $("#dong").change(function () {
    var sido = $("#sido option:selected").val();
    var sigugun = $("#sigugun option:selected").val();
    var dong = $("#dong option:selected").val();
    var dongCode = sido + sigugun + dong + "00";
  });
  
  $("#registerInterestBtn").click(function (){
	  var sido = $("#sido option:selected").val();
	    var sigugun = $("#sigugun option:selected").val();
	    var dong = $("#dong option:selected").val();
	    var areaName = $("#sido option:selected").text()
	    +" " +$("#sigugun option:selected").text()
	    +" " +$("#dong option:selected").text();
//	    var dongCode = sido + sigugun + dong + "00";
	    $.ajax({
        	url: 'interest',
        	data: {'act': 'insertInterest', 'sidoCode': sido, 'sigugunCode': sigugun,'dongCode': dong,'areaName': areaName},
          	dataType: 'text',
          	success: function (response) {
            	var cnt = parseInt(response);
            	if(cnt == 0) {
            		alert("등록완료했습니다.")
            	} 
          	}
		});
  });
});

function fn_option(code, name) {
  return '<option value="' + code + '">' + name + "</option>";
}
