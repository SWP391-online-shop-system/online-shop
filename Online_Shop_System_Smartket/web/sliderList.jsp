<%-- 
    Document   : marketing_dashboard
    Created on : Feb 1, 2024, 10:24:26 AM
    Author     : admin
--%>

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
        <title>Slider list</title>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/css_marketing_dashboard/marketing_dashboard_style.css" rel="stylesheet">
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

    </head>
    <%
    ResultSet rs = (ResultSet)request.getAttribute("data");
    %>
    <div class="container">
        <% String message = (String)request.getParameter("message"); %>
        <% if (message != null && !message.isEmpty()) { %>
        <div class="alert alert-info" role="alert">
            <%= message %>
        </div>
        <% } %>
        <!-- Form content -->
    </div>
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
                        <a class="nav-link" href="http://localhost:8080/Smartket/HomePageURL">
                            <i class="fas fa-fw fa-tachometer-alt"></i>
                            <span>Thống kê</span></a>
                    </li>
                    <hr class="sidebar-divider">
                    <div class="sidebar-heading">
                        Quản lí
                    </div>
                    <li class="nav-item">
                        <a class="nav-link" href="http://localhost:8080/Smartket/sliderList">
                            <i class="fas fa-calendar fa-2x text-primary"></i>
                            <span>Slider</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ui-colors.html">
                            <i class="fas fa-shopping-cart fa-2x text-success"></i>
                            <span>Sản phẩm</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ui-colors.html">
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
                        <div style="font-weight: 700;color: white;font-size: 37px;letter-spacing: 2px;font-family: Nunito,-apple-system,BlinkMacSystemFont"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";">Slider</div>
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
                            <h1 class="h3 mb-0 text-gray-800">Danh sách Slider </h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="http://localhost:8080/Smartket/HomePageURL">Home</a></li>
                                <!--<li class="breadcrumb-item">Tables</li>-->
                                <li class="breadcrumb-item active" aria-current="page">Slider List</li>
                            </ol>
                        </div>
                        <!-- Row -->
                        <div class="row">
                            <button style="margin-left: 13px;margin-bottom: 5px;" type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#exampleModalLong"
                                    id="#modalLong">Thêm slider mới</button>

                        </div>
                        <div class="row">
                            <!-- DataTable with Hover -->
                            <div class="col-lg-12">
                                <div class="card mb-4">
                                    <div class="table-responsive p-3">
                                        <table class="table align-items-center table-flush table-hover" id="dataTableHover">
                                            <div style="display: flex;
                                                 margin-left: 200px;
                                                 margin-bottom: -30px;">
                                                <form action="sliderList" method="get" id="categoryForm">
                                                    <div class="filter-group" style="display:flex;">
                                                        <div style="padding-top: 3px;">Trạng thái</div>
                                                        <select class="form-control" name="statusfilter" onchange="this.form.submit()">
                                                            <option value="">Trạng thái</option>
                                                            <option value="true" <c:if test="${fn:contains(requestScope.statusfilter,'true')}">selected</c:if>>Hiện</option>
                                                            <option value="false" <c:if test="${fn:contains(requestScope.statusfilter,'false')}">selected</c:if>>Ẩn</option>
                                                            </select>
                                                        </div>
                                                        <input type="submit" style="display: none;">
                                                    </form>
                                                </div>
                                                <thead class="thead-light">
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Mã nhân viên</th>
                                                        <th>Slider</th>
                                                        <th>SliderLink</th>
                                                        <th>Ngày tạo</th>
                                                        <th>Trạng thái</th>						
                                                    </tr> 
                                                </thead>
                                                <tfoot>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Mã nhân viên</th>
                                                        <th>Slider</th>
                                                        <th>SliderLink</th>
                                                        <th>Ngày tạo</th>
                                                        <th>Trạng thái</th>						
                                                    </tr>
                                                </tfoot>
                                                <tbody>
                                                <c:forEach items="${sessionScope.sliderlist}" var="s">
                                                    <tr onclick="sliderDetail(${s.sliderID})">
                                                        <td>${s.sliderID}</td>
                                                        <td>${s.userID}</td>
                                                        <td><img  style="height: 91px;
                                                                  width: 133px;
                                                                  " src="images/slider/${s.sliderImage}" alt="alt"/></td>
                                                        <td><a href="${s.sliderLink}">${s.sliderLink}</a></td>
                                                        <td>${s.createDate}</td> 
                                                        <td><c:choose>
                                                                <c:when test="${!s.sliderStatus}">hiện</c:when>
                                                                <c:otherwise>ẩn</c:otherwise>
                                                            </c:choose></td> 
                                                    </tr>
                                                </c:forEach>    
                                            </tbody>
                                        </table>
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
                    <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog"
                         aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <form action="AddSlider" method="post"  enctype="multipart/form-data">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLongTitle">Thêm slider mới</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">                                           
                                        <div class="form-element form-group"> 
                                            <%
                                                        DAOProduct dao = new DAOProduct();
                                                        ResultSet rsPro = dao.getData("select * from slider order by sliderID desc limit 1");
                                                        if(rsPro.next()) {%>
                                            <input type="hidden" name ="sliderID1"  value="<%=rsPro.getInt(1) + 1%> ">
                                            <%}%>
                                            <label for="registerEmail">ID: <%=rsPro.getInt(1) + 1%></label>                                               
                                        </div>
                                        <div class="form-element">
                                            <label for="registerEmail">Mã nhân viên tạo slider: ${sessionScope.account.userID}</label>
                                            <input type="hidden" name ="userID1" value="${sessionScope.account.userID}">
                                        </div>

                                        <div class="form-element">
                                            <label>Slider: </label>
                                            <input name="sliderImage1" type= "file"
                                                   required><br>
                                        </div>
                                        <div class="form-element">
                                            <label for="registerEmail">Đường dẫn slider: </label><br>
                                            <textarea name="sliderLink1"required
                                                      >${sliderLink1}</textarea>
                                        </div>
                                        <div class="form-element">
                                            <label for="registerEmail">Ngày tạo: ${sessionScope.timetoday}</label>
                                            <input type="hidden" name ="createDate1" value="${sessionScope.timetoday}">
                                        </div>
                                        <div class="form-element">
                                            <label>Trạng thái: </label>
                                            <div style="display:flex; flex: 40%">
                                                <div class="custom-control custom-radio" style="margin-right: 15px;">
                                                    <input type="radio" id="customRadio3" name="sliderStatus1" class="custom-control-input" value="false" required>
                                                    <label class="custom-control-label" for="customRadio3">Hiện</label>
                                                </div>
                                                <div class="custom-control custom-radio">
                                                    <input type="radio" id="customRadio4" name="sliderStatus1" class="custom-control-input" value="true" required>
                                                    <label class="custom-control-label" for="customRadio4">Ẩn</label>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Thêm slider</button>
                                    </div>
                                </div>
                            </form>
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

            <!-- Page level custom scripts -->
            <script>
                                                        $(document).ready(function () {
                                                            $('#dataTable').DataTable(); // ID From dataTable 
                                                            $('#dataTableHover').DataTable(); // ID From dataTable with Hover
                                                        });
            </script>
            <script>
                function submitForm() {
                    document.getElementById('filterForm').submit();
                }
                function sliderDetail(id) {
                    var url = "sliderdetail?id=" + id;
                    window.location.href = url;
                }
            </script>
    </body>

</html>