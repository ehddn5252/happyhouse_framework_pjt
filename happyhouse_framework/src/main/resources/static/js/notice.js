$(document).ready(function () {

	  
  var notices = JSON.parse(localStorage.getItem("notices"));
    // 공지 제목 누르면 폼이 활성화됨
  $(".notice-title").click(function () {
	  console.log("실행!!!")
    //   기존 리스트 안보임
    $(".notice-list-box-toggle").toggleClass("d-none");
    $(".notice-form").toggleClass("d-none");
  });

  // 수정 누르면 수정 활성화
  $(".modify-check-nocice-btn").click(function () {
    if (modify()) {
      $(".notice-form input,textarea").attr("disabled", true);
      $(".after-modify").toggleClass("d-none");
      $(".before-modify").toggleClass("d-none");
    }
  });

  $(".modify-nocice-btn").click(function () {
	  $(".notice-form input,textarea").removeAttr("disabled");
	  $(".after-modify").toggleClass("d-none");
      $(".before-modify").toggleClass("d-none");
  });
  $(".delete-nocice-btn").click(function () {
    deleteNotice();
    
  });
});

function modify() {
	 
  // 문서에서 id 로 input data 가져오기
  var list = ["title", "content"];
  var notice = new Object();
  var noticeID = document.getElementById("notice-idx").innerHTML;
  console.log(noticeID+ "ZZZZZZZZ");
  var title = $("#addNotice-title").val();
  var content = $("#addNotice-content").val();
  
  for (let key of list) {
    var value = document.querySelector(`#addNotice-${key}`).value;
    if (!value) {
      alert("빈칸이 없도록 입력해주세요.");
      return false;
    } else {
      notice[key] = value;
    }
  }
  $.ajax({ 
	  url:`NoticeMain2`, 
	  type:"GET", 
	  data:{
		  act:"Noticeupdate",
		  noticeID:noticeID,
		  noticeTitle:title,
		  noticeContent:content
	  }, 
	  success: function(response){ 
		  //alert(window.location.pathname);
		  alert("공지 수정 성공!");
		  location.href = "NoticeMain2?act=selectAll";
		  
	  }
  })
  
  return true;
}

function addNotice() {
  var list = ["title", "content"];
  var noticeArr = new Array();
  var notice = new Object();
  
  $(".notice-list-box-toggle").toggleClass("d-none");
  $(".notice-form").toggleClass("d-none");
  
  for (let key of list) {
    let value = document.getElementById(`addNotice-${key}`).value;
    if (!value) {
      alert("빈칸이 없도록 입력해주세요.");
      return;
    } else {
      notice[key] = value;
    }
  }
  
  notice.view = 0;
  noticeArr.push(notice);
 
 
  $.ajax({ 
	  url:`NoticeMain2?act=Noticeinsert&noticeTitle=${notice["title"]}&noticeContent=${notice["content"]}&userID=3`, 
	  type:"GET", 
	  data:{
		  
	  }, 
	  success: function(response){ 
		  alert("공지 등록 성공!");
		  location.href='NoticeMain2?act=selectAll';
		  
		  }
  })
}

// 공지 삭제
function deleteNotice() {
  const notices = JSON.parse(localStorage.getItem("notices"));

  const idx = document.getElementById("notice-idx").innerHTML;
  $.ajax({ 
	  url:`NoticeMain2?act=Noticedelete&noticeID=${idx}`, 
	  type:"GET", 
	  data:{
		  
	  }, 
	  success: function(response){
		  alert("공지 삭제 완료!");
		  location.href = "NoticeMain2?act=selectAll";
		  
	  }
  })

  localStorage.setItem("notices", JSON.stringify(notices));
  
}
