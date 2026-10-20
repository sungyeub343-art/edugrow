const formStatus = document.querySelector("#form-status");
const regionDialog = document.querySelector("#region-dialog");
const regionDialogClose = regionDialog.querySelector(".region-dialog-close");

document.querySelector("#year").textContent = new Date().getFullYear();

if (new URLSearchParams(window.location.search).get("submitted") === "true") {
  formStatus.textContent = "상담 신청이 완료되었습니다. 확인 후 연락드리겠습니다.";
}

const regionDialogSeenKey = "regionDialogSeen";
let regionDialogSeen = false;

try {
  regionDialogSeen = sessionStorage.getItem(regionDialogSeenKey) === "true";
  sessionStorage.setItem(regionDialogSeenKey, "true");
} catch (error) {
  // 저장소를 쓸 수 없으면 매번 표시
}

if (!regionDialogSeen) {
  regionDialog.showModal();
  document.body.classList.add("modal-open");
}

regionDialogClose.addEventListener("click", () => regionDialog.close());

regionDialog.addEventListener("click", (event) => {
  if (event.target === regionDialog) {
    regionDialog.close();
  }
});

regionDialog.addEventListener("close", () => {
  document.body.classList.remove("modal-open");
});