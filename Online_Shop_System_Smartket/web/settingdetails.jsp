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
        <title>Danh Sách Cài Đặt</title>
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
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="MarketingDashBoardURL">
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
                    <li class="nav-item">
                        <a class="nav-link" href="adminOrderTrackURL?status=all&orderFrom=&orderTo=">
                            <i class="fas fa-calendar fa-2x text-primary"></i>
                            <span>Đơn hàng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="userlist">
                            <span>Người dùng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="settinglist">
                            <span>Cài đặt</span>
                        </a>
                    </li>
                </div>
            </ul>
            <!-- Sidebar -->
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <!-- TopBar -->
                    <nav class="navbar navbar-expand navbar-light bg-navbar topbar mb-4 static-top">
                        <div style="font-weight: 700;color: white;font-size: 37px;letter-spacing: 2px;font-family: Nunito,-apple-system,BlinkMacSystemFont"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";">Trang Admin</div>
                        <ul class="navbar-nav ml-auto">
                            <div class="topbar-divider d-none d-sm-block"></div>
                            <li class="nav-item dropdown no-arrow">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"
                                   aria-haspopup="true" aria-expanded="false">
                                    <img class="img-profile rounded-circle" src="images/user/${sessionScope.account.userImage}" style="max-width: 60px">
                                    <span class="ml-2 d-none d-lg-inline text-white small">${sessionScope.account.firstName}&nbsp;${sessionScope.account.lastName}</span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Hồ sơ
                                    </a>
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Cài đặt
                                    </a>
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Lịch sử thay đổi
                                    </a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="logout">
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
                            <h1 class="h3 mb-0 text-gray-800">Danh Sách Cài Đặt</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="./">Trang Chủ</a></li>
                                <li class="breadcrumb-item active">Danh Sách Cài Đặt</li>
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
                            <div style="margin-left: 25px; margin-top: -10px;"><a href="settinglist" style="color: white"><button class="btn btn-primary mb-1">Quay lại</button></a></div>
                        </div>
                        <div class="row">
                            <!-- DataTable with Hover -->
                            <div class="col-lg-12">
                                <div class="card mb-4">                                 
                                    <div class="table-responsive p-3">
                                        <form action="updatesetting" method="post">
                                            <table class="table align-items-center table-flush table-hover"  style="font-size: 14px;">
                                                <thead class="thead-light">
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Loại</th>
                                                        <th>Giá trị</th>
                                                        <th>Trạng Thái</th>	
                                                        <th>Yêu cầu</th>
                                                        <th>Mô tả</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr> 
                                                        <td>${sessionScope.getaset.settingID}</td>
                                                        <td><input type="text" name="namecate" value="${sessionScope.getaset.settingName}" readonly></td>
                                                        <td><input type="text" name="2"value="${sessionScope.getaset.settingValue}"readonly></td>
                                                            <input name="updatesettingid" type= "hidden" value="${sessionScope.getaset.settingID}"> <br>
                                                        <td>
                                                            <input type="radio" name="updateset" value="1"<c:if test="${sessionScope.getaset.settingStatus==1}">checked</c:if>>Kích Hoạt <br>
                                                            <input type="radio" name="updateset" value="0" <c:if test="${sessionScope.getaset.settingStatus==0}">checked</c:if>> Vô hiệu hóa
                                                        </td>
                                                        <td><input type="text" name="idcate" value="${sessionScope.getaset.settingOrder}"readonly></td>     
                                                        <td><textarea  name="4"readonly>${sessionScope.getaset.settingDescription}</textarea></td>                                       

                                                    </tr>
                                                </tbody>
                                            </table>
                                            <input type="submit" name="submit" value="Lưu cài đặt">
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Modal Logout -->
                        <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabelLogout"
                             aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabelLogout">Ohh No!</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <p>Are you sure you want to logout?</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Cancel</button>
                                        <a href="login.html" class="btn btn-primary">Logout</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabelLogout"
                         aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabelLogout">Ohh No!</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p>Are you sure you want to logout?</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Cancel</button>
                                    <a href="login.html" class="btn btn-primary">Logout</a>
                                </div>
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
        <script src="js_marketing/ruang-admin.min.js"></script>
        <script src="vendor/chart.js/Chart.min.js"></script>
        <script src="js_marketing/demo/chart-area-demo.js"></script>  
        <script src="vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable(); // ID From dataTable 
                $('#dataTableHover').DataTable(); // ID From dataTable with Hover
            });
        </script>
    </body>
</html>