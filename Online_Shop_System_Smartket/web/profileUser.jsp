<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/homestyle.css"/>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page import="model.DAOProduct" %>
        <%@page import="model.DAOCategories" %>
        <%@page import="model.DAOBlog" %>
        <%@page import="java.util.Vector" %>
        <%@page import="view.Product" %>
        <%@page import="view.Categories" %>
        <%@page import="view.Blog" %>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.text.DecimalFormat" %>
        <!DOCTYPE html> 
    <style>
        * {
            box-sizing: border-box
        }
        body {
            font-family: "Lato", sans-serif;
        }

        /* Style the tab */
        .tab {
            float: left;
            border: 1px solid #ccc;
            background-color: #f1f1f1;
            width: 30%;
            height: 300px;
        }

        /* Style the buttons inside the tab */
        .tab button {
            display: block;
            background-color: inherit;
            color: black;
            padding: 22px 16px;
            width: 100%;
            border: none;
            outline: none;
            text-align: left;
            cursor: pointer;
            transition: 0.3s;
            font-size: 17px;
        }

        /* Change background color of buttons on hover */
        .tab button:hover {
            background-color: #ddd;
        }

        /* Create an active/current "tab button" class */
        .tab button.active {
            background-color: #ccc;
        }

        /* Style the tab content */
        .tabcontent {
            float: left;
            padding: 0px 12px;
            border: 1px solid #ccc;
            width: 70%;
            border-left: none;
            height: 300px;
        }

        section{
            height:50vh;
        }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="css/css_footer/footer.css"/>
    <link rel="stylesheet" href="css/css_header/header.css"/>
</head>
<body>
    <jsp:include page="include/header.jsp"/>
    <section>
        <div class="tab">
            <button class="tablinks" onclick="openCity(event, 'user')" id="defaultOpen">Tài khoản</button>
            <button class="tablinks" onclick="openCity(event, 'avata')">Ảnh đại diện</button>
            <button class="tablinks" onclick="openCity(event, 'password')">Mật khẩu</button>
        </div>
        <div id="user" class="tabcontent">
            <h3>Hồ sơ</h3>
            <form action="ChangeuserinfoURL" method="post" class="form-container" >
                <div style="color: red;">${sessionScope.input}</div>
                <table border="0" >
                    <tr>
                        <th></th>
                        <th></th>
                    </tr>
                    <tr>
                        <td>Họ:</td>
                        <td>Tên:</td>
                    </tr>
                    <tr>
                        <td><input type="text" name="firstname" value="${sessionScope.account.firstName}"  /></td>
                        <td><input type="text" name="lastname" value="${sessionScope.account.lastName}"  /></td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td>Số điện thoại:</td>
                    </tr>
                    <tr>
                        <td>${sessionScope.account.email}  </td>
                        <td><input type="text" name="phonenumber" value="${sessionScope.account.phoneNumber}"  /></td>
                    </tr>
                    <tr>
                        <td>Địa chỉ:</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="address" value="${sessionScope.account.address}"  /></td>
                        <td></td>
                    </tr>
                </table>
                <button type="submit">Lưu thay đổi</button>
            </form>
        </div>
        <div id="avata" class="tabcontent">
            <form action="UploadURL" method="POST" enctype="multipart/form-data">
                <input name="photo" type= "file"> <br>
                <button type="submit">Tải lên</button>
            </form>
        </div>
        <div id="password"  class="tabcontent">
            <form action="ChangepasswordURL"  method="post"class="form-container">
                <h3>Thay đổi mật khẩu</h3>
                ${sessionScope.inputerror}<br><c:if test="${sessionScope.inputerror == null}">
                    Mật khẩu của bạn phải có ít nhất 6 ký tự, bao gồm cả chữ số, chữ cái và ký tự đặc biệt (!$@%).
                    <br>
                </c:if>
                <br> Mật khẩu hiện tại*<br>
                <input type="password" name="oldPassword" value=""  placeholder="Mật khẩu hiện tại" id="myInput1"/>
                <input type="checkbox" onclick="myFunction1()">Hiển thị mật khẩu<br>
                <br> Mật khẩu mới*<br>
                <input type="password" name="newPassword" value="" placeholder="Mật khẩu mới" id="myInput2"/>
                <input type="checkbox" onclick="myFunction2()">Hiển thị mật khẩu <br>
                <br> Nhập lại mật khẩu mới*<br>
                <input type="password" name="renewPassword" value="" placeholder="Nhập lại mật khẩu mới" id="myInput3"/>
                <input type="checkbox" onclick="myFunction3()">Hiển thị mật khẩu<br>
                <button type="submit" >Lưu mật khẩu</button>
            </form>
        </div>
        <script>

            function myFunction1() {
                var x = document.getElementById("myInput1");
                if (x.type === "password") {
                    x.type = "text";
                } else {
                    x.type = "password";
                }
            }
            function myFunction2() {
                var x = document.getElementById("myInput2");
                if (x.type === "password") {
                    x.type = "text";
                } else {
                    x.type = "password";
                }
            }
            function myFunction3() {
                var x = document.getElementById("myInput3");
                if (x.type === "password") {
                    x.type = "text";
                } else {
                    x.type = "password";
                }
            }

            function openCity(evt, name) {
                var i, tabcontent, tablinks;
                tabcontent = document.getElementsByClassName("tabcontent");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }
                tablinks = document.getElementsByClassName("tablinks");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].className = tablinks[i].className.replace(" active", "");
                }
                document.getElementById(name).style.display = "block";
                evt.currentTarget.className += " active";
            }

            // Get the element with id="defaultOpen" and click on it
            document.getElementById("defaultOpen").click();

        </script>
    </section>
    <jsp:include page="include/footer.jsp"/>
</body>




</html>
