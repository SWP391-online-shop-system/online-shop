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
    var gender = document.querySelector('input[name="newGender"]:checked').value;
    var city = document.getElementById("city").value;
    var district = document.getElementById("district").value;
    var ward = document.getElementById("ward").value;
    var addressDetail = document.getElementById("newAddressDetail").value;
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
            var modalBody = document.querySelector('#DS .modal-body');
            modalBody.innerHTML += response;
        },
        error: function (xhr, status, error) {
            // Xử lý lỗi
            console.error(xhr.responseText);
        }
    });
}
function showOneAdd(addId){
    
    $.ajax({
        type: "POST",
        url: "contactURL",
        data: {service: "showOneAdd",addId : addId},
        success: function (response) {
            console.log(response);
            var modalBody = document.querySelector('#update .modal-body');
            modalBody.innerHTML += response;
        },
        error: function (xhr, status, error) {
            // Xử lý lỗi
            console.error(xhr.responseText);
        }
    });
}
//function updateAddress() {
//    var city = document.getElementById("city").value;
//    var district = document.getElementById("district").value;
//    var ward = document.getElementById("ward").value;
//    var addressDetail = city + ', ' + district + ', ' + ward;
//    document.getElementById("exampleInputPassword1").value = addressDetail;
//}