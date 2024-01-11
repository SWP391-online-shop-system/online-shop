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
                        <div class="search-phone-icon">
                            <i class="fa-solid fa-phone"></i>
                        </div>
                        <div class="search-phone-content">
                            <h5>+84 99.999.999</h5>
                            <span>Hỗ trợ người dùng</span>
                        </div>
                    </div>
                    
                </div>
            </div>
        </section>
    </body>
</html>
