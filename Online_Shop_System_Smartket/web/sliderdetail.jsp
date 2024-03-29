<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="view.*" %>
<%@page import="model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.sql.ResultSet, java.sql.SQLException"%>
<link rel="stylesheet" href="css/css_saleProductList/saleProductList.css"/>
<link rel="stylesheet" href="css/css_mkt/style.css"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <link href="images/logo/logo.png" rel="icon">
        <title>Thông tin Slider</title>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/css_marketing_dashboard/marketing_dashboard_style.css" rel="stylesheet">
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <style>
            tr{
                text-align: center;
            }
            .btnSubmit{
                background: #66bb6a;
                border: none;
                border-radius: 4px;
                font-size: 15px;
                padding: 5px;
                color: white;
                margin-top: 15px;
                float: right;
            }

        </style>
    </head>
    <%
        Product product = (Product)request.getAttribute("product");
    %>
    <script>
        function validateForm() {
            var unitInStock = parseInt(document.getElementById("unitInStock").value);
            var totalStock = parseInt(document.getElementById("totalStock").value);

            if (unitInStock > totalStock) {
                alert("Hàng trong kho không thể lớn hơn Tổng số sản phẩm.");
                return false;
            }
            return true;
        }
    </script>
    <body id="page-top">
        <div id="wrapper">
            <!-- Sidebar -->
            <ul class="navbar-nav sidebar sidebar-light accordion" id="accordionSidebar">
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="http://localhost:8080/Smartket/HomePageURL">
                    <div class="sidebar-brand-icon">
                        <img style="height: 91px;
                             width: 133px;
                             margin-bottom: -18px;" src="images/logo/logo.png">
                    </div>
                </a>
                <div style="position: sticky; top: 30px;">
                    <hr class="sidebar-divider wee-0" style="margin: 0px;">
                    <li class="nav-item active">
                        <a class="nav-link" href="marketingDashBoardURL">
                            <i class="fas fa-fw fa-tachometer-alt"></i>
                            <span>Thống kê</span></a>
                    </li>
                    <hr class="sidebar-divider">
                    <div class="sidebar-heading">
                        Quản lí
                    </div>
                    <li class="nav-item">
                        <a class="nav-link" href="marketingPost">
                            <i class="fas fa-calendar fa-2x text-primary"></i>
                            <span>Bài đăng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="marketingProductListURL">
                            <i class="fas fa-shopping-cart fa-2x text-success"></i>
                            <span>Sản phẩm</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="marketingCustomerlist">
                            <i class="fas fa-users fa-2x text-info"></i>
                            <span>Khách hàng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="marketingFeedBackListURL">
                            <i class="fas fa-comments fa-2x text-info"></i>
                            <span>Phản hồi</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="marketingSliderList">
                            <i class="fas fa-comments fa-2x text-info"></i>
                            <span>Slider</span>
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
                                    <img class="img-profile rounded-circle" src="images/user/${sessionScope.account.userImage}" style="max-width: 60px">
                                    <span class="ml-2 d-none d-lg-inline text-white small">${sessionScope.account.firstName}&nbsp;${sessionScope.account.lastName}</span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Hồ sơ
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
                            <h1 class="h3 mb-0 text-gray-800">Thông tin Slider</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="http://localhost:8080/Smartket/HomePageURL">Home</a></li>
                                <!--<li class="breadcrumb-item">Tables</li>-->
                                <li class="breadcrumb-item active" aria-current="page">Thông tin Slider</li>
                            </ol>
                        </div>
                        <div class="row">
                            <!-- DataTable with Hover -->
                            <div class="col-lg-12">
                                <div class="card mb-4">
                                    <div class="table-responsive p-3">
                                        <form action="updateslider" method="post" enctype='multipart/form-data'>
                                            <table class="table align-items-center table-flush table-hover">
                                                <thead class="thead-light">
                                                    <tr>
                                                        <th>ID</th>
                                                        <th style="width: 146px;">ID Nhân viên</th>
                                                        <th style="width: 250px;">Slider</th>
                                                        <th>SliderLink</th>
                                                        <th>Ngày tạo</th>
                                                        <th style="width: 154px;">Trạng thái</th>	
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr> 
                                                        <td>${sessionScope.getaSlider.sliderID}</td>
                                                        <td>${sessionScope.getaSlider.userID}</td>
                                                        <td><img  style="height: 91px;
                                                                  width: 133px;margin-bottom: 12px;
                                                                  " src="images/slider/${sessionScope.getaSlider.sliderImage}" alt="alt"/>
                                                            <input name="updateImg" type= "file" value="" style="width: 171px;font-size: 13px;"> <br>
                                                            <input name="updatesliderid" type= "hidden" value="${sessionScope.getaSlider.sliderID}"> <br>
                                                        <td style="padding: 0px;"><textarea  name="updateLink" >${sessionScope.getaSlider.sliderLink} </textarea></td>
                                                        <td>${sessionScope.getaSlider.createDate.substring(0,10)}</td>

                                                        <td><input style="margin-left: -10px;" type="radio" name="updateStatus" value="false"<c:if test="${!sessionScope.getaSlider.sliderStatus}">checked</c:if>> Hoạt động <br>
                                                            <input style="margin-top: 12px;" type="radio" name="updateStatus" value="true" <c:if test="${sessionScope.getaSlider.sliderStatus}">checked</c:if>> Vô hiệu hóa
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <div style="display: flex;justify-content: space-between;align-items: center;">
                                                    <div><button class="btnSubmit"><a style="padding: 4px; color: white;" href="marketingSliderList" >Quay lại</a></button></div>
                                                    <input class="btnSubmit" type="submit" name="submit" value="Update Slider">
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row" style="    height: 300px;
                                 width: 97%;
                                 max-height: 300px;
                                 overflow-y: scroll;
                                 margin: 0 auto;margin-bottom: 30px;">
                                <div class="col-md-12">
                                    <div class="card mb-4 mb-md-0">
                                        <div class="card-body">
                                            <p class="mb-4"style="
                                               font-size: 20px;
                                               color: black;">Lịch sử thay đổi trạng thái</p>
                                            <div id="">
                                            <%int countLog = 0;
                                            ResultSet logger = (ResultSet)request.getAttribute("log");
                                            while(logger.next()){
                                            countLog++;
                                                DAOUser dao = new DAOUser();
                                                ResultSet mkt = dao.getData("SELECT * FROM online_shop_system.user where userID = " + logger.getInt("UpdateBy"));
                                            %>
                                            <p id="logcheck" style="margin-bottom: 15px;"><%=countLog%> - <%while(mkt.next()){%>Nhân viên <%=mkt.getString("FirstName")+" "+mkt.getString("LastName")%> <%}%>
                                                <%=logger.getString("purpose")%> mã ${sessionScope.getaSlider.sliderID} vào <span style="color: black;"><%=logger.getString("UpdateAt").substring(0,10)%>, lúc <%=logger.getString("UpdateAt").substring(10)%></span></p>
                                                <%}%>
                                        </div>                                         
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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