function regist() {
  var list = ["id", "password", "name", "email", "age"];
  var userArr = new Array();
  var user = new Object();

  for (let key of list) {
    let value = document.getElementById(`signup-${key}`).value;
    if (!value) {
      alert("빈칸이 없도록 입력해주세요.");
      return;
    } else {
      user[key] = value;
    }
  }
  userArr.push(user);

  if (localStorage.getItem("users") != null) {
    let origin = JSON.parse(localStorage.getItem("users"));
    localStorage.setItem("users", JSON.stringify(origin.concat(userArr)));
  } else {
    localStorage.setItem("users", JSON.stringify(userArr));
  }

  //기존에 저장되어 있던 회원 정보에 추가

  // user 객체 문자열로 바꿔서 로컬스토리지에 저장
  alert("사용자 등록 성공!");
  // 로그인 화면으로 돌아가기
  location.href = "index.html"; // 다시 확인
}
