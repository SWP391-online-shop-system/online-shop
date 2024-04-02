<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Sửa bài viết</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/css_marketing_dashboard/marketing_dashboard_style.css" rel="stylesheet">
        <!--<link href="css/css_customerlist/detail.css" rel="stylesheet">-->
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">

        <style>
            img{
                width: 200px;
                height: 120px;
            }
            .container {
                display: flex;

            }
        </style>
    <body>
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
                            <h1 class="h3 mb-0 text-gray-800">Thêm bài viết</h1>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="./">Trang Chủ</a></li>
                                <li class="breadcrumb-item active">Thêm bài viết</li>
                            </ol>
                        </div>
                        <div id="editEmployeeModal">
                            <div class="modal-dialog">

                                <div class="modal-content">
                                    <form id="myForm" action="marketingAddPost" method="post" enctype="multipart/form-data">
                                        <input type="hidden" name="service" value="upload"/>
                                        <div class="modal-body">					
                                            <div class="form-group">
                                                <label>Danh mục</label>
                                                <select class="form-control" name="categoryId">
                                                    <c:forEach var="category" items="${category}">
                                                        <option value="${category.categoryID}">${category.categoryName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label>Tác giả</label>
                                                <input name="author" type="text" class="form-control" required>
                                            </div>
                                            <div class="form-group">
                                                <label>Ảnh tác giả</label>
                                                <img id="author-image" style="width: 350px;height: 200px;padding-left: 56px;padding-bottom: 15px" src="images/blog_author/" alt="Ảnh tác giả">
                                                <input type="file" 
                                                       class="form-control" name="authorImg" placeholder="Enter photo" id="author-img-input">
                                            </div>
                                            <div class="form-group">
                                                <label>Ảnh bài đăng</label>
                                                <img  id="blog-image" style="width: 350px;height: 200px;padding-left: 45px;padding-bottom: 15px;padding-right: 12px"src="images/blog/" alt="Ảnh bài đăng">
                                                <input type="file" 
                                                       class="form-control" name="blogImg" placeholder="Enter photo" id="blog-img-input">
                                            </div>
                                            <div class="form-group">
                                                <label>Tiêu đề</label>
                                                <input  name="title" type="text" class="form-control" required>
                                            </div>
                                            <div class="form-group">
                                                <label>Nội dung</label>
                                                <textarea name="content" class="form-control" minlength="150" required></textarea>
                                            </div>
                                            <div class="form-group">
                                                <label>Trạng thái</label>
                                                <select name="hidden" class="form-select" aria-label="Default select example">
                                                    <option value="0">Kích hoạt</option>
                                                    <option value="1">Vô hiệu hóa</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="button" class="btn btn-danger" value="Quay lại" onclick="window.location.href = 'marketingPost';">
                                            <input type="submit" class="btn btn-success" value="Thêm bài đăng">
                                        </div>

                                    </form>
                                </div>
                            </div>
                        </div>

                    </div>
                    <script src="vendor/jquery/jquery.min.js"></script>
                    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
                    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
                    <script src="vendor/datatables/jquery.dataTables.min.js"></script>
                    <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>
                    <script src="js/manager.js" type="text/javascript"></script>
                    <script>
                        document.getElementById('author-img-input').addEventListener('change', function (e) {
                            var reader = new FileReader();
                            reader.onload = function (event) {
                                document.getElementById('author-image').src = event.target.result;
                            };
                            reader.readAsDataURL(e.target.files[0]);
                        });

                        document.getElementById('blog-img-input').addEventListener('change', function (e) {
                            var reader = new FileReader();
                            reader.onload = function (event) {
                                document.getElementById('blog-image').src = event.target.result;
                            };
                            reader.readAsDataURL(e.target.files[0]);
                        });

                        var form = document.getElementById("myForm");

                        form.addEventListener("submit", function (event) {
                            event.preventDefault(); // Ngăn chặn hành vi mặc định của biểu mẫu

                            var textarea = form.querySelector('textarea[name="content"]');
                            var contentLength = textarea.value.length;

                            if (contentLength < 150) {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Lỗi',
                                    text: 'Nội dung phải có ít nhất 150 ký tự.'
                                });
                            } else {
                                // Gửi biểu mẫu nếu điều kiện hợp lệ
                                form.submit();
                            }
                        });
                    </script>
                    <a class="scroll-to-top rounded" href="#page-top">
                        <i class="fas fa-angle-up"></i>
                    </a>
                    </body>
                    </html>