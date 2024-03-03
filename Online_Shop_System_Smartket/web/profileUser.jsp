<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/homestyle.css"/>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page import="model.*" %>
        <%@page import="java.util.Vector" %>
        <%@page import="view.*" %>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.text.DecimalFormat" %>
        <!DOCTYPE html> 
   
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="css/css_footer/footer.css"/>
    <link rel="stylesheet" href="css/css_header/header.css"/>
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="css/ruang-admin.min.css" rel="stylesheet">
    <link href="vendor/bootstrap/css/bootstrap.min.css"/>
    <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
     <style>
        body{
            margin: 5px -5px;
        }
        a{
            color: black;
            text-decoration: none;
        }
        .input-change{
            width: 223px;
        }
        label{
            margin-top: 19px;
            margin-left: -93px;
        }
        .btn-submitform{
            margin-top: 15px;
            /* float: right; */
            padding: 7px 15px;
            background: #5bbc5b;
            border: none;
            border-radius: 3px;
            color: white;
            font-size: 14px;
            transition: all 0.5s;
        }
        .btn-submitform:hover{
            transform: scale(0.95);
        }
        .big-row{
            display: flex;
        }
        .edit{
            text-align: center;
            margin: 0 auto;
            justify-content: center;
            font-size: 30px;
            height: 47px;
            color: #3c941d;
            font-weight: 700;
            letter-spacing: 6px;
            padding-bottom: -16px;
            background: #f3fff0;
            padding: 5px;
            width: 414px;
        }

        #customFile:hover{
            cursor: pointer;
        }
        .move-trans{

        }
    </style>
</head>

