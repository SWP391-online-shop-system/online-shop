/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
$(document).ready(function () {
    $('#dataTable').DataTable(); // ID From dataTable 
    $('#dataTableHover').DataTable({
        columns: [
            {searchable: false},
            {searchable: true},
            {searchable: true},
            {searchable: false},
            {searchable: true},
            {searchable: false},
            {searchable: false}],
        search: {
            placeholder: 'Type search here'
        }
    }); // ID From dataTable with Hover
});
function userDetails(uid) {
    var url = "userDetails?uid="+uid;
    window.location.href = url;
}
function Customerdetail(uid) {
    var url = "marketingCustomerDetail?uid="+uid;
    window.location.href = url;
}
function convertLastLoginToTimeFromNow() {
    var lastLoginElements = document.querySelectorAll("#dataTableHover tbody tr td:last-child");
    lastLoginElements.forEach(function (element) {
        var lastLogin = element.textContent;
        var lastLoginTime = new Date(lastLogin);
        var timeFromNow = getTimeFromNow(lastLoginTime);
        element.textContent = timeFromNow;
    });
}

function getTimeFromNow(date) {
    var now = new Date();
    var diff = now.getTime() - date.getTime();
    var seconds = Math.floor(diff / 1000);
    var minutes = Math.floor(seconds / 60);
    var hours = Math.floor(minutes / 60);
    var days = Math.floor(hours / 24);

    if (days > 0) {
        return days + " ngày trước";
    } else if (hours > 0) {
        return hours + " giờ trước";
    } else if (minutes > 0) {
        return minutes + " phút trước";
    } else if (seconds > 0) {
        return "vừa xong";
    } else {
        return "N/A";
    }
}

// Gọi hàm convertLastLoginToTimeFromNow() khi trang được tải
window.onload = function () {
    convertLastLoginToTimeFromNow();
};
function validateInput(input) {
    if (input.validity.valid) {
        input.classList.remove('is-invalid');
        input.classList.add('is-valid');
    } else {
        input.classList.add('is-invalid');
        input.classList.remove('is-valid');
    }
}
function validatePasswordMatch(input) {
    var password = document.getElementById("registerPassword").value;
    var confirmPassword = document.getElementById("registerPasswordConfirm").value;
    var mismatchMessage = document.getElementById("passwordMismatch");
    if (password === confirmPassword) {
        mismatchMessage.style.display = 'none';
        document.getElementById("registerPasswordConfirm").setCustomValidity('');
    } else {
        mismatchMessage.style.display = 'block';
        document.getElementById("registerPasswordConfirm").setCustomValidity('Mật khẩu không khớp');
    }
    validateInput(input);
}
