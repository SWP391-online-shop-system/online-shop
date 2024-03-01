let rangeInput = document.querySelectorAll('.range-input input');
let rangeText = document.querySelectorAll('.range-text div');
let progress1 = document.querySelector('.progress1');
let priceMax = rangeInput[0].max;
let priceGap = 20000;

rangeInput.forEach(input => {
    input.addEventListener('input', (event) => {
        let minVal = parseInt(rangeInput[0].value);
        let maxVal = parseInt(rangeInput[1].value);

        if (maxVal - minVal < priceGap) {
            if (event.target.className === 'range-min') {
                minVal = rangeInput[0].value = maxVal - priceGap;
            } else {
                maxVal = rangeInput[1].value = minVal + priceGap;
            }
        }

        let positionMin = (minVal / priceMax) * 100;
        let positionMax = 100 - ((maxVal / priceMax) * 1000);
        rangeText[0].innerText = minVal.toLocaleString();
        rangeText[1].innerText = maxVal.toLocaleString();
    });
});
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
                timer: 1500
            });
            console.log(countCart);
            $('#countCart').text(countCart);
        },
        error: function (xhr, status, error) {
            // Xử lý lỗi
            console.error(xhr.responseText);
        }
    });
}
    