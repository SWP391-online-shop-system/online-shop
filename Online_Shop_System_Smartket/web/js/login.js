// login.js

document.querySelector("#show-login").addEventListener("click", function () {
    document.querySelector(".popup").classList.add("active");
});

document.querySelector(".popup .close-btn").addEventListener("click", function () {
    document.querySelector(".popup").classList.remove("active");
});

//document.querySelector("#showSignup").addEventListener("click", function () {
//    document.querySelector("#signupPopup").classList.add("active");
//    document.querySelector(".popup").classList.remove("active");
//});
// document.querySelector("#signupPopup .close-btn").addEventListener("click", function () {
//    document.querySelector("#signupPopup").classList.remove("active");
//});



document.querySelector("#showSignup").addEventListener("click", function () {
  document.querySelector("#signupPopup").classList.add("active");
});
 document.querySelector("#signupPopup .close-btn").addEventListener("click", function () {
  document.querySelector("#signupPopup").classList.remove("active");
});