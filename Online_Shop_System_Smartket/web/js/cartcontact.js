var citis = document.getElementById("city");
var districts = document.getElementById("district");
var wards = document.getElementById("ward");
var Parameter = {
    url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
    method: "GET",
    responseType: "json"
};
var promise = axios(Parameter);
promise.then(function (result) {
    renderCity(result.data);
});

function renderCity(data) {
    for (const x of data) {
//        citis.options[citis.options.length] = new Option(x.Name, x.Id);
        var opt = document.createElement('option');
        opt.value = x.Name; // Sử dụng tên của tỉnh làm giá trị của phần tử <option>
        opt.text = x.Name;
        opt.setAttribute('data-id', x.Id);
        citis.options.add(opt);
    }
    citis.onchange = function () {
        district.length = 1;
        ward.length = 1;
        if (this.value != "") {
            const result = data.filter(n => n.Name === this.value);

            for (const k of result[0].Districts) {
//                district.options[district.options.length] = new Option(k.Name, k.Id);
                var opt = document.createElement('option');
                opt.value = k.Name; // Sử dụng tên của quận/huyện làm giá trị của phần tử <option>
                opt.text = k.Name;
                opt.setAttribute('data-id', k.Id);
                districts.options.add(opt);
            }
        }
    };
    district.onchange = function () {
        ward.length = 1;
        const dataCity = data.filter((n) => n.Name === citis.value);
        if (this.value != "") {
            const dataWards = dataCity[0].Districts.filter(n => n.Name === this.value)[0].Wards;

            for (const w of dataWards) {
//                wards.options[wards.options.length] = new Option(w.Name, w.Id);
                var opt = document.createElement('option');
                opt.value = w.Name; // Sử dụng tên của phường/xã làm giá trị của phần tử <option>
                opt.text = w.Name;
                opt.setAttribute('data-id', w.Id);
                wards.options.add(opt);
            }
        }
    };
}

function back() {
    window.history.back();
}
;
function addNewAdd() {
    var name = document.getElementById("newName").value;
    var phone = document.getElementById("newPhone").value;
    var email = document.getElementById("newEmail").value;
    var gender_check = document.querySelector('input[name="newGender"]:checked');
    var city = document.getElementById("city").value;
    var district = document.getElementById("district").value;
    var ward = document.getElementById("ward").value;
    var addressDetail = document.getElementById("newAddressDetail").value;
    if (name === "" || phone === "" || email === "" || city === "" || district === "" || ward === "" || addressDetail === "" || gender_check === null) {
        swal.fire({
            icon: 'error',
            title: 'Không thành công!',
            text: 'Vui lòng điền đầy đủ thông tin',
            showConfirmButton: false,
            timer: 1500
        });
    } else {
        var gender = document.querySelector('input[name="newGender"]:checked').value;
        $.ajax({
            type: "POST",
            url: "contactURL",
            data: {service: "addAddress", name: name, phone: phone, email: email, gender: gender, city: city, district: district, ward: ward, addressDetail: addressDetail},
            success: function (response) {
                console.log(response);
                swal.fire({
                    icon: 'success',
                    title: 'Thành công!',
                    text: 'Thêm địa chỉ thành công',
                    showConfirmButton: false,
                    timer: 1500
                });
                setTimeout(function () {
                        window.location.href = "contactURL?update=show";
                    }, 600);
                var modalBody = document.querySelector('#DS .modal-body');
                modalBody.innerHTML += response;
            },
            error: function (xhr, status, error) {
                // Xử lý lỗi
                console.error(xhr.responseText);
            }
        });
    }
}
function validateInput(input) {
    if (input.validity.valid) {
        input.classList.remove('is-invalid');
        input.classList.add('is-valid');
    } else {
        input.classList.add('is-invalid');
        input.classList.remove('is-valid');
    }
}
function showOneAdd(element) {
//    $('#DS').modal('hide');
    var inputContent = element.parentNode.querySelector('input');
    $.ajax({
        type: "POST",
        url: "contactURL",
        data: {service: "showOneAdd", addId: inputContent.value},
        success: function (response) {
            $('#update').modal('show');
            $('#updateContent').html(response);
            getRenderCity();
        },
        error: function (xhr, status, error) {
            // Xử lý lỗi
            console.error(xhr.responseText);
        }
    });
}
function deleteAdd(element) {
    console.log("js in");
    var inputContent = element.parentNode.querySelector('input');
    swal.fire({
        title: 'Bạn có chắc chắn?',
        text: "Bạn có muốn tiếp tục không?",
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Có',
        cancelButtonText: 'Không'
    }).then((result) => {
        if (result.isConfirmed) {
            console.log("yes");
            $.ajax({
                type: "POST",
                url: "contactURL",
                data: {service: "deleteAdd", addId: inputContent.value},
                success: function (response) {
                    swal.fire({
                        icon: 'success',
                        title: 'Thành công!',
                        text: 'Xóa địa chỉ thành công',
                        showConfirmButton: false,
                        timer: 1500
                    });
                    setTimeout(function () {
                        window.location.href = "contactURL?update=show";
                    }, 500);
//            $('#update').modal('show');
//            $('#updateContent').html(response);
                },
                error: function (xhr, status, error) {
                    console.error(xhr.responseText);
                }
            });
        } else if (result.dismiss === swal.DismissReason.cancel) {
            console.log("no");
        }
    });
}
function updateAddress() {
    var id = document.getElementById("addIdUpdate").value;
    var name = document.getElementById("updateName").value;
    var phone = document.getElementById("updatePhone").value;
    var email = document.getElementById("updateEmail").value;
    var gender_check = document.querySelector('input[name="updategender"]:checked');
    var city = document.getElementById("city1").value;
    var district = document.getElementById("district1").value;
    var ward = document.getElementById("ward1").value;
    var addressDetail = document.getElementById("updateAddressDetail").value;
    console.log(id);
    console.log(name);
    console.log(phone);
    console.log(email);
    console.log(gender_check);
    console.log(city);
    console.log(district);
    console.log(ward);
    console.log(addressDetail);
    if (name === "" || phone === "" || email === "" || city === "" || district === "" || ward === "" || addressDetail === "" || gender_check === null) {
        swal.fire({
            icon: 'error',
            title: 'Không thành công!',
            text: 'Vui lòng điền đầy đủ thông tin',
            showConfirmButton: false,
            timer: 1500
        });
    } else {
        var gender = document.querySelector('input[name="updategender"]:checked').value;
        $.ajax({
            type: "POST",
            url: "contactURL",
            data: {service: "updateAdd", addId: id, name: name, phone: phone, email: email, gender: gender, city: city, district: district, ward: ward, addressDetail: addressDetail},
            success: function (response) {

                swal.fire({
                    icon: 'success',
                    title: 'Thành công!',
                    text: 'Cập nhật địa chỉ thành công',
                    showConfirmButton: false,
                    timer: 1500
                });
                setTimeout(function () {
                    window.location.href = "contactURL?update=show";
                }, 500);
            },
            error: function (xhr, status, error) {
                // Xử lý lỗi
                console.error(xhr.responseText);
            }
        });
    }
}
function getRenderCity() {
    var Parameter1 = {
        url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
        method: "GET",
        responseType: "json"
    };
    var promise1 = axios(Parameter1);
    promise1.then(function (result) {
        renderCity1(result.data);
    });
}

