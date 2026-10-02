const formStatus = document.querySelector("#form-status");

document.querySelector("#year").textContent = new Date().getFullYear();

if (new URLSearchParams(window.location.search).get("submitted") === "true") {
  formStatus.textContent = "상담 신청이 완료되었습니다. 확인 후 연락드리겠습니다.";
}