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
            <div class="menu-section-title">
                <div class="menu-section-content">
                    <div class="menu-section-content-categories">
                        <div class="menu-section-content-categories-unit">
                            <i class="fa-solid fa-list"></i>
                            <label for="touch"><span class="content-title1">DANH MỤC NỔI BẬT</span></label>               
                            <input type="checkbox" id="touch"> 
                            <ul class="sider-menu">
                                <li><a href="#">Lorem Ipsum</a></li> 
                                <li><a href="#">Lorem Ipsum</a></li>
                                <li><a href="#">Lorem Ipsum</a></li>
                                <li><a href="#">Lorem Ipsum</a></li>
                            </ul>
                            <span class="menu-section-drop-list"><i></i></span>
                        </div>
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
                                        <a href="#"><img src="images/slider/slide1.png" alt="alt"/></a>
                                    </div>
                                    <div class="slide">
                                        <a href="#"><img src="images/slider/slide2.png" alt="alt"/></a>
                                    </div>
                                    <div class="slide">
                                        <a href="#"><img src="images/slider/slide3.jpg" alt="alt"/></a>
                                    </div>
                                    <div class="slide">
                                        <a href="#"><img src="images/slider/slide4.jpg" alt="alt"/></a>
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
                                    <label for="radio1" class="manual-btn manual1"></label>
                                    <label for="radio2" class="manual-btn manual2"></label>
                                    <label for="radio3" class="manual-btn manual3"></label>
                                    <label for="radio4" class="manual-btn manual4"></label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="menu-section-feature">
                    <div class="menu-section-feature-content">
                        <div class="menu-section-content-categories-1">
                            <div class="menu-section-content-categories-unit-1">
                                <i class="fa-solid fa-list"></i>
                                <label for="touch-1"><span class="content-title-2">TẤT CẢ DANH MỤC</span></label>               
                                <input type="checkbox" id="touch-1"> 
                                <ul class="sider-menu-1">
                                    <li><a href="#">Lorem Ipsum</a></li> 
                                    <li><a href="#">Lorem Ipsum</a></li>
                                    <li><a href="#">Lorem Ipsum</a></li>
                                    <li><a href="#">Lorem Ipsum</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="feature-content">
                            <div class="content-title">SẢN PHẨM NỔI BẬT</div>
                            <div class="product-card-content">
                                <div class="nft">
                                    <div class='main'>
                                        <img class='tokenImage' src="https://images.unsplash.com/photo-1621075160523-b936ad96132a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80" alt="NFT" />
                                        <h2>Kibertopiks #4269</h2>
                                        <div class='tokenInfo'>
                                            <div class="price">
                                                <ins>◘</ins>
                                                <p>0.031 ETH</p>
                                            </div>
                                            <div class="duration">
                                                <ins>◷</ins>
                                                <p>11 days left</p>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class='creator'>
                                            <div class='wrapper'>
                                                <img src="https://images.unsplash.com/photo-1620121692029-d088224ddc74?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1932&q=80" alt="Creator" />
                                            </div>
                                            <p><ins>Creation of</ins> Kiberbash</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="nft">
                                    <div class='main'>
                                        <img class='tokenImage' src="https://images.unsplash.com/photo-1621075160523-b936ad96132a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80" alt="NFT" />
                                        <h2>Kibertopiks #4269</h2>
                                        <div class='tokenInfo'>
                                            <div class="price">
                                                <ins>◘</ins>
                                                <p>0.031 ETH</p>
                                            </div>
                                            <div class="duration">
                                                <ins>◷</ins>
                                                <p>11 days left</p>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class='creator'>
                                            <div class='wrapper'>
                                                <img src="https://images.unsplash.com/photo-1620121692029-d088224ddc74?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1932&q=80" alt="Creator" />
                                            </div>
                                            <p><ins>Creation of</ins> Kiberbash</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="nft">
                                    <div class='main'>
                                        <img class='tokenImage' src="https://images.unsplash.com/photo-1621075160523-b936ad96132a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80" alt="NFT" />
                                        <h2>Kibertopiks #4269</h2>
                                        <div class='tokenInfo'>
                                            <div class="price">
                                                <ins>◘</ins>
                                                <p>0.031 ETH</p>
                                            </div>
                                            <div class="duration">
                                                <ins>◷</ins>
                                                <p>11 days left</p>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class='creator'>
                                            <div class='wrapper'>
                                                <img src="https://images.unsplash.com/photo-1620121692029-d088224ddc74?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1932&q=80" alt="Creator" />
                                            </div>
                                            <p><ins>Creation of</ins> Kiberbash</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
<script type="text/javascript">
    var counter = 1;
    setInterval(function () {
        document.getElementById('radio' + counter).checked = true;
        counter++;
        console.log(counter);
        if (counter == 5) {
            counter = 1;
        }
    }, 5000);

</script>
</html>
