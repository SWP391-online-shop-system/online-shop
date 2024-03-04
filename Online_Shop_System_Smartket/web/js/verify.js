/* global otpValue */

const inputs = document.querySelectorAll(".otp-field > input");
const button = document.querySelector(".btn");

window.addEventListener("load", () => inputs[0].focus());
button.setAttribute("disabled", "disabled");

inputs[0].addEventListener("paste", function (event) {
    event.preventDefault();

    const pastedValue = (event.clipboardData || window.clipboardData).getData(
            "text"
            );
    const otpLength = inputs.length;

    for (let i = 0; i < otpLength; i++) {
        if (i < pastedValue.length) {
            inputs[i].value = pastedValue[i];
            inputs[i].removeAttribute("disabled");
            inputs[i].focus;
        } else {
            inputs[i].value = ""; // Clear any remaining inputs
            inputs[i].focus;
        }
    }
});

inputs.forEach((input, index1) => {
    input.addEventListener("keyup", (e) => {
        const currentInput = input;
        const nextInput = input.nextElementSibling;
        const prevInput = input.previousElementSibling;

        if (currentInput.value.length > 1) {
            currentInput.value = "";
            return;
        }

        if (
                nextInput &&
                nextInput.hasAttribute("disabled") &&
                currentInput.value !== ""
                ) {
            nextInput.removeAttribute("disabled");
            nextInput.focus();
        }

        if (e.key === "Backspace") {
            inputs.forEach((input, index2) => {
                if (index1 <= index2 && prevInput) {
                    input.setAttribute("disabled", true);
                    input.value = "";
                    prevInput.focus();
                }
            });
        }

        button.classList.remove("active");
        button.setAttribute("disabled", "disabled");

        const inputsNo = inputs.length;
        if (!inputs[inputsNo - 1].disabled && inputs[inputsNo - 1].value !== "") {
            button.classList.add("active");
            button.removeAttribute("disabled");

            return;
        }
    });
});

function verifyOTP() {
     var otp1 = document.getElementById("otp1").value;
     var otp2 = document.getElementById("otp2").value;
     var otp3 = document.getElementById("otp3").value;
     var otp4 = document.getElementById("otp4").value;
     var otp5 = document.getElementById("otp5").value;
     var otp6 = document.getElementById("otp6").value;
    $.ajax({
        type: "POST",
        url: "CartcontactOTPVerify",
        data: {service: "verify", otpValues: otp1+otp2+otp3+otp4+otp5+otp6},
        success: function (response) {
            // Hiển thị thông báo cho người dùng
            if (response.trim() === "Đã xác nhận thành công") {
                swal.fire({
                    icon: 'success',
                    title: 'Thành công!',
                    text: response,
                    showConfirmButton: true
                 }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = "BankingInfo"; 
                    }
                });
            } else {
                swal.fire({
                    icon: 'error',
                    title: 'Lỗi!',
                    text: response,
                    showConfirmButton: true
                });
            }
            console.log(response);
        },
        error: function (xhr, status, error) {
            // Xử lý lỗi
            console.error(xhr.responseText);
        }
    });
}
;