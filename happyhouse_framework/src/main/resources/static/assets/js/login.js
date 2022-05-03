function login() {
  // 문서에서 id로 input data 가져오기
  let id = document.getElementById("id").value;
  let password = document.getElementById("password").value;

  // 로컬스토리지에 "user" 키로 저장된 item 가져와서 json 객체로 만들기
  const users = JSON.parse(localStorage.getItem("users"));
  // 입력값 검증 (여러 회원 정보들 중에 사용자의 아이디와 비밀번호가 존재하면 로그인 성공)
  for (let user of users) {
    if (user["id"] == id && user["password"] == password) {
      alert("로그인 성공 !");
      localStorage.setItem("checkLogin", true);
      let userA = {
        id: id,
        password: password,
        name: user["name"],
        email: user["email"],
        age: user["age"],
      };
      localStorage.setItem("user", JSON.stringify(userA));
      location.replace("index.html"); //다시 확인
      return;
      // 로그인 성공하면 index 페이지로 이동.
    }
  }
  alert("로그인 실패 !");
}

function logout() {
  localStorage.removeItem("user");
  localStorage.removeItem("checkLogin");
  location.replace("index.html");
  alert("로그아웃!");
}

function findPwd() {
  const users = JSON.parse(localStorage.getItem("users"));
  // 입력값 검증 (여러 회원 정보들 중에 사용자의 아이디와 비밀번호가 존재하면 로그인 성공)
  let id = document.getElementById("findPwd-id").value;
  for (let user of users) {
    if (user["id"] == id) {
      let pwdPrint = `<p>${user["name"]}님의 비밀번호는 <b>${user["password"]}</b> 입니다.</p>`;
      $("#printPwd").empty().append(pwdPrint);
      return;
    }
    console.log(user["password"]);
  }
  let pwdPrint = `<p>해당 아이디가 존재하지 않습니다.</p>`;
  console.log("없음");
  $("#printPwd").empty().append(pwdPrint);
}
