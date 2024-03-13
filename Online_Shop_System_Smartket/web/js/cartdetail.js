function formatPriceToVND(price) {
    let formattedPrice = price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    formattedPrice += "đ";
    return formattedPrice;
}

function changeValue(element) {
    var inputElement = element.parentElement.querySelector('input');
    var value = parseInt(inputElement.value, 10);
    value = isNaN(value) ? 1 : value;
    value <= 1 ? value = 1 : value;
    inputElement.value = value;
    updatePriceDisplayPlus(inputElement);
}
function increaseValue(element, proId) {
    var inputElement = element.parentElement.querySelector('input');
    var value = parseInt(inputElement.value, 10);
    value = isNaN(value) ? 0 : value;
    value++;
    inputElement.value = value;
    updatePriceDisplayPlus(inputElement);
    updatePriceToDb(proId, value);
}

function decreaseValue(element, proId) {
    var inputElement = element.parentElement.querySelector('input');
    var value = parseInt(inputElement.value, 10);
    value = isNaN(value) ? 1 : value;
    value <= 1 ? value = 1 : value--;
    inputElement.value = value;
    updatePriceDisplayPlus(inputElement);
    updatePriceToDb(proId, value);
}
function updatePriceToDb(proId, quantity) {
    $.ajax({
        type: "POST",
        url: "/Smartket/updateProduct",
        data: {service: "increase", proId: proId, quantity: quantity},
        success: function (response) {
        },
        error: function (xhr, status, error) {
            // Xử lý lỗi
            console.error(xhr.responseText);
        }
    });
}
function updatePriceDisplayPlus(inputElement) {
    var count = inputElement.getAttribute('data-count');
    var priceDisplayElement = document.getElementById('priceDisplay' + count);
    var unitPrice = parseFloat(priceDisplayElement.getAttribute('data-unit-price'));
    var newPrice = parseFloat(inputElement.value) * unitPrice;
    priceDisplayElement.innerText = formatPriceToVND(newPrice);
}
function updatePriceDisplayNeg(inputElement) {
    var count = inputElement.getAttribute('data-count');
    var priceDisplayElement = document.getElementById('priceDisplay' + count);
    var unitPrice = parseFloat(priceDisplayElement.getAttribute('data-unit-price'));
    var quantity = parseFloat(inputElement.value);
    var newPrice = unitPrice / quantity;
    priceDisplayElement.innerText = formatPriceToVND(newPrice);
}
function updateTotalPrice() {
    var count1 = document.getElementsByClassName("gett");
    var result = 0;
    for (let i = 0; i < count1.length; i++) {
        var id = document.getElementById("id" + (i + 1));
        if (id.checked) {
            result += (parseInt(count1[i].innerHTML.slice(0, -1).replaceAll(",", "")));
        }
    }
    var rs = document.getElementById("realTotal");
    rs.innerText = formatPriceToVND(result);
}
document.getElementById('select-all').addEventListener('change', function () {
    var checkboxes = document.querySelectorAll('.checkbox-item');
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = this.checked;
    }
});
var checkboxes = document.querySelectorAll('input[type="checkbox"][name="productToBuy"]');
var deletelink = document.getElementById("deletelink");
var totalPrice = document.getElementById("totalPrice");

function countChecked() {
    var checkedCount = 0;
    checkboxes.forEach(function (checkbox) {
        if (checkbox.checked) {
            checkedCount++;
        }

    });
    deletelink.innerHTML = '<i class="fa fa-trash"></i>&nbsp;Xóa(' + checkedCount + ')';
    totalPrice.innerHTML = 'Tổng đơn hàng (' + checkedCount + '):<span style="margin-left:10px" id="realTotal"></span>';
    updateTotalPrice();
}
document.getElementById('select-all').addEventListener('change', function () {
    var checkboxes = document.querySelectorAll('.checkbox-item');
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = this.checked;
    }
    countChecked();
    updateTotalPrice();
});
checkboxes.forEach(function (checkbox) {
    checkbox.addEventListener('change', countChecked);
    updateTotalPrice();
});
countChecked();
updateTotalPrice();
function confirmDeleteAll() {
    swal.fire({
        title: 'Bạn có chắc chắn?',
        text: "Bạn có muốn tiếp tục không?",
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Có',
        cancelButtonText: 'Không'
    }).then((result) => {
        if (result.isConfirmed) {
            deleteCart();
        } else if (result.dismiss === swal.DismissReason.cancel) {
        }
    });
}
function deleteCart() {
    var proId = document.querySelectorAll('.checkbox-item:checked');
    var values = [];
    proId.forEach(function (node) {
        values.push(node.value);
    });
    $.ajax({
        type: "post",
        url: "/Smartket/CartURL",
        data: {service: "deleteAllCart", proId: values.join(",")},
        success: function (response) {
            if (response === "1") {
                swal.fire({
                    icon: 'success',
                    title: 'Thành công!',
                    text: 'Đã xóa thành công',
                    showConfirmButton: false,
                    timer: 1500
                });
                setTimeout(function () {
                    window.location.href = "CartURL";
                }, 1000);
            } else {
                swal.fire({
                    icon: 'error',
                    title: 'Không thành công!',
                    text: 'Chọn sản phẩm để xóa',
                    showConfirmButton: false,
                    timer: 1000
                });
            }
        },
        error: function (xhr, status, error) {
            // Xử lý lỗi
            console.error(xhr.responseText);
        }
    });
}
function checkOut() {
    var proId = document.querySelectorAll('.checkbox-item:checked');
    var values = [];
    proId.forEach(function (node) {
        values.push(node.value);
    });
    console.log(values.join("."));
    $.ajax({
        type: "post",
        url: "/Smartket/AddCookie",
        data: {proId: values.join(".")},
        success: function (response) {
            if (response === "1") {
                window.location.href = "contactURL";
            } else {
                swal.fire({
                    icon: 'error',
                    title: 'Không thành công!',
                    text: 'Chọn sản phẩm để thực hiện đặt hàng',
                    showConfirmButton: false,
                    timer: 1000
                });
            }
        },
        error: function (xhr, status, error) {
            // Xử lý lỗi
            console.error(xhr.responseText);
        }
    });
}
function addToCart(pId) {
    $.ajax({
        type: "POST",
        url: "CartURL",
        data: {service: "addcart", pid: pId},
        success: function (response) {
            // Hiển thị thông báo cho người dùng
            var countCart = response;
            swal.fire({
                icon: 'success',
                title: 'Thành công!',
                text: 'Sản phẩm đã được thêm vào giỏ hàng.',
                showConfirmButton: false,
                timer: 1000
            });
            $('#countCart').text(countCart);
        },
        error: function (xhr, status, error) {
            // Xử lý lỗi
            console.error(xhr.responseText);
        }
    });
}