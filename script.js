const regionDialog = document.querySelector("#region-dialog");
const regionDialogClose = regionDialog.querySelector(".region-dialog-close");

document.querySelector("#year").textContent = new Date().getFullYear();

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