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
    	console.log("!!!!!!!!!!!")
    	
//      $(".notice-form input,textarea").attr("disabled", true);
//      $(".after-modify").toggleClass("d-none");
//      $(".before-modify").toggleClass("d-none");

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
  
  var noticeID = document.getElementById("notice-idx").innerHTML;
  console.log(noticeID+ "ZZZZZZZZ");
  var title = $("#addNotice-title").val();
  var content = $("#addNotice-content").val();
  
  
  
  
  
  console.log(title)
 let noticeinfo = {
		'noticeID':noticeID,
		'noticeTitle': title,
		'noticeContent': content
	   };
	console.log(noticeinfo)
	console.log("============")
	
	
	
  $.ajax({
  	url: '/notice',
    	type: 'PUT',
    	dataType: 'text',
  	data: noticeinfo,
    	success: function (response) {
    		
    		location.href = "/notice";
      	//$("#msg").text(response.msg).removeClass('text-dark');
    	},
    	error: function (error) {
    		console.log("error입니",error)
    		/* request.setAttribute("msg", "글목록 얻기중 에러가 발생했습니다.");
			request.getRequestÏDispatcher("/error/error.jsp").forward(request, response); */
    	}
	});
  
  return false;
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
