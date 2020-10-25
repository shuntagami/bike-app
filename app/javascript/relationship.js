function relationship() {
  const button = document.getElementById(`follow_button_${gon.user_id}`);
  button.addEventListener("click", () => {
    const XHR = new XMLHttpRequest();
    XHR.open("POST", `/users/${gon.user_id}/relationships`, true);
    XHR.responseType = "json";
    XHR.send();
  });
}
document.addEventListener("DOMContentLoaded", relationship);



