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
        <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
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
                    <div class="menu-section-slider">
                        <div class="slider">
                            <div class="slides">
                                <input type="radio" name="radio-btn" id="radio1">
                                <input type="radio" name="radio-btn" id="radio2">
                                <input type="radio" name="radio-btn" id="radio3">
                                <input type="radio" name="radio-btn" id="radio4">
                                <div class="slide first">
                                    <img src="images/slider/slide1.png" alt="alt"/>
                                </div>
                                <div class="slide">
                                    <img src="images/slider/slide2.png" alt="alt"/>
                                </div>
                                <div class="slide">
                                    <img src="images/slider/slide3.jpg" alt="alt"/>
                                </div>
                                <div class="slide">
                                    <img src="images/slider/slide4.jpg" alt="alt"/>
                                </div>
                                <!-- slide end -->
                                <!--auto-->
                                <div class="navigation-auto">
                                    <div class="auto-btn1"></div>
                                    <div class="auto-btn2"></div>
                                    <div class="auto-btn3"></div>
                                    <div class="auto-btn4"></div>
                                </div>
                            </div>
                            <div class="navigation-manual">
                                <label for="radio1" class="manual-btn"></label>
                                <label for="radio2" class="manual-btn"></label>
                                <label for="radio3" class="manual-btn"></label>
                                <label for="radio4" class="manual-btn"></label>
                            </div>
                        </div>
                        <script type="text/javascript">
                            var counter = 1;
                            setInterval(function () {
                                document.getElementById('radio' + counter).checked= true;
                                counter++;
                                if(counter==4) {
                                    counter=1;
                                }
                            },5000);
                        </script>
                    </div>
                </div>
            </div>
        </section>
    </body>
    <script>

    </script>
</html>
