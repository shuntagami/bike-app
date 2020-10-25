function relationship() {
  const buttons = document.querySelectorAll(".follow_btn");
  buttons.forEach(function (button) {
    button.addEventListener("click", () => {
      const userId = button.getAttribute("data-id");
      const XHR = new XMLHttpRequest();
      XHR.open("POST", `/users/${userId}/relationships`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
       if (XHR.status != 200) {
         alert(`Error ${XHR.status}: ${XHR.statusText}`);
         return null;
       }
      };
    });
  });
}
document.addEventListener("DOMContentLoaded", relationship);



