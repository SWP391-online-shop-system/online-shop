<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
        <style>
            img{
                width: 200px;
                height: 120px;
            }
        </style>
    <body>
        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>Thêm <b>Bài đăng</b></h2>
                        </div>
                        <div class="col-sm-6">
                        </div>
                    </div>
                </div>
            </div>
            <div id="editEmployeeModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="addPost" method="post" enctype="multipart/form-data">
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
                                    <textarea name="content" class="form-control" required></textarea>
                                </div>
                                <div class="form-group">
                                    <label>Trạng thái</label>
                                    <select name="hidden" class="form-select" aria-label="Default select example">
                                        <option value="1">Hiện</option>
                                        <option value="0">Ẩn</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-danger" value="Quay lại" onclick="window.location.href='mtkPost';">
                                <input type="submit" class="btn btn-success" value="Thêm bài đăng">
                            </div>
                                
                        </form>
                    </div>
                </div>
            </div>

        </div>
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
        </script>
        <script src="js/manager.js" type="text/javascript"></script>
    </body>
</html>