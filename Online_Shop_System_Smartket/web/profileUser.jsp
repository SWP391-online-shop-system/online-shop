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
    <style>
        body{
            margin: 5px -5px;
        }
        a{
            color: black;
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
</head>
<body>
    <jsp:include page="include/header.jsp"/>


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
                            <img src="images/user/<%=rsProfile.getString("UserImage")%>" alt="avatar" class="rounded-circle img-fluid" style="width: 150px;">
                            <h5 class="my-3"><%=rsProfile.getString("FirstName") +" "+ rsProfile.getString("LastName")%></h5>
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
                                        <p class="text-muted mb-0"><%=rsProfile.getString("FirstName")%></p>
                                    </div>
                                </div>
                                <hr/>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Tên</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0"><%=rsProfile.getString("LastName")%></p>
                                    </div>
                                </div>
                                <hr/>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Ngày sinh</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0"><%=rsProfile.getString("DateOfBirth")==null?"Chưa cập nhật":rsProfile.getString("DateOfBirth")%></p>
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
                                        <p class="text-muted mb-0"><%=rsProfile.getString("PhoneNumber")==null?"Chưa cập nhật":rsProfile.getString("PhoneNumber")%></p>
                                    </div>
                                </div>
                                <hr>
                                <div class="row" style="padding-left: 30px;">
                                    <div class="col-sm-5" style="flex: 0 0 34%;">
                                        <p class="mb-0">Địa chỉ</p>
                                    </div>
                                    <div class="col-sm-7">
                                        <p class="text-muted mb-0"><%=rsProfile.getString("Address")==null?"Chưa cập nhật":rsProfile.getString("Address")%></p>
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

                <div class="row">
                    <div class="card mb-4" style="flex: 0 0 49%;max-width: 49%;margin-bottom: 20px;margin-left: 11px;">
                        <div class="card-body p-0">
                            <ul class="list-group list-group-flush rounded-3">
                                <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                    <i class="fas fa-globe fa-lg text-warning"></i>
                                    <p class="mb-0">https://mdbootstrap.com</p>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                    <i class="fab fa-github fa-lg" style="color: #333333;"></i>
                                    <p class="mb-0">mdbootstrap</p>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                    <i class="fab fa-twitter fa-lg" style="color: #55acee;"></i>
                                    <p class="mb-0">@mdbootstrap</p>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                    <i class="fab fa-instagram fa-lg" style="color: #ac2bac;"></i>
                                    <p class="mb-0">mdbootstrap</p>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                    <i class="fab fa-facebook-f fa-lg" style="color: #3b5998;"></i>
                                    <p class="mb-0">mdbootstrap</p>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-6" style="    flex: 0 0 48%;max-width: 50%;margin-bottom: 20px;margin-left: -5px;">
                        <div class="card mb-4 mb-md-0">
                            <div class="card-body"style="text-align: center;
                                 margin-top: 30px;
                                 height: 327px;
                                 margin-bottom: 0px;">
                                <div style="text-align: center;
                                     margin-bottom: 3px;
                                     text-align: center;
                                     margin-bottom: -1px;
                                     font-size: 30px;
                                     letter-spacing: 1px;
                                     font-weight: 600;
                                     color: #3c941d;
                                     background: #f3fff0;
                                     border-radius: 5px;
                                     margin-top: -40px;">Đổi mật khẩu</div>
                                <table style="margin: 0 auto;margin-top: 15px;">
                                    <form action="userprofile" method="get">
                                        <tr>
                                        <label for="exampleInputEmail1">Nhập mật khẩu cũ</label>
                                        </tr>
                                        <tr> 
                                        <div class="form-group" style="margin-bottom: -3px;">
                                            <input  class="form-control"  style="width: 223px;margin: 0 auto;height: 30px;border: 1px solid;border-radius: 4px;" 
                                                    type="password" id="" name="oldPass" placeholder="Nhập mật khẩu" required>  
                                        </div>
                                        </tr>
                                        <tr>
                                        <label for="registerPassword"style="margin-left: -82px;">Nhập mật khẩu mới</label>
                                        </tr>
                                        <tr> 
                                        <div class="form-element">
                                            <input  class="form-control"  style="width: 223px;margin: 0 auto;height: 30px;border: 1px solid;border-radius: 4px;"
                                                    type="password" id="registerPassword" name="pass" placeholder="Nhập mật khẩu" required class="form-control"
                                                    minlength="6" maxlength="15" 
                                                    title="Mật khẩu phải chứa từ 6 đến 15 ký tự" 
                                                    oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                                    oninput="setCustomValidity(''); validateInput(this);validatePasswordMatch(this)">                                               
                                        </div>
                                        </tr>
                                        <tr>
                                        <label for="registerPassword"style="margin-left: -62px;">Nhập lại mật khẩu mới</label>
                                        </tr>
                                        <tr> 
                                        <div class="form-element">
                                            <input class="form-control" type="password" style="width: 223px;margin: 0 auto;height: 30px;border: 1px solid;border-radius: 4px;"
                                                   id="registerPasswordConfirm" name="repass" placeholder="Nhập lại mật khẩu" required class="form-control"
                                                   minlength="6" maxlength="15"
                                                   title="Mật khẩu phải chứa từ 6 đến 15 ký tự" 
                                                   oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                                   oninput="setCustomValidity(''); validateInput(this);validatePasswordMatch(this)">
                                            <div class="invalid-feedback" style="padding-right: 94px;" id="passwordMismatch">
                                                Mật khẩu không khớp
                                            </div>
                                        </div>
                                        </tr>
                                        <tr>
                                        <button class="btn-submitform" type="submit">Đổi mật khẩu</button>
                                        </tr>
                                    </form>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <%}%>
    </div>
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Chỉnh sửa hồ sơ</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <table>
                            <tr style="height: 51px;">
                                <td>Họ</td>
                                <td><input type="text" name="lastName" value=""/></td>
                            </tr>
                            <tr style="height: 51px;">
                                <td>Tên</td>
                                <td><input type="text" name="firstName" value=""/></td>
                            </tr>
                            <tr style="height: 51px;">
                                <td>Ngày sinh</td>
                                <td><input type="date" name="dateOfBirth" value=""/></td>
                            </tr>
                            <tr style="height: 51px;">
                                <td>Giới tính</td>
                                <td>
                                    <input type="radio" name="gender" value="Nam"/>Nam
                                    <input type="radio" name="gender" value="Nữ"/>Nữ
                                </td>
                            </tr>
                            <tr style="height: 51px;">
                                <td>Email</td>
                                <td><input type="text" name="email" readonly value=""/></td>
                            </tr>
                            <tr>
                                <td>Số điện thoại</td>
                                <td><input type="tel" name="phone" value=""/></td>
                            </tr>
                            <tr style="height: 51px;">
                                <td>Địa chỉ</td>
                                <td><input type="text" name="address" value=""/></td>
                            </tr>
                        </table>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
</section> 

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
<jsp:include page="include/footer.jsp"/>
</body>




</html>