function renderCity1(data) {
    var citis1 = document.getElementById("city1");
    var districts1 = document.getElementById("district1");
    var wards1 = document.getElementById("ward1");
    console.log("resndercity");
    for (const x of data) {
//        citis.options[citis.options.length] = new Option(x.Name, x.Id);
        var opt = document.createElement('option');
        opt.value = x.Name; // Sử dụng tên của tỉnh làm giá trị của phần tử <option>
        opt.text = x.Name;
        opt.setAttribute('data-id', x.Id);
        citis1.options.add(opt);
    }
    citis1.onchange = function () {
        district1.length = 1;
        ward1.length = 1;
        if (this.value != "") {
            const result = data.filter(n => n.Name === this.value);

            for (const k of result[0].Districts) {
//                district.options[district.options.length] = new Option(k.Name, k.Id);
                var opt = document.createElement('option');
                opt.value = k.Name; // Sử dụng tên của quận/huyện làm giá trị của phần tử <option>
                opt.text = k.Name;
                opt.setAttribute('data-id', k.Id);
                districts1.options.add(opt);
            }
        }
    };
    district1.onchange = function () {
        ward1.length = 1;
        const dataCity = data.filter((n) => n.Name === citis1.value);
        if (this.value != "") {
            const dataWards = dataCity[0].Districts.filter(n => n.Name === this.value)[0].Wards;

            for (const w of dataWards) {
//                wards.options[wards.options.length] = new Option(w.Name, w.Id);
                var opt = document.createElement('option');
                opt.value = w.Name; // Sử dụng tên của phường/xã làm giá trị của phần tử <option>
                opt.text = w.Name;
                opt.setAttribute('data-id', w.Id);
                wards1.options.add(opt);
            }
        }
    };
}
document.getElementById("formUpdate").addEventListener("submit", function (event) {
    var updateName = document.getElementById("updateName").value;
    var updatePhone = document.getElementById("updatePhone").value;
    var updateEmail = document.getElementById("updateEmail").value;
    var updateMale = document.getElementById("updateMale").value;
    var updateFeMale = document.getElementById("updateFeMale").value;
    var city1 = document.getElementById("city1").value;
    var district1 = document.getElementById("district1").value;
    var ward1 = document.getElementById("ward1").value;
    var updateAddressDetail = document.getElementById("updateAddressDetail").value;

    // Kiểm tra điều kiện của các trường input
    if (updateName === "" || updatePhone === "" || updateEmail === "" || (updateMale === "" && updateFeMale === "") || city1 === "" || district1 === "" || ward1 === "" || updateAddressDetail === "") {
        alert("Vui lòng điền đầy đủ thông tin.");
        event.preventDefault(); // Ngăn chặn việc gửi form
    } else {
        // Nếu các trường input đã được điền đầy đủ, cho phép gửi form và quay lại modal 1
        $('#update').modal('hide');
        $('#DS').modal('show');
    }
});
function saveAdd() {
    var defaultAdd = document.querySelectorAll(".defaultAdd");
    var service = "saveAdd";
    var addId = null;

    defaultAdd.forEach(function (input) {
        if (input.checked) {
            addId = input.value;
        }
    });
    if (addId === null) {
        swal.fire({
            icon: 'error',
            title: 'Thất bại',
            text: 'Bạn cần chọn địa chỉ',
            showConfirmButton: false,
            timer: 1500
        });
    } else {
        $.ajax({
            type: "POST",
            url: "/Smartket/contactURL",
            data: {service: service, addId: addId},
            success: function (response) {
                swal.fire({
                    icon: 'success',
                    title: 'Thành công!',
                    text: 'Chọn địa chỉ thành công',
                    showConfirmButton: false,
                    timer: 1500
                });
                setTimeout(function () {
                    window.location.href = "contactURL";
                }, 1000);

            },
            error: function (xhr, status, error) {
                // Xử lý lỗi
                console.error(xhr.responseText);
            }
        });
    }
}
