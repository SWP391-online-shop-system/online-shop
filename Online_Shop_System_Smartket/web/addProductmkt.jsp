<%-- 
    Document   : updateProductmkt
    Created on : Feb 15, 2024, 10:12:26 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="view.*" %>
<%@page import="model.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@page import="java.sql.ResultSet, java.sql.SQLException, java.util.Vector"%>
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
        Product product = (Product)request.getAttribute("product");
    %>
    <style>
        .btnUpdate{
            text-align: center;
            margin-left: 45%;
            width: 125px;
            border-radius: 4px;
            background: #66bb6a;
            color: white;
            padding-bottom: 4px;
            transition: all 0.5s;
            border: none;
        }
        .btnUpdate:hover{
            transform: scale(0.95);
        }
        input, select, textarea{
            width : 200px;
        }
    </style>
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
                            <h1 class="h3 mb-0 text-gray-800">Thêm sản phẩm</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="mktProductListURL">Trang sản phẩm</a></li>
                                <!--<li class="breadcrumb-item">Tables</li>-->
                                <li class="breadcrumb-item active" aria-current="page">Thêm sản phẩm</li>
                            </ol>
                        </div>
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <form action="AddProductmktURL" method="post" enctype='multipart/form-data' onsubmit="return validateForm()">
                                            <%
                                                        DAOProduct dao = new DAOProduct();
                                                        ResultSet rsPro = dao.getData("select * from Product order by ProductID desc limit 1");
                                                        if(rsPro.next()) {%>
                                            <input type="hidden" name ="productID" value="<%=rsPro.getInt(1) + 1%>">
                                            <%}%>
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <p class="mb-0">Tên sản phẩm</p>
                                                </div>
                                                <div class="col-sm-9">
                                                    <input type="text" name="productName" value="${productName}" required>
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <p class="mb-0">Loại sản phẩm</p>
                                                </div>
                                                <div class="col-sm-9">
                                                    <select name="categoryId">
                                                        <%
                                                            DAOCategories daoct = new DAOCategories();
                                                            Vector<Categories> categories = daoct.getCategories("Select * from categories");
                                                            for (Categories category : categories) {
                                                                out.println("<option value='" + category.getCategoryID() + "'>" + category.getCategoryName() + "</option>");
                                                            }
                                                        %>
                                                    </select>
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <p class="mb-0">Mô tả sản phẩm</p>
                                                </div>
                                                <div class="col-sm-9">
                                                    <textarea name="productDescription" required>${productDescription}</textarea>
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <p class="mb-0">Hàng trong kho</p>
                                                </div>
                                                <div class="col-sm-9">
                                                    <input type="number" required name="unitInStock" id="unitInStock" value="${unitInStock}">
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <p class="mb-0">Giá bán</p>
                                                </div>
                                                <div class="col-sm-9">
                                                    <input type="number" required name="unitPrice" value="${unitPrice}">
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <p class="mb-0">Giảm giá(%)</p>
                                                </div>
                                                <div class="col-sm-9">
                                                    <input type="number" required name="unitDiscount" value="${unitDiscount}">
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <p class="mb-0">Tổng số sản phẩm</p>
                                                </div>
                                                <div class="col-sm-9">
                                                    <input type="number" required name="totalStock" id="totalStock" value="${totalStock}">
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <p class="mb-0">Ảnh sản phẩm</p>
                                                </div>
                                                <div class="col-sm-9">
                                                    <input type="file" required name="productImageUrl" multiple>
                                                </div>
                                            </div>
                                            <button class="btnUpdate" type="submit" style="height: 33px;
                                                    font-size: 14px;
                                                    margin: 20px;
                                                    margin-left: -2px;margin-right: 47px;" name="submit" value="Thêm sản phẩm">Thêm sản phẩm</button>
                                            <button class="btnUpdate" type="reset" style="height: 33px;
                                                    font-size: 14px;
                                                    margin: 20px;
                                                    margin-left: -2px;" value="Xóa hết">Xóa hết</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </body>
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
                        </html>