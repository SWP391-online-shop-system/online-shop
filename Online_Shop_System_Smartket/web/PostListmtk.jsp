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
        <title>Trang marketing</title>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/css_marketing_dashboard/marketing_dashboard_style.css" rel="stylesheet">
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <style>
            .filter-group select.form-control {
                width: 102px;
                height: 31px;
                font-size: 13px;
                margin-left: 14px;
                margin-right: 21px;
                padding: 4px;
            }
            #statuss{
                width: 85px;
                height: 24px;
                font-size: 14px;
                color: white;
                background: #66bb6a;
                border: none;
                border-radius: 4px;
            }
        </style>
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
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="MarketingDashBoardURL">
                    <div class="sidebar-brand-icon">
                        <img style="height: 91px;
                             width: 133px;
                             margin-bottom: -18px;z-index: 99;" src="images/logo/logo.png">
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
                        <a class="nav-link" href="mtkPost">
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
                                    <span class="ml-2 d-none d-lg-inline text-white small"></span>
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
                            <h1 class="h3 mb-0 text-gray-800">Bài đăng</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="./">Trang chủ</a></li>
                                <!--<li class="breadcrumb-item">Tables</li>-->
                                <li class="breadcrumb-item active" aria-current="page">Bài đăng</li>
                            </ol>
                        </div>
                        <!-- Row -->
                        <script>
                            function submitForm() {
                                document.getElementById('filterForm').submit();
                            }
                        </script>

                        <a style="margin-bottom: 10px;" href="addPost?service=addPost" class="btn btn-secondary">Thêm bài viết mới</a>
                        <div class="row">
                            <!-- DataTable with Hover -->
                            <div class="col-lg-12">
                                <div class="card mb-4">
                                    <div class="table-responsive p-3">
                                        <table class="table align-items-center table-flush table-hover" id="dataTableHover">
                                            <div style="display: inline-grid;
                                                 margin-left: 200px;
                                                 margin-bottom: -30px;">
                                                <form action="mtkPost" method="get" id="categoryForm">
                                                    <div style="display: flex;margin-left: -19px;">
                                                        <div class="filter-group" style="display:flex;">
                                                            <div style="padding-top: 3px;">Danh mục</div>
                                                            <select class="form-control" name="categoryId" onchange="this.form.submit()">
                                                                <option value="">Tất cả</option>
                                                                <c:forEach var="category" items="${categories}">
                                                                    <option value="${category.categoryID}"<c:if test="${category.categoryID eq param.categoryId}">selected
                                                                            </c:if>
                                                                            >${category.categoryName}</option>
                                                                </c:forEach>							
                                                            </select>
                                                        </div>
                                                        <!-- Your other form elements -->
                                                        <div class="filter-group" style="display:flex;">
                                                            <div style="padding-top: 3px;">Tác Giả</div>
                                                            <select class="form-control" name="author" onchange="this.form.submit()">
                                                                <option value="">Tất cả</option>
                                                                <c:forEach var="author" items="${author}">
                                                                    <option value="${author.blogAuthor}" <c:if test="${author.blogAuthor eq check}">selected
                                                                            </c:if>
                                                                            >${author.blogAuthor}</option>
                                                                </c:forEach>							
                                                            </select>
                                                        </div>
                                                        <input type="submit" style="display: none;">
                                                        <div class="filter-group" style="display:flex;">
                                                            <div style="padding-top: 3px;">Trạng thái</div>
                                                            <select class="form-control" name="status" onchange="this.form.submit()">
                                                                <option value="">Tất cả</option>
                                                                <option value="Ẩn" <c:if test="${fn:contains(param.status,'Vô hiệu hóa')}">selected</c:if>>Vô hiệu hóa</option>
                                                                <option value="Hiện" <c:if test="${fn:contains(param.status,'Kích hoạt')}">selected</c:if>>Kích hoạt</option>
                                                                </select>
                                                            </div>
                                                            <input type="submit" style="display: none;">
                                                        </div>
                                                    </form>
                                                </div>

                                                <thead class="thead-light">
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Ảnh</th>
                                                        <th style="min-width: 220px;">Tiêu đề</th>
                                                        <th style="min-width: 70px">Tác Giả</th>
                                                        <th style="min-width: 150px;">Danh mục</th>
                                                        <th style="min-width: 90px;">Đánh Giá</th>
                                                        <th>Trạng thái</th>		
                                                        <th style="min-width: 120px">Ngày đăng</th>
                                                        <th>Hành động</th>
                                                    </tr>
                                                </thead>
                                                <tfoot>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Ảnh</th>
                                                        <th>Tiêu đề</th>
                                                        <th>Tác Giả</th>
                                                        <th>Danh mục</th>
                                                        <th>Đánh Giá</th>
                                                        <th style="width:87px; padding-left: 20px;">Trạng thái</th>	
                                                        <th style="width:98px">Ngày đăng</th>
                                                        <th>Hành động</th>
                                                    </tr>
                                                </tfoot>
                                                <tbody>
                                                    <!-- Iterate over the result set -->
                                                <% try {
                                                    while(rs.next()) {
                                                        boolean HiddenStatus = rs.getBoolean("HiddenStatus");
                                                        String hidden = (HiddenStatus) ? "0" : "1";
                                                        String status = (HiddenStatus) ? "Kích hoạt" : "Vô hiệu hóa";
                                                        int BlogID = rs.getInt("BlogID");
                                                %>
                                                <tr>
                                                    <td><%=rs.getInt("BlogID")%></td>
                                                    <td><img style="width: 100px" src="images/blog/<%=rs.getString("BlogImage")%>"/></td>
                                                    <td><%=rs.getString("BlogTitle")%></td>
                                                    <td><%=rs.getString("BlogAuthor")%></td>
                                                    <td><%=rs.getString("CategoryName")%></td>
                                                    <td><%=rs.getInt("BlogRate")%> sao</td>
                                                    <td>
                                                        <input id="statuss" style="<%=status.equals("Kích hoạt")?"":"background: red;"%>" type="button" value="<%= status %>" onclick="window.location.href = 'mtkPost?BlogID=<%=rs.getInt("BlogID")%>&hidden=<%= hidden %>';">
                                                    </td>
                                                    <td><%=rs.getDate("CreateTime")%> </td>
                                                    <td>
                                                        <div class="dropdown">
                                                            <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                Hành động
                                                            </button>
                                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                                <a class="dropdown-item" href="view?BlogID=<%=rs.getInt("BlogID")%>">Xem</a>
                                                                <a class="dropdown-item" href="editPost?BlogID=<%= rs.getInt("BlogID") %>">Chỉnh sửa</a>
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
    </body>

</html>