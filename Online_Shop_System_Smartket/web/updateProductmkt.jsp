<%-- 
    Document   : test
    Created on : Feb 22, 2024, 5:39:39 PM
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
    <body id="page-top">
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
                        <a class="nav-link" href="mktProductListURL">
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
                            <h1 class="h3 mb-0 text-gray-800">Cập nhật sản phẩm</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="HomePageURL">Trang chủ</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Cập nhật sản phẩm</li>
                            </ol>
                        </div>
                        <div class="row">
                            <div class="card mb-4" style="flex: 0 0 54%;">
                                <div class="card-body">
                                    <form action="EditProductmktURL" method="post" enctype='multipart/form-data' onsubmit="return validateForm()">
                                        <input type="hidden" name="service" value="update">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <p class="mb-0">ID</p>
                                            </div>
                                            <div class="col-sm-9">
                                                <input type="text" name="productId" value="${product.productID}" readonly>
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <p class="mb-0">Tên sản phẩm</p>
                                            </div>
                                            <div class="col-sm-9">
                                                <input type="text" name="productName" value="${product.productName}">
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
                                                        DAOCategories dao = new DAOCategories();
                                                        Vector<Categories> categories = dao.getCategories("Select * from categories");
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
                                                <textarea name="productDescription"style="width: 300px;height: 140px;color: #858585;" value="${product.productDescription}"></textarea>
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <p class="mb-0">Hàng trong kho</p>
                                            </div>
                                            <div class="col-sm-9">
                                                <input type="number" name="unitInStock" id="unitInStock" value="${product.unitInStock}">
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <p class="mb-0">Giá bán</p>
                                            </div>
                                            <div class="col-sm-9">
                                                <input type="number" name="unitPrice" value="${product.unitPrice}">
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <p class="mb-0">Giảm giá</p>
                                            </div>
                                            <div class="col-sm-9">
                                                <input type="number" name="unitDiscount" value="${product.unitDiscount}">
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <p class="mb-0">Ngày tạo</p>
                                            </div>
                                            <div class="col-sm-9">
                                                <input type="date" name="createDate" value="${product.createDate}">
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <p class="mb-0">Tổng số sản phẩm</p>
                                            </div>
                                            <div class="col-sm-9">
                                                <input type="number" name="totalStock" id="totalStock" value="${product.totalStock}">
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <p class="mb-0">Trạng thái sản phẩm</p>
                                            </div>
                                            <div class="col-sm-9">
                                                <select name="productStatus" id="productStatus">
                                                    <option value="0" ${productStatus == 0 ? 'selected' : ''}>Kích Hoạt</option>
                                                    <option value="1" ${productStatus == 1 ? 'selected' : ''}>Vô hiệu hóa</option>
                                                </select>
                                            </div>
                                        </div>
                                        <input type="submit" value="Update">
                                    </form>
                                </div>
                            </div>
                            <div class="card-body mb-8" style="flex: 0 0 40%;
                                 max-width: 40%;
                                 background: white;
                                 border-radius: 10px;
                                 margin-left: 15px;
                                 max-width: 40%">
                                <div style="margin-left: 70px">Ảnh</div>
                                <script>
                                    function handleRadioClick(clickedId) {
                                        var radios = document.querySelectorAll('input[type="radio"]');
                                        radios.forEach(function (radio) {
                                            if (radio.id !== clickedId) {
                                                radio.checked = false;
                                            }
                                        });
                                    }
                                </script>

                                <form action="EditProductmktURL" enctype='multipart/form-data' method="post">
                                    <% int count = 0;
                                    int cateId = 0;
                                    Product p = (Product) request.getAttribute("product");
                                    DAOProductImage daoPi = new DAOProductImage();
                                    ProductImage pi = daoPi.getProductImageByProductID(p.getProductID());
                                    ResultSet cate = daoPi.getData("select * from product where productID = " + p.getProductID());
                                    while (cate.next()) {
                                        cateId = cate.getInt("CategoryID");
                                    }
                                    ResultSet rss = daoPi.getData("select * from ProductImage where ProductId = " + p.getProductID());
                                    while (rss.next()) {
                                        count++;
                                        System.out.println("count in jsp = "+count);
                                        String paths = "D:\\Workspace\\SPRING2024\\online_shop_system\\Online_Shop_System_Smartket\\web\\" + rss.getString(3).replaceAll("/", "\\\\");
                                    %>
                                    <div class="card-body text-center" style="width: 187px;">
                                        <div style="display: flex;">
                                            <input type="hidden" name="service" value="updateImg" />
                                            <img style="min-width: 100px; height: 100px; width: 100px; margin-bottom: 5px;" src="<%=rss.getString(2)%>" alt="alt" />
                                            <div style="flex: 0 0 89%; margin-top: 36px; margin-left: 50px">
                                                <input type="radio" id="html<%=count%>" name="default" onclick="handleRadioClick('html<%=count%>')" value="<%=count%>" style="">
                                                <label for="html<%=count%>" style="font-size: 10px">Ảnh mặc định</label><br>
                                            </div>
                                        </div>
                                        <input type="file" style="font-size: 12px;" name="productImageUrl<%=count%>" id="productImageUrl" value="<%=rss.getString(2)%>">
                                        <input type="hidden" name="oldImageUrl<%=count%>" value="<%=rss.getString(2)%>">
                                        <input type="hidden" name="cateId" value="<%=cateId%>">
                                        <input type="hidden" name="proId" value="<%=rss.getInt(1)%>">
                                    </div>
                                    <%}%>
                                    <input type="hidden" name="countImg" value="<%=count%>">
                                    <button class="buttonsubmit-update" type="submit">Lưu</button>
                                </form>
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