<body>
    <jsp:include page="include/header.jsp"/>

    
    <%String messaa = (String)request.getAttribute("messaa");
    if(messaa==null){%>

    <%}else{%>
    <div class="alert alert-success alert-dismissible move-trans" style=" background-color: #5bbc5b;
         border-color: #c3e6cb;
         width: 400px;
         height: 71px;
         float: right;
         position: absolute;
         top: 51%;
         right: 21px;
         z-index: 99;" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
        <h6><i class="fas fa-check"></i><b> Thành công!</b></h6>
                <%=messaa%>
    </div>
    <%}%>

    <%String mess = (String)request.getAttribute("mess");
    if(mess==null){%>

    <%}else{%>
    <div class="alert alert-success alert-dismissible move-trans" style=" background-color: #5bbc5b;
         border-color: #c3e6cb;
         width: 400px;
         height: 71px;
         float: right;
         position: absolute;
         top: 51%;
         right: 21px;
         z-index: 99;" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
        <h6><i class="fas fa-check"></i><b> Thành công!</b></h6>
                <%=mess%>
    </div>
    <%}%>
    <%String messa = (String)request.getAttribute("messa");
    if(messa==null){%>

    <%}else if (messa.equalsIgnoreCase("Thay đổi mật khẩu thành công")){%>
    <div class="alert alert-success alert-dismissible move-trans" style=" background-color: #5bbc5b;
         border-color: #c3e6cb;
         width: 400px;
         height: 71px;
         float: right;
         position: absolute;
         top: 51%;
         right: 21px;
         z-index: 99;" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
        <h6><i class="fas fa-check"></i><b> Thành công!</b></h6>
                <%=messa%>
    </div>
    <%}else{%>
    <div class="alert alert-success alert-dismissible move-trans" style=" background-color: #E53935;
         border-color: #c3e6cb;
         width: 400px;
         height: 71px;
         float: right;
         position: absolute;
         top: 51%;
         right: 21px;
         z-index: 99;" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
        <h6><b> Thất bại!</b></h6>
        <%=messa%>
    </div>
    <%}%>
    <section style="background-color: #eee;">
        <div class="contain" style="margin: 0;padding: 0;max-width: 100%;">
            <div class="row">
                <div class="col"style="background: #f1eee9;">
                    <nav aria-label="breadcrumb" class="bg-light rounded-3 mb-4" style="padding: 4px;">
                        <ol class="edit breadcrumb mb-0" style="text-align: center;
                            margin: 0 auto;
                            justify-content: center;
                            font-size: 30px;
                            height: 47px;
                            color: #3c941d;
                            font-weight: 700;
                            letter-spacing: 6px;
                            padding-bottom: -16px;
                            background: #f3fff0;
                            padding: 5px;
                            width: 414px;">
                            TÀI KHOẢN
                        </ol>
                    </nav>
                </div>
            </div>
            <%
            ResultSet rsProfile = (ResultSet)request.getAttribute("rsProfile");
            if(rsProfile.next()){%>
            <div class="row">
                <div class="col-lg-4">
                    <div class="card mb-4">
                        <div class="card-body text-center">
                            <img src="images/user/${sessionScope.account.userImage}" alt="avatar" class="rounded-circle img-fluid" style="width: 150px;">
                            <h5 class="my-3">${sessionScope.account.firstName}&nbsp;${sessionScope.account.lastName}</h5>
                            <p class="text-muted mb-1">
                                <%
                                    DAOUser dao = new DAOUser();
                               int roleId = rsProfile.getInt("RoleID");
                               ResultSet rsConvertRole = dao.getData("select * from Role where RoleID="+roleId);
                               if(rsConvertRole.next()){
                                String roleName = rsConvertRole.getString(2);
                                %>
                                <%=roleName%>
                                <%}%>
                            </p>
                            <p class="text-muted mb-4"></p>
                            <div class="d-flex justify-content-center mb-2">
                                <form method="post" action="ChangeuserinfoURL" enctype="multipart/form-data">
                                    <input type="hidden" name="service" value="upload"/>
                                    <input type="hidden" name="UserID" value="${sessionScope.account.userID}"/>
                                    <div class="custom-file">
                                        <input type="file" name="file" class="custom-file-input" id="customFile">
                                        <label class="custom-file-label" style="width: 220px;margin-left: 75px;margin-top: -8px;" for="customFile">
                                            <div style="width: 122px;background: #f4f4f4;">cập nhật avatar</div>
                                        </label>
                                        <button class="btn-submitform" type="submit">Lưu ảnh</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="col-lg-8">
                <div class="card mb-4"style="margin-left: -4px;width: 98%;">
                    <div class="card-body">
                        <table style="width: 100%;">
                            <td style="width: 50%;border-right: 1px solid #e5e5e5;">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Họ</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0">${sessionScope.account.firstName}</p>
                                    </div>
                                </div>
                                <hr/>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Tên</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0">${sessionScope.account.lastName}</p>
                                    </div>
                                </div>
                                <hr/>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Ngày sinh</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0">
                                            <c:if test="${sessionScope.account.dateOfBirth==null}">
                                                Chưa cập nhật
                                            </c:if>
                                            <c:if test="${sessionScope.account.dateOfBirth!=null}">
                                                ${sessionScope.account.dateOfBirth}
                                            </c:if>
                                        </p>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Giới tính</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0"><%=rsProfile.getBoolean("Gender")?"Nam" : "Nữ"%></p>
                                    </div>
                                </div>
                                <hr>
                            </td>
                            <td style="width: 50%;">
                                <div class="row" style="padding-left: 30px;">
                                    <div class="col-sm-5"style="flex: 0 0 34%;">
                                        <p class="mb-0">Email</p>
                                    </div>
                                    <div class="col-sm-7">
                                        <%
                                        String email = rsProfile.getString("Email");
                                        User u = new User();
                                        String result = u.encryptEmail(email);
                                        %>
                                        <p class="text-muted mb-0"><%=result%></p>
                                    </div>
                                </div>
                                <hr>
                                <div class="row" style="padding-left: 30px;">
                                    <div class="col-sm-5" style="flex: 0 0 34%;">
                                        <p class="mb-0">Số điện thoại</p>
                                    </div>
                                    <div class="col-sm-7">
                                        <p class="text-muted mb-0">
                                            <c:if test="${sessionScope.account.phoneNumber==null}">
                                                Chưa cập nhật
                                            </c:if>
                                            <c:if test="${sessionScope.account.phoneNumber!=null}">
                                                ${sessionScope.account.phoneNumber}
                                            </c:if>
                                        </p>
                                    </div>
                                </div>
                                <hr>
                                <div class="row" style="padding-left: 30px;">
                                    <div class="col-sm-5" style="flex: 0 0 34%;">
                                        <p class="mb-0">Địa chỉ</p>
                                    </div>
                                    <div class="col-sm-7">
                                        <p class="text-muted mb-0">
                                             <c:if test="${sessionScope.account.address==null}">
                                                Chưa cập nhật
                                            </c:if>
                                            <c:if test="${sessionScope.account.address!=null}">
                                                ${sessionScope.account.address}
                                            </c:if>
                                        </p>
                                    </div>
                                </div>
                                <hr/>
                                <div class="row"style="height: 24px;padding-left: 30px;">
                                    <div class="col-sm-5" style="flex: 0 0 34%;">
                                        <button type="button" class="btn-submitform btn btn-primary" style="    margin-top: -7px;background: #5bbc5b;box-shadow: none;border: none;" 
                                                data-toggle="modal" data-target="#exampleModal"
                                                id="#myBtn">
                                            Cập nhật
                                        </button>

                                    </div>
                                    <div class="col-sm-5" style="flex: 0 0 34%;">

                                        <button type="button" class="btn-submitform btn btn-primary" style="    margin-top: -7px;background: #5bbc5b;box-shadow: none;border: none;" 
                                                data-toggle="modal" data-target="#exampleModal1"
                                                id="#myBtn">
                                            Đổi mật khẩu
                                        </button>
                                    </div>

                                </div>

                                <div class="col-sm-7">
                                    <p class="text-muted mb-0"></p>
                                </div>
                                </div>
                                <hr/>
                            </td>
                        </table>
                    </div>
                </div>

            </div>
        </div>
        <%}%>
    </div>
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <form action="ChangeuserinfoURL" method="post" class="form-container" >
                <input type="hidden" name="service" value="changeprofile"/>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Chỉnh sửa hồ sơ</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <div style="color: red;">${sessionScope.input}</div>

                        <table cellspacing="15" ">
                            <input type="hidden" name="UserID" value="${sessionScope.account.userID}"/>
                            <tr>   
                                <td style=" font-size: 1.2em; text-align: right;color: #909fa9;font-family: monospace">Họ </td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td><input type="text" name="firstName1" required value="${sessionScope.account.firstName}"  /></td>
                            </tr>

                            <tr>
                                <td style="font-size: 1.2em; text-align: right;color: #909fa9;font-family: monospace">Tên </td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td><input type="text" name="lastName1" required value="${sessionScope.account.lastName}"  /></td>                                </tr>
                            <tr>
                                <td style="font-size: 1.2em; text-align: right;color: #909fa9;font-family: monospace">Email </td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td>${sessionScope.account.email}  </td>
                            </tr>
                            <tr>
                                <td style="font-size: 1.2em; text-align: right;color: #909fa9;font-family: monospace">Số điện thoại</td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td><input type="text" name="phoneNumber1" placeholder="Nhập Số Điện Thoại" class="form-control"
                                           minlength="10" maxlength="10" required=""
                                           pattern="[0-9 ]+" oninvalid="this.setCustomValidity('Vui lòng điền thông tin này, Không bao gồm chữ cái và kí tự đặc biệt')" 
                                           oninput="setCustomValidity(''); validateInput(this)" value="${sessionScope.account.phoneNumber}"  /></td>
                            </tr>
                            <tr>
                                <td style="font-size: 1.2em; text-align: right;color: #909fa9;font-family: monospace">Địa chỉ </td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td><input type="text" name="address1" required value="${sessionScope.account.address} "  /></td>
                            </tr>
                            <tr>
                                <td style="font-size: 1.2em; text-align: right;color: #909fa9;font-family: monospace">Ngày sinh </td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td>
                                    <input type="date" name="dateOfBirth1"value="${sessionScope.account.dateOfBirth}">
                                </td>
                            </tr>
                            <tr>
                                <td style="font-size: 1.2em; text-align: right;color: #909fa9;font-family: monospace">Giới tính </td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td><input type="radio" name="gender1" value="true"<c:if test="${sessionScope.account.gender}">checked</c:if>/> Nam
                                    <input type="radio" name="gender1"  value="false" <c:if test="${!sessionScope.account.gender}">checked</c:if> /> Nữ
                                    </td>
                                </tr>

                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                        </div>
                    </div></form>
            </div>
        </div>
        <div class="modal fade" id="exampleModal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <form action="ChangeuserinfoURL" method="post"class="form-container">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Đổi mật khẩu</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div style="color: red;">${sessionScope.input}</div>
                        <table cellspacing="15"   style="margin: 0 auto;margin-top: 15px;">
                            <input type="hidden" name="service" value="changepassword"/>
                            <input type="hidden" name="UserID" value="${sessionScope.account.userID}"/>
                            <tr>   
                                <td style=" font-size: 1.2em; text-align: right;color: #909fa9;font-family: monospace">Nhập mật khẩu cũ </td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td><input  class="form-control"  style="width: 223px;margin: 0 auto;height: 30px;border: 1px solid;border-radius: 4px;" 
                                            type="password" id="" name="oldPass" placeholder="Nhập mật khẩu" required>  </td>
                            </tr>

                            <tr>
                                <td style="font-size: 1.2em; text-align: right;color: #909fa9;font-family: monospace">Nhập mật khẩu mới </td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td><input  class="form-control"  style="width: 223px;margin: 0 auto;height: 30px;border: 1px solid;border-radius: 4px;"
                                            type="password" id="registerPassword" name="pass" placeholder="Nhập mật khẩu" required class="form-control"
                                            minlength="6" maxlength="15" 
                                            title="Mật khẩu phải chứa từ 6 đến 15 ký tự" 
                                            oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                            oninput="setCustomValidity(''); validateInput(this);validatePasswordMatch(this)">   </td>                                </tr>
                            <tr>
                                <td style="font-size: 1.2em; text-align: right;color: #909fa9;font-family: monospace">Nhập lại mật khẩu mới </td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td><input class="form-control" type="password" style="width: 223px;margin: 0 auto;height: 30px;border: 1px solid;border-radius: 4px;"
                                           id="registerPasswordConfirm" name="repass" placeholder="Nhập lại mật khẩu" required class="form-control"
                                           minlength="6" maxlength="15"
                                           title="Mật khẩu phải chứa từ 6 đến 15 ký tự" 
                                           oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                           oninput="setCustomValidity(''); validateInput(this);validatePasswordMatch(this)">
                                    <div class="invalid-feedback" style="padding-right: 94px;" id="passwordMismatch">
                                        Mật khẩu không khớp
                                    </div> </td>
                            </tr>
                        </table>        

                    </div>
                    <div class="modal-footer">
                        <button class="btn-submitform" type="submit">Đổi mật khẩu</button>
                    </div>

                </div>
            </form>
        </div>
    </div>
