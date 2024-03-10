<!DOCTYPE html> 
<html lang="en"> 
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8"%>
    <%@page import="java.sql.ResultSet"%>
    <%@page import="java.text.DecimalFormat" %>
    <%@page import="view.*" %>
    <%@page import="model.*" %>
    <head> 
        <meta charset="UTF-8"> 
        <meta name="viewport"
              content="width=device-width,initial-scale=1.0"> 
        <title>Responsive Form Card</title> 
        <link rel="stylesheet" href= 
              "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"> 
        <link rel="stylesheet" href="index.css"> 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/css_marketing_dashboard/marketing_dashboard_style.css" rel="stylesheet">
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">

    </head> 
    <style>
        /*style.css */

        *{
            margin: 0;
            padding: 0;
        }
        .rate {
            float: left;
            height: 46px;
            padding: 0 10px;
        }
        .rate:not(:checked) > input {
            position:absolute;
            top:-9999px;
        }
        .rate:not(:checked) > label {
            float:right;
            width:1em;
            overflow:hidden;
            white-space:nowrap;
            cursor:pointer;
            font-size:30px;
            color:#ccc;
        }
        .rate:not(:checked) > label:before {
            content: '★ ';
        }
        .rate > input:checked ~ label {
            color: #ffc700;
        }
        .rate:not(:checked) > label:hover,
        .rate:not(:checked) > label:hover ~ label {
            color: #deb217;
        }
        .rate > input:checked + label:hover,
        .rate > input:checked + label:hover ~ label,
        .rate > input:checked ~ label:hover,
        .rate > input:checked ~ label:hover ~ label,
        .rate > label:hover ~ input:checked ~ label {
            color: #c59b08;
        }

        body {
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: space-around;
            flex-direction: column;
            height: 100vh;
            background-color: #fff;
            font-family: 'Poppins', sans-serif;

        }

        .textup {
            text-align: center;
            color: rgb(11, 118, 11);
            font-weight: 700;
        }

        i {
            margin-right: 3px;
        }

        .form-box {
            background-color: #fff;
            box-shadow: 0 0 10px rgba(36, 67, 40, 0.8);
            padding: 15px;
            border-radius: 8px;
            width: 500px;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
        }

        .radio-group {
            display: flex;
            margin-bottom: 16px;
        }

        input[type="radio"] {
            margin-right: 8px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-size: 17px;
            color: green;
            font-weight: 600;
        }

        input,
        textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 12px;
            box-sizing: border-box;
            border-radius: 10px;

        }

        button {
            background-color: #368b44;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            width: 100%;
            font-size: 15px;
            transition: .2s linear;
        }

        button:hover {
            background-color: #0a6808;
            border: none;
            transform: translateY(-10px);
        }

        h1 {
            color: green;
        }
    </style>
    <body> 
        <%DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);%>
        <%
                      Product pro = new Product();
                      DAOProduct daoPro = new DAOProduct();
                      ResultSet rsProduct = (ResultSet)request.getAttribute("rsProduct");
                      if(rsProduct.next()){
        %>
        <div style="display:flex; margin-left: 150px;">
            <div class="form-box" style="height: 380px; width: 330px"> 
                <div style="margin-bottom: 25px;
                     font-size: 20px;" class="textup"> 
                    <i  class="fa fa-solid "></i> 
                    <%=rsProduct.getString("ProductName")%>
                </div> 
                <div class="form-group">
                    <img style="width: 300px;height: 200px;" src="<%=rsProduct.getString("ProductURL")%>" alt="">
                </div>
                <div style="margin-bottom: 25px;
                     font-size: 20px;" class="textup"> 
                    <i  class="fa fa-solid "></i> 
                    Giá bán: <%= df.format(rsProduct.getDouble("UnitPrice"))%>đ
                </div> 
            </div> 
            <div class="form-box"> 
                <div style="margin-bottom: 25px;
                     font-size: 20px;" class="textup"> 
                    <i  class="fa fa-solid fa-clock"></i> 
                    Chỉ mất 2 phút, hãy để lại phản hồi của bạn!
                </div> 
                <form id="myForm" action="feedback" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="service" value="upload"/>
                    <input type="hidden" name="ProductID" value="<%=rsProduct.getInt("ProductID")%>"/>
                    <div class="form-group">
                        <label>Ảnh đính kèm</label>
                        <img id="feedback-image" style="width: 350px;height: 200px;" src="images/feedback/" alt="chọn ảnh đính kèm">
                        <input value=""  type="file" 
                               class="form-control" name="feedbackImg" placeholder="Enter photo" id="feedback-img-input">
                    </div>
                    <div class="form-group">
                        <div style="display: flex; align-items: center">
                            <label for="rating">Đánh giá:</label>
                            <div style="margin-bottom: 4px;" class="rate">
                                <input type="radio" id="star5" name="rate" value="5" />
                                <label style="font-size: 25px;" for="star5" title="text">5 stars</label>
                                <input type="radio" id="star4" name="rate" value="4" />
                                <label style="font-size: 25px;" for="star4" title="text">4 stars</label>
                                <input type="radio" id="star3" name="rate" value="3" />
                                <label style="font-size: 25px;" for="star3" title="text">3 stars</label>
                                <input type="radio" id="star2" name="rate" value="2" />
                                <label style="font-size: 25px;" for="star2" title="text">2 stars</label>
                                <input type="radio" id="star1" name="rate" value="1" />
                                <label style="font-size: 25px;" for="star1" title="text">1 star</label>
                            </div>
                        </div>                  
                        <label for="msg"> 
                            <i class="fa-solid fa-comments" 
                               style="margin-right: 3px;"></i> 
                            Thêm nhận xét của bạn tại đây: 
                        </label> 
                        <textarea id="msg" name="msg" 
                                  rows="4" cols="10" required> 
                        </textarea> 
                        <button type="submit"> 
                            Tạo đánh giá 
                        </button> 
                    </div>
                    <%}%>
                </form> 
            </div> 
        </div> 
    </body> 
    <script>
        document.getElementById('feedback-img-input').addEventListener('change', function (e) {
            var reader = new FileReader();
            reader.onload = function (event) {
                document.getElementById('feedback-image').src = event.target.result;
            };
            reader.readAsDataURL(e.target.files[0]);
        });
        var form = document.getElementById("myForm");

        form.addEventListener("submit", function (event) {
            event.preventDefault(); // Ngăn chặn hành vi mặc định của biểu mẫu

            var textarea = form.querySelector('textarea[name="msg"]');
            var content = textarea.value.trim(); // Lấy nội dung và xóa khoảng trắng đầu và cuối chuỗi

            if (content === "") {
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi',
                    text: 'Hãy điền nội dung'
                });
            } else if (content.length > 250) {
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi',
                    text: 'Nội dung phải có ít hơn 250 ký tự.'
                });
            } else {
                // Gửi biểu mẫu nếu điều kiện hợp lệ
                form.submit();
            }
        });
    </script>
    <script src="js/manager.js" type="text/javascript"></script>
</html>
