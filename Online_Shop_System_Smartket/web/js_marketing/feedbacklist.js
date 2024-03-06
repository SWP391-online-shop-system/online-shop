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


// Gọi hàm convertLastLoginToTimeFromNow() khi trang được tải
window.onload = function () {
//    convertLastLoginToTimeFromNow();
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
