<%-- 
    Document   : customerdetails
    Created on : Feb 21, 2024, 6:08:48 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet,model.DAOUser"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Thông Tin Khách Hàng</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/css_marketing_dashboard/marketing_dashboard_style.css" rel="stylesheet">
        <!--<link href="css/css_customerlist/detail.css" rel="stylesheet">-->
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
    </head>
    <body id="page-top">
        <%
          ResultSet rs = (ResultSet)request.getAttribute("data");
          ResultSet log = (ResultSet)request.getAttribute("log");
          
        %>
        <div id="wrapper">
            <!-- Sidebar -->
            <ul class="navbar-nav sidebar sidebar-light accordion" id="accordionSidebar">
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
                    <div class="sidebar-brand-icon">
                        <img style="height: 91px;
                             width: 133px;
                             margin-bottom: -18px;" src="images/logo/logo.png">
                    </div>
                </a>
                <div style="position: sticky; top: 30px;">
                    <hr class="sidebar-divider wee-0" style="margin: 0px;">
                    <li class="nav-item active">
                        <a class="nav-link" href="index.html">
                            <i class="fas fa-fw fa-tachometer-alt"></i>
                            <span>Thống kê</span></a>
                    </li>
                    <hr class="sidebar-divider">
                    <div class="sidebar-heading">
                        Quản lí
                    </div>
                    <li class="nav-item">
                        <a class="nav-link" href="ui-colors.html">
                            <i class="fas fa-calendar fa-2x text-primary"></i>
                            <span>Bài đăng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ui-colors.html">
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
                        <a class="nav-link" href="FeedBackListURL">
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
                        <a href="customerlist" style="color: white"><button class="btn btn-primary mb-1">Quay lại</button></a>
                        <section>
                            <div class=" ">                                
                                <div class="row">
                                    <%
                                        while(rs.next()){
                                    %>
                                    <div class="col-lg-2">
                                        <div class="card mb-4">
                                            <div class="card-body text-center">
                                                <img src="images/user/<%=rs.getString("UserImage")%>" alt="avatar"
                                                     class="rounded-circle img-fluid" style="width: 150px;border: 1px solid">
                                            </div>
                                            <p style="text-align: center">Mã Khách Hàng: <%=rs.getInt(1)%></p>
                                        </div>

                                    </div>
                                    <div class="col-lg-8">
                                        <div class="card mb-4">
                                            <div class="card-body">
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        <p class="mb-0">Họ và tên</p>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <p><%=rs.getString(2)+" "+rs.getString(3)%></p>
                                                    </div>
                                                </div>
                                                <hr>
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        <p class="mb-0">Email</p>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <p class="text-muted mb-0"> <%=rs.getString("Email")%></p>
                                                    </div>
                                                </div>
                                                <hr>
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        <p class="mb-0">Số điện thoại</p>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <p class="text-muted mb-0"><%=(rs.getString("PhoneNumber")==null)?"Chưa cập nhật":rs.getString("PhoneNumber")%></p>
                                                    </div>
                                                </div>
                                                <hr>
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        <p class="mb-0">Địa chỉ</p>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <p class="text-muted mb-0"><%=(rs.getString("Address")==null)?"Chưa cập nhật":""%></p>
                                                    </div>
                                                </div>
                                                <hr>
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        <p class="mb-0">Ngày sinh</p>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <p class="text-muted mb-0"><%=(rs.getString("DateOfBirth")==null)?"Chưa cập nhật":""%></p>
                                                    </div>
                                                </div>
                                                <hr>
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        <p class="mb-0">Giới tính</p>
                                                    </div>
                                                    <div class="col-sm-8"><%
    String gender = rs.getString("Gender");
    String displayGender = "";
    if (gender == null || gender.equals("0")) {
        displayGender = "Nữ";
    } else {
        displayGender = "Nam";
    }
    String status = rs.getString("UserStatus");
    String displayStatus = "";
    if (status.equals("0")) {
        displayStatus = "Không hoạt động";
    } else if(status.equals("2")){
        displayStatus = "Bị chặn";
    }else {
        displayStatus = "Hoạt động";
    }
                                                        %>
                                                        <p class="text-muted mb-0"><%=displayGender%></p>
                                                    </div>
                                                </div>
                                                <hr>
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        <p class="mb-0">Đăng nhập lần cuối</p>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <p class="text-muted mb-0"><%=rs.getString("LastLogin")%></p>
                                                    </div>
                                                </div>
                                                <hr>
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        <p class="mb-0">Trạng thái</p>
                                                    </div>
                                                    <form class="col-sm-8" id="myForm" method="get" action="customerDetail">
                                                        <input type="hidden" id="statusInput" name="status" value="<%=status%>">
                                                        <input type="hidden" name="uid" value="<%=rs.getInt(1)%>">
                                                        <div class="custom-control custom-switch">
                                                            <input type="checkbox" class="custom-control-input" id="customSwitch1" onchange="document.getElementById('myForm').submit()"
                                                                   <%if(status.equals("0")){%> disabled<%}%>>
                                                            <label class="custom-control-label" for="customSwitch1"></label>
                                                        </div>
                                                    </form>
                                                    <script>
                                                        window.onload = function () {
                                                            var statusString = "<%=status%>";
                                                            var status = parseInt(statusString, 10);
                                                            var switchInput = document.getElementById("customSwitch1");

                                                            // Cập nhật trạng thái của nút switch
                                                            switchInput.checked = (status === 1);
                                                        };
                                                    </script>
                                                </div>
                                                <hr>
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        <p class="mb-0">Ngày tạo tài khoản</p>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <p class="text-muted mb-0"><%=rs.getString("CreateDate")%></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <%}%>
                                </div>
                                <div class="row" style="margin-bottom: 36px">
                                    <div class="col-md-12">
                                        <div class="card mb-4 mb-md-0">
                                            <div class="card-body">
                                                <p class="mb-4">Lịch sử thay đổi trạng thái:</p>
                                                <div>
                                                    <%
                                       while(log.next()){
                                                    %>
                                                    <%
                                                        DAOUser dao = new DAOUser();
                                                        ResultSet mkt = dao.getData("SELECT * FROM online_shop_system.user where userID = " + log.getInt(2));
                                                    %>
                                                    <p>- <%while(mkt.next()){%>Nhân viên <%=mkt.getString("FirstName")+" "+mkt.getString("LastName")%> <%}%>
                                                        đã <%=log.getString(4)%> <%=log.getString("FirstName")+" "+log.getString("LastName")%> vào <%=log.getString(3)%></p>
                                                        <%}%>
                                                </div>                                         
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
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
                <script src="js_marketing/demo/chart-area-demo.js"></script>  -->
        <script src="vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

        <!-- Page level custom scripts -->
        <script type="text/javascript">
                                                        function updateStatus() {
                                                            var switchStatus = document.getElementById("customSwitch1").checked;
                                                            var hiddenInput = document.getElementById("statusInput");

                                                            // Cập nhật giá trị của trường ẩn trong form
                                                            hiddenInput.value = switchStatus;

                                                            // Gửi form
                                                            document.getElementById("myForm").submit();
                                                        }
        </script>
    </body>
</html>
