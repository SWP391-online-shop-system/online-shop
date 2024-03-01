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
                            <h2>Thông tin<b>Bài đăng</b></h2>
                        </div>
                        <div class="col-sm-6">
                        </div>
                    </div>
                </div>
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