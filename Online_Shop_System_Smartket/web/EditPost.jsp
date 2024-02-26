<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                            <h2>Chỉnh sửa <b>Bài đăng</b></h2>
                        </div>
                        <div class="col-sm-6">
                        </div>
                    </div>
                </div>
            </div>
            <div id="editEmployeeModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="editAcc" method="post" enctype="multipart/form-data">
                            <div class="modal-body">					
                                <div class="form-group">
                                    <label>ID</label>
                                    <input value="${blog.blogID}" name="id" type="text" class="form-control" readonly required>
                                </div>
                                <div class="form-group">
                                    <label>Danh mục</label>
                                    <select name="category" class="form-select" aria-label="Default select example">
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.categoryID}"<c:if test="${category.categoryID eq param.categoryId}">selected
                                                    </c:if>
                                                    >${category.categoryName}</option>
                                        </c:forEach>					
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Tác giả</label>
                                    <input value="${blog.blogAuthor}" name="author" type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Ảnh tác giả</label>
                                    <img src="images/blog_author/${blog.authorImage}" alt="Ảnh tác giả">
                                    <input type="file" 
                                           class="form-control" name="authorImg" placeholder="Enter photo" required>
                                </div>
                                <div class="form-group">
                                    <label>Ảnh bài đăng</label>
                                    <img src="images/blog/${blog.blogImage}" alt="Ảnh bài đăng">
                                    <input type="file" 
                                           class="form-control" name="blogImg" placeholder="Enter photo" required>
                                </div>
                                <div class="form-group">
                                    <label>Tiêu đề</label>
                                    <textarea name="title" class="form-control" required>${blog.blogTitle}</textarea>
                                </div>
                                <div class="form-group">
                                    <label>Nội dung</label>
                                    <textarea name="content" class="form-control" required>${blog.blogContent}</textarea>
                                </div>
                                <div class="form-group">
                                    <label>Đánh Giá</label>
                                    <input value="${blog.blogRate} sao" name="rate" type="text" class="form-control" readonly required>
                                </div>
                                <div class="form-group">
                                    <label>Trạng thái</label>
                                    <select name="hidden" class="form-select" aria-label="Default select example">
                                        <option value="Hiện" >Hiện</option>
                                        <option value="Ẩn" >Ẩn</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Ngày đăng</label>
                                        <input value="${blog.createTime}" name="date" type="datetime" class="form-control" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="submit" class="btn btn-success" value="Edit">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>


        <script src="js/manager.js" type="text/javascript"></script>
    </body>
</html>