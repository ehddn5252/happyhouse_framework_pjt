$(document).ready(function () {

  $('#moveInterest').click(function () {
    location.href="interest.html";
});


  $('#registerInterestBtn').click(function () {
    console.log("hhh");
    //var list = ["city", "gu", "dong"];
    var list = ["sido", "sigugun", "dong"];
    var interestArr = new Array();
    var interest = new Object();
    for (let key of list) {
      //let value = document.getElementById(`interest-${key}`).value;
      let value = document.getElementById(`${key}`);
      
      console.log($(`#${key} option:checked`).text());
      
      if (!value) {
        alert("빈칸이 없도록 입력해주세요.");
        return;
      } else {
        interest[key] = $(`#${key} option:checked`).text();
      }
    }
    interestArr.push(interest);
    if (localStorage.getItem("interest") != null) {
      let origin = JSON.parse(localStorage.getItem("interest"));
      localStorage.setItem("interest", JSON.stringify(origin.concat(interestArr)));
    } else {
      localStorage.setItem("interest", JSON.stringify(interestArr));
    }
    
    // interest 객체 문자열로 바꿔서 로컬스토리지에 저장
    alert("관심 등록 완료~");
    // location.href = "interest.html"; 
  });
});