</section> 
<footer class="footer_1">
    <div class="container_1" style="height: 270px;padding-top: 28px;">
        <div class="row_1">
            <div class="col_1" id="company">
                <img style="width: 176px;
                     margin-bottom: -19px;
                     margin-top: 10px;height: 136px;" src="images/logo/logo.png" alt="" class="logo_1">
                <p style="font-family: poppins;font-size: 15px;color: white;">
                    công ty Smartket Việt Nam, 54 Liễu Giai, quận Ba Đình, Hà Nội 
                </p>
                <div class="social_1">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
                </div>
            </div>


            <div class="col_1" id="services">
                <h3 class="footer_title_1">Dịch vụ</h3>
                <div class="links_1">
                    <a href="#">Tuyển dụng</a>
                    <a href="#">Quảng cáo</a>
                    <a href="#">Chính sách</a>
                </div>
            </div>

            <div class="col_1" id="useful-links" style="margin-left: 50px;margin-right: 50px;">
                <h3 class="footer_title_1">Đường dẫn</h3>
                <div class="links_1">
                    <a href="#">Về chúng tôi</a>
                    <a href="#">Danh mục</a>
                    <a href="#">Tin tức</a>
                    <a href="#">Hỗ trợ</a>
                </div>
            </div>

            <div class="col_1" id="contact">
                <h3 class="footer_title_1">Liên hệ</h3>
                <div class="contact-details_1">
                    <i class="fa-regular fa-envelope"></i>
                    <p style="color: white;">Smartket@gmail.com</p>
                </div>
                <div class="contact-details_1">
                    <i class="fa fa-phone"></i>
                    <p style="color: white;">+84 99.999.999</p>
                </div>
            </div>
        </div>

        <div class="row_1">
            <div class="form_1" style="margin-top: -56px;">
                <form action="">
                    <input class="email-input_1" style="height: 40px;" type="text" placeholder="Email here...">
                    <button class="email-button_1" style="height: 43px;padding-top: 10px;"><i class="fa fa-paper-plane"></i></button>
                </form>
            </div>
        </div>
    </div>
</footer>
<script>
    var inputFiles = document.querySelectorAll('input[type=file]');
    console.log(inputFiles);
    inputFiles[0].addEventListener('change', function () {
        const image = this.files[0];
        if (image.size < 2000000) {
            const reader = new FileReader();
            reader.onload = () => {
                const allImg = imgAreas[0].querySelectorAll('img');
                allImg.forEach(item => item.remove());
                const imgUrl = reader.result;
                console.log(imgUrl);
                const img = document.createElement('img');
                img.src = imgUrl;
                imgAreas[0].appendChild(img);
                imgAreas[0].classList.add('active');
                imgAreas[0].dataset.img = "Choose another Image";
            };
            reader.readAsDataURL(image);
        }
    });
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

    function validateInput(input) {
        if (input.validity.valid) {
            input.classList.remove('is-invalid');
            input.classList.add('is-valid');
        } else {
            input.classList.add('is-invalid');
            input.classList.remove('is-valid');
        }
    }

</script>
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="js_marketing/ruang-admin.min.js"></script>
</section>

</body>

