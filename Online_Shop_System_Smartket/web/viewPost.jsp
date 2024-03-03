<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Thông tin bài viết</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/css_marketing_dashboard/marketing_dashboard_style.css" rel="stylesheet">
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
        
        <style>
            img{
                width: 200px;
                height: 120px;
            }
        </style>
    <body>
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
                            <h1 class="h3 mb-0 text-gray-800">Thông tin bài biết</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="./">Trang Chủ</a></li>
                                <li class="breadcrumb-item active">Thông tin bài biết</li>
                            </ol>
                        </div>
            <div id="editEmployeeModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="view" method="post" >
                            <div class="modal-body">					
                                <div class="form-group">
                                    <label>ID</label>
                                    <input value="${blog.blogID}" name="BlogID" type="text" class="form-control" readonly required>
                                </div>
                                <div class="form-group">
                                    <label>Danh mục</label>
                                    <c:forEach var="category" items="${category}">
                                        <c:choose>
                                            <c:when test="${blog.categoryID == category.categoryID}">
                                                <input value="${category.categoryName}" name="author" type="text" class="form-control" readonly required>
                                            </c:when>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                <div class="form-group">
                                    <label>Tác giả</label>
                                    <input value="${blog.blogAuthor}" name="author" type="text" class="form-control"readonly required>
                                </div>
                                <div class="form-group">
                                    <label>Ảnh tác giả</label>
                                    <img style="width: 350px;height: 200px;padding-left: 56px;padding-bottom: 15px" src="images/blog_author/${blog.authorImage}" alt="Ảnh tác giả">
                                </div>
                                <div class="form-group">
                                    <label>Ảnh bài đăng</label>
                                    <img style="width: 350px;height: 200px;padding-left: 45px;padding-bottom: 15px;padding-right: 12px" src="images/blog/${blog.blogImage}" alt="Ảnh bài đăng">
                                </div>
                                <div class="form-group">
                                    <label>Tiêu đề</label>
                                    <input value="${blog.blogTitle}" name="title" type="text" class="form-control"readonly required>
                                </div>
                                <div class="form-group">
                                    <label>Nội dung</label>
                                    <textarea name="content" class="form-control"readonly required>${blog.blogContent}</textarea>
                                </div>
                                <div class="form-group">
                                    <label>Trạng thái</label>
                                    <input value="${blog.hiddenStatus == 1 ? 'Hiện' : 'Ẩn'}" name="rate" type="text" class="form-control" readonly required>
                                </div>
                                <div class="form-group">
                                    <label>Đánh giá</label>
                                    <input value="${blog.blogRate} sao" name="rate" type="text" class="form-control" readonly required>
                                </div>
                                <div class="form-group">
                                    <label>Ngày đăng</label>
                                    <input value="${blog.createTime}" name="date" type="datetime" class="form-control"readonly required>
                                </div>
                                <div class="modal-footer">
                                <input type="button" class="btn btn-danger" value="Quay lại trang quản lí" onclick="window.location.href='mtkPost';">
                                <input type="button" class="btn btn-success" value="Cập nhật lại" onclick="window.location.href='editPost?BlogID=${blog.blogID}';">
                            </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>

        <script src="js/manager.js" type="text/javascript"></script>
    </body>
</html>