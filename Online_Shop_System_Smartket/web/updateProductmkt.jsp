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
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
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
            .btnUpdate{
                text-align: center;
                margin-left: 45%;
                width: 93px;
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
        </style>
    </head>
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
                            <h1 class="h3 mb-0 text-gray-800">Cập nhật sản phẩm</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="marketingDashBoardURL">Trang chủ</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Cập nhật sản phẩm</li>
                            </ol>
                        </div>
                        <form action="marketingEditProduct" method="post" enctype='multipart/form-data' onsubmit="return validateForm()">
                            <div style="display: flex;">
                                <div class="card-body">
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
                                                    Product p1 = (Product)request.getAttribute("product");
                                                    Vector<Categories> categories = dao.getCategories("Select * from categories");
                                                    for(Categories categ: categories){%>
                                                <option value="<%=categ.getCategoryID()%>"<%=categ.getCategoryID()== p1.getCategoryID() ? "selected": ""%> ><%=categ.getCategoryName()%></option>
                                                <%}%>
                                            </select>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <p class="mb-0">Mô tả sản phẩm</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <textarea name="productDescription"style="width: 300px;height: 140px;color: #a4a4a4;" value="${product.productDescription}">${product.productDescription}</textarea>
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
                                    <input type="hidden" name="createDate" value="${product.createDate}">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <p class="mb-0">Tổng số sản phẩm</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <input type="number" name="totalStock" id="totalStock" value="${product.totalStock}" readonly>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <p class="mb-0">Trạng thái</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <select name="productStatus" id="productStatus">
                                                <option value="0" ${product.productStatus ? 'selected' : ''}>Kích Hoạt</option>
                                                <option value="1" ${product.productStatus ? 'selected' : ''}>Vô hiệu hóa</option>
                                            </select>
                                        </div>
                                    </div>

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
                                </div>
                                <div style="flex: 0 0 40%;border-left: 1px dashed;">
                                    <div class="card-body mb-8" style="flex: 0 0 40%;
                                         max-width: 40%;
                                         background: white;
                                         border-radius: 10px;
                                         margin-left: 15px;
                                         max-width: 40%">
                                        <div style="margin-left: 171px;
                                             font-size: 20px;">Ảnh</div>

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
                                        int radioChoice = (int)request.getAttribute("radioChoice");
                                        while (rss.next()) {
                                            count++;
                                        %>
                                        <div class="card-body text-center" style="width: 187px; margin-bottom: 20px;">
                                            <div style="display: flex;">
                                                <img style="min-width: 100px; height: 100px; width: 100px; margin-bottom: 5px;" src="<%=rss.getString(2)%>" alt="alt" />
                                                <div style="flex: 0 0 89%; margin-top: 36px; margin-left: 50px">
                                                    <input type="radio" id="html<%=count%>" name="default" <%=radioChoice==count?"checked":""%> onclick="handleRadioClick('html<%=count%>')"  value="<%=count%>" style="">
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
                                    </div>
                                </div>
                            </div>
                            <button class="btnUpdate"type="submit" value="Lưu">Lưu</button>
                        </form>
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
                                    <%ResultSet logger = (ResultSet)request.getAttribute("log");
                                        int countLog = 0;
                                    while(logger.next()){
                                    countLog++;
                                        DAOUser daoU = new DAOUser();
                                        ResultSet mkt = daoU.getData("SELECT * FROM online_shop_system.user where userID = " + logger.getInt(2));
                                    %>
                                    <p id="logcheck" style="margin-bottom: 15px;"><%=countLog%> - <%while(mkt.next()){%>Nhân viên <%=mkt.getString("FirstName")+" "+mkt.getString("LastName")%> <%}%>
                                        <%=logger.getString(4)%> vào <span style="color: black;"><%=logger.getString(3).substring(0,10)%>, lúc <%=logger.getString(3).substring(10)%></span></p>
                                        <%}%>
                                </div>                                         
                            </div>
                        </div>
                    </div>
                </div>
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
                </body>
                </html>