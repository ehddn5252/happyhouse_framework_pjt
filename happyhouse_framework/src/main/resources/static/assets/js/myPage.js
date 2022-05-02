$(document).ready(function () {


  // 수정 버튼 누르면 .myPage-check이 수정되도록 변경
//  $("#info-check-btn").click(function () {
//    if (modify_info()) {
//      $(".modify").attr("disabled", true);
//      $("#info-modify-btn").toggleClass("d-none");
//      $("#info-check-btn").toggleClass("d-none");
//      $("#info-delete-btn").toggleClass("d-none");
//    }
//  });
	$("#info-modify-btn").click(function(e){
		  e.preventDefault();
	  });

  
  $("#info-modify-btn").click(function () {
    $(".modify").removeAttr("disabled");
    $("#info-modify-btn").toggleClass("d-none");
    $("#info-check-btn").toggleClass("d-none");
    $("#info-delete-btn").toggleClass("d-none");
  });
});
