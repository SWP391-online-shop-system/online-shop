<%-- 
    Document   : homepage
    Created on : Jan 10, 2024, 9:01:08 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/homestyle.css"/>
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
    </head>
    <body>
        <jsp:include page="include/header.jsp"/>
        <section class="menu-section">
            <div class="menu-section-content">
                <div class="menu-section-content-categories">
                    <div class="menu-section-content-categories-unit">
                        <i class="fa-solid fa-list"></i><span>Danh mục nổi bật</span>
                        <span class="menu-section-drop-list"><i></i></span>
                    </div>
                    <ul id="menu-list">
                        <li><a href="#">hi</a></li>
                        <li><a href="#">hi</a></li>
                        <li><a href="#">hi</a></li>
                        <li><a href="#">hi</a></li>
                        <li><a href="#">hi</a></li>
                        <li><a href="#">hi</a></li>
                    </ul>
                </div>
                <div class="menu-section-content-search">
                    <div class="menu-section-content-search-form">
                        <form action="#">
                            <input type="text" placeholder="Bạn cần tìm gì?"/>
                            <button type="submit" class="site-btn">Tìm kiếm</button>
                        </form>
                    </div>
                    <div class="menu-section-content-search-phone">
                    </div>
                </div>
               
            </div>
        </section>
         <a href="cart?service=addcart&proid=1&quantity=1">Product 1</a><br/>
                <a href="cart?service=addcart&proid=2&quantity=1">Product 2</a><br/>
                <a href="cart?service=addcart&proid=3&quantity=1">Product 3</a><br/>
    </body>
</html>
