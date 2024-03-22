<%-- 
    Document   : marketing_dashboard
    Created on : Feb 1, 2024, 10:24:26 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
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
        <title>Trang marketing</title>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/css_marketing_dashboard/marketing_dashboard_style.css" rel="stylesheet">
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

    </head>
    <%
    ResultSet rs = (ResultSet)request.getAttribute("data");
    %>
    <div class="container">
        <% String message = (String)request.getParameter("message");
        String errorMessage = (String) request.getAttribute("errorMessage");
        %>
        <% if (message != null && !message.isEmpty()) { %>
        <div class="alert alert-info" role="alert">
            <%= message %>
        </div>
        <% } %>
        <%DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);%>
        <%if (errorMessage != null) {%>
        <div class="alert alert-info" role="alert">
            <%= errorMessage %>
        </div>
        <%}%>
    </div>
    <body id="page-top">
        <div id="wrapper">
            <!-- Sidebar -->
            <ul class="navbar-nav sidebar sidebar-light accordion" id="accordionSidebar">
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="marketingDashBoardURL">
                    <div class="sidebar-brand-icon">
                        <img style="height: 91px;
                             width: 133px;
                             margin-bottom: -18px;z-index: 99;" src="images/logo/logo.png">
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
                                    <a class="dropdown-item" href="#" >
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
                            <h1 class="h3 mb-0 text-gray-800">Danh sách sản phẩm</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="marketingDashBoardURL">Trang chủ</a></li>
                                <!--<li class="breadcrumb-item">Tables</li>-->
                                <li class="breadcrumb-item active" aria-current="page">Danh sách sản phẩm</li>
                            </ol>
                        </div>
                        <!-- Row -->
                        <a href="marketingAddProductmktURL" style="margin-bottom: 10px" class="btn btn-secondary">Thêm sản phẩm mới</a>
                        <div class="row">
                            <!-- DataTable with Hover -->
                            <div class="col-lg-12">
                                <div class="card mb-4">
                                    <div class="table-responsive p-3">
                                        <table class="table align-items-center table-flush table-hover" id="dataTableHover">
                                            <div style="display: flex;
                                                 margin-left: 200px;
                                                 margin-bottom: -30px;">
                                                <form action="marketingProductListURL" method="get" id="categoryForm">
                                                    <div class="filter-group" style="display:flex;">
                                                        <div style="padding-top: 3px;">Loại</div>
                                                        <select class="form-control" name="categoryId" onchange="this.form.submit()">
                                                            <option value="">Tất cả</option>
                                                            <c:forEach var="category" items="${categories}">
                                                                <option value="${category.categoryID}"<c:if test="${category.categoryID eq param.categoryId}">selected
                                                                        </c:if>
                                                                        >${category.categoryName}</option>
                                                            </c:forEach>							
                                                        </select>
                                                    </div>
                                                    <div class="filter-group" style="display:flex;">
                                                        <div style="padding-top: 3px;">Trạng thái</div>
                                                        <select class="form-control" name="status" onchange="this.form.submit()">
                                                            <option value="">Tất cả</option>
                                                            <option value="Còn hàng" <c:if test="${fn:contains(param.status,'Còn')}">selected</c:if>>Còn hàng</option>
                                                            <option value="Hết hàng" <c:if test="${fn:contains(param.status,'Hết')}">selected</c:if>>Hết hàng</option>
                                                            </select>
                                                        </div>
                                                        <input type="submit" style="display: none;">
                                                    </form>
                                                </div>
                                                <thead class="thead-light">
                                                    <tr>
                                                        <th>ID</th>
                                                        <th style="height: 100px">Ảnh</th>
                                                        <th>Tiêu đề</th>
                                                        <th style="min-width: 102px;">Loại sản phẩm</th>
                                                        <th style="max-width: 56px;">Giá</th>
                                                        <th>Trạng thái</th>						
                                                        <th>Hành động</th>
                                                    </tr>
                                                </thead>
                                                <tfoot>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th style="height: 100px">Ảnh</th>
                                                        <th>Tiêu đề</th>
                                                        <th style="min-width: 102px;">Loại sản phẩm</th>
                                                        <th style="max-width: 56px;">Giá</th>
                                                        <th style="width:87px; padding-left: 20px;">Trạng thái</th>						
                                                        <th>Hành động</th>
                                                    </tr>
                                                </tfoot>
                                                <tbody>
                                                    <!-- Iterate over the result set -->
                                                <% try {
                                                    while(rs.next()) {
                                                        int unitInStock = rs.getInt("UnitInStock");
                                                        int totalStock = rs.getInt("TotalStock");
                                                        String status = (unitInStock > 0 && unitInStock <= totalStock) ? "Còn Hàng" : "Hết Hàng";
                                                %>
                                                <tr>
                                                    <td><%=rs.getInt("ProductID")%></td>
                                                    <td><img style="width: 100px" src="<%=rs.getString("ProductURLShow")%>"/></td>
                                                    <td><%=rs.getString("ProductName")%></td>
                                                    <td><%=rs.getString("CategoryName")%></td>
                                                    <td><%= df.format(rs.getDouble("UnitPrice")) %></td>
                                                    <td><%= status %></td>
                                                    <td>
                                                        <div class="dropdown">
                                                            <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                Hành động
                                                            </button>
                                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                                <a class="dropdown-item" href="marketingViewProductURL?productId=<%= rs.getInt("ProductID") %>">Xem</a>
                                                                <a class="dropdown-item" href="marketingEditProduct?productId=<%= rs.getInt("ProductID") %>">Chỉnh sửa</a>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <% }
                                                   } catch (SQLException ex) {
                                                   }
                                                %>
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
        <script src="js_marketing/productlist.js"></script>
        <!-- Page level custom scripts -->
        <script>
                                                            $(document).ready(function () {
                                                                $('#dataTableHover').DataTable(); // ID From dataTable with Hover
                                                            });
        </script>
        <script>
            function submitForm() {
                document.getElementById('filterForm').submit();
            }
        </script>
    </body>

</html>