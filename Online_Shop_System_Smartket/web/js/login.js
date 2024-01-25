document.querySelector("#show-login").addEventListener("click", function () {
    document.querySelector(".popup").classList.add("active");
    document.querySelector("#signupPopup").classList.remove("active");
});

document.querySelector(".popup .close-btn").addEventListener("click", function () {
    document.querySelector(".popup").classList.remove("active");
});

document.querySelector("#showSignup").addEventListener("click", function (event) {
    // Show the signupPopup
    document.querySelector("#signupPopup").classList.add("active");
    document.querySelector(".popup").classList.remove("active");
    // Prevent the default behavior of the anchor element
    event.preventDefault();
});

document.querySelector("#signupPopup .close-btn").addEventListener("click", function () {
    // Close the signupPopup
    document.querySelector("#signupPopup").classList.remove("active");
});
document.querySelector("#loginAfterRegister").addEventListener("click", function () {
    document.querySelector(".popup").classList.add("active");
    document.querySelector("#signupPopup").classList.remove("active");
});


