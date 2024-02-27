<%-- 
    Document   : customerlist
    Created on : Jan 31, 2024, 3:38:58 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="jakarta.servlet.http.HttpSession"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Danh Sách Khách Hàng</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/css_marketing_dashboard/marketing_dashboard_style.css" rel="stylesheet">
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
    </head>
    <body id="page-top">
        <%
            HttpSession sessionMessage = request.getSession();
            String message =(String)sessionMessage.getAttribute("message");
            
        %>
        <div id="wrapper">
            <!-- Sidebar -->
            <ul class="navbar-nav sidebar sidebar-light accordion" id="accordionSidebar">
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="HomePageURL">
                    <div class="sidebar-brand-icon">
                        <img style="height: 91px;
                             width: 133px;
                             margin-bottom: -18px;" src="images/logo/logo.png">
                    </div>
                </a>
                <div style="position: sticky; top: 30px;">
                    <hr class="sidebar-divider wee-0" style="margin: 0px;">
                    <li class="nav-item active">
                        <a class="nav-link" href="MarketingDashBoardURL">
                            <i class="fas fa-fw fa-tachometer-alt"></i>
                            <span>Thống kê</span></a>
                    </li>
                    <hr class="sidebar-divider">
                    <div class="sidebar-heading">
                        Quản lí
                    </div>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fas fa-calendar fa-2x text-primary"></i>
                            <span>Bài đăng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="mktProductListURL">
                            <i class="fas fa-shopping-cart fa-2x text-success"></i>
                            <span>Sản phẩm</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="customerlist">
                            <i class="fas fa-users fa-2x text-info"></i>
                            <span>Khách hàng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ui-colors.html">
                            <i class="fas fa-comments fa-2x text-info"></i>
                            <span>Phản hồi</span>
                        </a>
                    </li>
                    <hr class="sidebar-divider">
                </div>
            </ul>
            <!-- Sidebar -->
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <!-- TopBar -->
                    <nav class="navbar navbar-expand navbar-light bg-navbar topbar mb-4 static-top">
                        <div style="font-weight: 700;color: white;font-size: 37px;letter-spacing: 2px;font-family: Nunito,-apple-system,BlinkMacSystemFont"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";">Trang marketing</div>
                        <ul class="navbar-nav ml-auto">
                            <div class="topbar-divider d-none d-sm-block"></div>
                            <li class="nav-item dropdown no-arrow">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"
                                   aria-haspopup="true" aria-expanded="false">
                                    <img class="img-profile rounded-circle" src="images/user/default_avatar.jpg" style="max-width: 60px">
                                    <span class="ml-2 d-none d-lg-inline text-white small">Maman Ketoprak</span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Hồ sơ
                                    </a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="javascript:void(0);" data-toggle="modal" data-target="#logoutModal">
                                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Đăng xuất
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </nav>
                    <!-- Topbar -->

                    <!-- Container Fluid-->
                    <div class="container-fluid" id="container-wrapper">
                        <div class="d-sm-flex align-items-center justify-content-between mb-4">
                            <h1 class="h3 mb-0 text-gray-800">Danh Sách Khách Hàng</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="./">Trang Chủ</a></li>
                                <li class="breadcrumb-item active">Danh Sách Khách Hàng</li>
                            </ol>
                        </div>

                        <!-- Row -->
                        <div<%if(message == null){%> style="display: none"<%}%>>
                            <%if(message != null){%>
                            <%if(message.equals("Thêm thành công")){%>
                            <div class="alert alert-success alert-dismissible" role="alert" style="width: 40%" >
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h6><i class="fas fa-check"></i><b>  <%=message%></b></h6>
                            </div>
                            <%}%>
                            <%if(message.equals("Email đã tồn tại")){%>
                            <div class="alert alert-warning alert-dismissible" role="alert" style="width: 40%">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h6><i class="fas fa-check"></i><b>  <%=message%></b></h6>
                            </div>
                            <%}}%>
                        </div>
                        <%sessionMessage.removeAttribute("message");%>
                        <div class="row">
                            <button style="margin-left: 13px;margin-bottom: 5px;" type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#exampleModalLong"
                                    id="#modalLong">Thêm Khách Hàng Mới</button>

                        </div>
                        <div class="row">
                            <!-- DataTable with Hover -->
                            <div class="col-lg-12">
                                <div class="card mb-4">                                 
                                    <!--                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                                            <h6 class="m-0 font-weight-bold text-primary">DataTables with Hover</h6>
                                                                        </div>-->
                                    <div class="table-responsive p-3">
                                        <table class="table align-items-center table-flush table-hover" id="dataTableHover" style="font-size: 14px;
                                               ">
                                            <thead class="thead-light">
                                                <tr>
                                                    <th style="text-align: center; width: 0">ID</th>
                                                    <th style="text-align: center;width: 105.898px;">Tên Khách Hàng</th>
                                                    <th style="text-align: center;width: 188.727px">Email</th>
                                                    <th style="text-align: center; width: 59.1023px">Giới Tính</th>
                                                    <th style="text-align: center;width: 98px">Số Điện Thoại</th>						
                                                    <th style="text-align: center; width:67.5114px">Trạng Thái</th>						
                                                    <th style="text-align: center;width: 98px">Đăng Nhập Cuối</th>
                                                </tr>
                                            </thead>

                                            <tbody>
                                                <c:forEach items="${requestScope.data}" var="cus">
                                                    <tr style="text-align: center; cursor: pointer" onclick="Customerdetail(${cus.userID})">
                                                        <td>${cus.userID}</td>
                                                        <td>${cus.firstName} ${cus.lastName}</td>
                                                        <td>${cus.email}</td>
                                                        <td>${cus.gender ? 'Nam':'Nữ'}</td>
                                                        <td>${cus.phoneNumber ? '':'Không'}</td>                        
                                                        <td><c:if test="${cus.userStatus == 0}"><span class="badge badge-info">Chưa xác nhận</span></c:if>
                                                            <c:if test="${cus.userStatus == 1}"><span class="badge badge-success">Hoạt động</span></c:if>
                                                            <c:if test="${cus.userStatus == 2}"><span class="badge badge-danger">Bị chặn</span></c:if>
                                                        <td title="${cus.lastLogin}">${cus.lastLogin}</td>
                                                    </tr>
                                                </c:forEach>    
                                            </tbody>
                                        </table>
                                    </div>                                    
                                </div>
                            </div>
                        </div>
                        <!--Row-->
                        <!-- Modal Long -->
                        <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog"
                             aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <form action="customerlist" method="post">
                                    <input type="hidden" name="service" value="addnewuser"/>
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLongTitle">Thêm Khách Hàng</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">                                           
                                            <div class="form-element form-group">                                              
                                                <label for="registerEmail">Họ</label>                                               
                                                <input type="text" name="FName" placeholder="Nhập họ" required class="form-control"
                                                       pattern="[A-Za-zÀ-ỹ ]+" oninvalid="this.setCustomValidity('Vui lòng điền thông tin này, Không bao gồm số và kí tự đặc biệt')" 
                                                       oninput="setCustomValidity(''); validateInput(this)" >

                                            </div>
                                            <div class="form-element">
                                                <label for="registerEmail">Tên</label>
                                                <input type="text" name="LName" placeholder="Nhập Tên" required class="form-control"
                                                       pattern="[A-Za-zÀ-ỹ ]+" oninvalid="this.setCustomValidity('Vui lòng điền thông tin này, Không bao gồm số và kí tự đặc biệt')" 
                                                       oninput="setCustomValidity(''); validateInput(this)" >
                                            </div>
                                            <div class="form-element">
                                                <label>Giới tính</label>
                                                <div style="display:flex; flex: 40%">
                                                    <div class="custom-control custom-radio" style="margin-right: 15px;">
                                                        <input type="radio" id="customRadio3" name="gender" class="custom-control-input" value="male" required>
                                                        <label class="custom-control-label" for="customRadio3">Nam</label>
                                                    </div>
                                                    <div class="custom-control custom-radio">
                                                        <input type="radio" id="customRadio4" name="gender" class="custom-control-input" value="female" required>
                                                        <label class="custom-control-label" for="customRadio4">Nữ</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-element">
                                                <label for="registerEmail">Địa chỉ</label>
                                                <input type="text" name="adress" placeholder="Nhập Địa Chỉ"       class="form-control"                                                 
                                                       oninput="setCustomValidity(''); validateInput(this)" >
                                            </div>
                                            <div class="form-element">
                                                <label for="registerEmail">Email</label>
                                                <input type="email" name="email" placeholder="Nhập email"required class="form-control"
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này và bao gồm @')" 
                                                       oninput="setCustomValidity(''); validateInput(this)" >
                                            </div>
                                            <div class="form-element">
                                                <label for="registerEmail">Số điện thoại</label>
                                                <input type="text" name="phone" placeholder="Nhập Số Điện Thoại" class="form-control"
                                                       minlength="10" maxlength="10"
                                                       pattern="[0-9 ]+" oninvalid="this.setCustomValidity('Vui lòng điền thông tin này, Không bao gồm chữ cái và kí tự đặc biệt')" 
                                                       oninput="setCustomValidity(''); validateInput(this)" >
                                            </div>
                                            <div class="form-element">
                                                <label for="registerPassword">Mật khẩu</label>

                                                <input type="password" id="registerPassword" name="pass" placeholder="Nhập mật khẩu" required class="form-control"
                                                       minlength="6" maxlength="15" title="Mật khẩu phải chứa từ 6 đến 15 ký tự" 
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                                       oninput="setCustomValidity(''); validateInput(this);validatePasswordMatch(this)">                                               


                                            </div>
                                            <div class="form-element">
                                                <label for="registerPassword">Nhập lại mật khẩu</label>
                                                <div style="flex:40%">
                                                    <input type="password" id="registerPasswordConfirm" name="repass" placeholder="Nhập lại mật khẩu" required class="form-control"
                                                           minlength="6" maxlength="15"
                                                           title="Mật khẩu phải chứa từ 6 đến 15 ký tự" 
                                                           oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                                           oninput="setCustomValidity(''); validateInput(this);validatePasswordMatch(this)">
                                                    <div class="invalid-feedback" id="passwordMismatch">
                                                        Mật khẩu không khớp
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-primary">Save changes</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>      
                </div>
                <!---Container Fluid-->
            </div>
        </div>
        <!-- Scroll to top -->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
        <!--        <script src="js_marketing/ruang-admin.min.js"></script>
        --><script src="js_marketing/customerlist.js"></script>  
        <script src="vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

        <!-- Page level custom scripts -->
        <script>

        </script>
    </body>
</html>