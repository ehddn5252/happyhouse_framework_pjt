$(document).ready(function () {
  $(".flip").click(function () {
    $(".panel").slideToggle("slow");
  });

  // 로그인 상태일 때는 메뉴들 활성화, 아닐 땐 비활성화
  // 비활성할 리스트
  var loginActive = ["findTrans"];
  var login = localStorage.getItem("checkLogin");

  if (login) {
    $(".log-btn-container").addClass("d-none");
    $(".info-btn-container").removeClass("d-none");
    $("#cta-beforeLogin").addClass("d-none");
    $("#cta").removeClass("d-none");
    // $(".logout-btn").removeClass("d-none");
    //
    $(".log-btn-container").addClass("d-none");
  } else {
    loginActive.forEach((el) => {
      $(".log-btn-container").removeClass("d-none");
      $(".info-btn-container").addClass("d-none");
      $("#cta-beforeLogin").removeClass("d-none");
      $("#cta").addClass("d-none");
      // $(".logout-btn").addClass("d-none");
      // $("#navbar>ul").find(`.${el},.${el}>ul>li`).addClass("inactive-nav");
      // $("#navbar>ul")
      //   .find(`.${el},.${el}>ul>li`)
      //   .prepend("<div class='inactive'><div>")
      //   .css("width");
      $("#navbar>ul").find(`.${el},.${el}>ul>li`).addClass("inactive-nav");
      $("#navbar>ul").find(`.${el}`).css("display", "none");
    });
  }

  // 포커스일 때 포커스 기능 추가(login, password 글자 위로)
  $(".login-form input").on("focus", function () {
    $(this).addClass("focus");
    $(this).parent().addClass("focus-box");
  });
  $(".login-form input").on("blur", function () {
    if ($(this).val() == "") {
      $(this).removeClass("focus");
      $(this).parent().removeClass("focus-box");
    }
  });
  if ($("#navbar").hasClass("navbar-mobile")) {
    console.log("활성화");
    $(".mobile-nav-toggle").css("display", "block");
  }
});
