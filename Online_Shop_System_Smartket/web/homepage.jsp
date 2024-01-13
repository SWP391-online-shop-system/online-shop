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
                                <label for="touch-1"><span class="content-title-2">TẤT CẢ DANH MỤC</span>
                                    <i class="fa-solid fa-angle-down" style="float: right;margin-top: -18px;margin-right: 6px;font-size: 19px;"></i></label>               
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
                                        <a href="#"><img class='tokenImage' src="images/product/tulanhpanasonic.jpg" alt="Not found" />
                                            <div class="product-content-name">Tủ lạnh Panasonic</div></a>
                                        <div class="price-product">250000</div>
                                        <div class="product-buy-section">
                                            <div class="product-cart"><img src="images/cart/cart.png" alt="alt"/></div>
                                            <div class="product-buy"><img src="images/cart/bag.png" alt="alt"/><span>MUA NGAY</span></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="nft">
                                    <div class='main'>
                                        <a href="#"><img class='tokenImage' src="images/product/tulanhpanasonic.jpg" alt="Not found" />
                                            <div class="product-content-name">Tủ lạnh Panasonic</div></a>
                                        <div class="price-product">250000</div>
                                        <div class="product-buy-section">
                                            <div class="product-cart"><img src="images/cart/cart.png" alt="alt"/></div>
                                            <div class="product-buy"><img src="images/cart/bag.png" alt="alt"/><span>MUA NGAY</span></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="nft">
                                    <div class='main'>
                                        <a href="#"><img class='tokenImage' src="images/product/tulanhpanasonic.jpg" alt="Not found" />
                                            <div class="product-content-name">Tủ lạnh Panasonic</div></a>
                                        <div class="price-product">250000</div>
                                        <div class="product-buy-section">
                                            <div class="product-cart"><img src="images/cart/cart.png" alt="alt"/></div>
                                            <div class="product-buy"><img src="images/cart/bag.png" alt="alt"/><span>MUA NGAY</span></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="nft">
                                    <div class='main'>
                                        <a href="#"><img class='tokenImage' src="images/product/tulanhpanasonic.jpg" alt="Not found" />
                                            <div class="product-content-name">Tủ lạnh Panasonic</div></a>
                                        <div class="price-product">250000</div>
                                        <div class="product-buy-section">
                                            <div class="product-cart"><img src="images/cart/cart.png" alt="alt"/></div>
                                            <div class="product-buy"><img src="images/cart/bag.png" alt="alt"/><span>MUA NGAY</span></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="nft">
                                    <div class='main'>
                                        <a href="#"><img class='tokenImage' src="images/product/tulanhpanasonic.jpg" alt="Not found" />
                                            <div class="product-content-name">Tủ lạnh Panasonic</div></a>
                                        <div class="price-product">250000</div>
                                        <div class="product-buy-section">
                                            <div class="product-cart"><img src="images/cart/cart.png" alt="alt"/></div>
                                            <div class="product-buy"><img src="images/cart/bag.png" alt="alt"/><span>MUA NGAY</span></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="nft">
                                    <div class='main'>
                                        <a href="#"><img class='tokenImage' src="images/product/tulanhpanasonic.jpg" alt="Not found" />
                                            <div class="product-content-name">Tủ lạnh Panasonic</div></a>
                                        <div class="price-product">250000</div>
                                        <div class="product-buy-section">
                                            <div class="product-cart"><img src="images/cart/cart.png" alt="alt"/></div>
                                            <div class="product-buy"><img src="images/cart/bag.png" alt="alt"/><span>MUA NGAY</span></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--HOTTEST PRODUCT-->
                        <div class="newest-product-section">
                            <div class="content-title4">SẢN PHẨM MỚI NHẤT</div>
                            <section class="product"> 
                                <button class="pre-btn"><img src="images/slider/arrow.png" alt=""></button>
                                <button class="nxt-btn"><img src="images/slider/arrow.png" alt=""></button>
                                <div class="product-container">
                                    <div class="product-card">      
                                        <div id="container1">  
                                            <div class="product-details">
                                                <div class="product-details-title">
                                                    <div class="detail-name">TV LG 55'INCH</div><div class="detail-price">250,000</div>
                                                </div>
                                                <div class="product-details-title1">
                                                    <span class="hint-star star">
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star-o" aria-hidden="true"></i>
                                                    </span>
                                                    <div class="detail-buy">
                                                        <div class="product-buy-section">
                                                            <a href="#"><div class="product-cart"><img src="images/cart/cart.png" alt="alt"/></div></a>
                                                            <a href="#"><div class="product-buy"><img src="images/cart/bag.png" alt="alt"/><span>MUA NGAY</span></div></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <a href="#"><div><img class="product-image2" src="images/product/lgtv1.png" alt="alt"/></div></a>
                                        </div>
                                    </div>
                                    <div class="product-card">      
                                        <div id="container1">  
                                            <div class="product-details">
                                                <div class="product-details-title">
                                                    <div class="detail-name">Combo Nhat Thong Tuyet Diamond</div><div class="detail-price">250,000</div>
                                                </div>
                                                <div class="product-details-title1">
                                                    <span class="hint-star star">
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star-o" aria-hidden="true"></i>
                                                    </span>
                                                    <div class="detail-buy">
                                                        <div class="product-buy-section">
                                                            <div class="product-cart"><img src="images/cart/cart.png" alt="alt"/></div>
                                                            <div class="product-buy"><img src="images/cart/bag.png" alt="alt"/><span>MUA NGAY</span></div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            <div><img class="product-image2" src="images/product/combo1.jpg" alt="alt"/></div>
                                        </div>
                                    </div>
                                    <div class="product-card">      
                                        <div id="container1">  
                                            <div class="product-details">
                                                <div class="product-details-title">
                                                    <div class="detail-name">TV LG 55'INCH</div><div class="detail-price">250,000</div>
                                                </div>
                                                <div class="product-details-title1">
                                                    <span class="hint-star star">
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star-o" aria-hidden="true"></i>
                                                    </span>
                                                    <div class="detail-buy">
                                                        <div class="product-buy-section">
                                                            <div class="product-cart"><img src="images/cart/cart.png" alt="alt"/></div>
                                                            <div class="product-buy"><img src="images/cart/bag.png" alt="alt"/><span>MUA NGAY</span></div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            <div><img class="product-image2" src="images/product/tvlg.jpg" alt="alt"/></div>
                                        </div>
                                    </div>
                                    <div class="product-card">      
                                        <div id="container1">  
                                            <div class="product-details">
                                                <div class="product-details-title">
                                                    <div class="detail-name">TV LG 55'INCH</div><div class="detail-price">250,000</div>
                                                </div>
                                                <div class="product-details-title1">
                                                    <span class="hint-star star">
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star-o" aria-hidden="true"></i>
                                                    </span>
                                                    <div class="detail-buy">
                                                        <div class="product-buy-section">
                                                            <div class="product-cart"><img src="images/cart/cart.png" alt="alt"/></div>
                                                            <div class="product-buy"><img src="images/cart/bag.png" alt="alt"/><span>MUA NGAY</span></div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            <div><img class="product-image2" src="images/product/tvlg.jpg" alt="alt"/></div>
                                        </div>
                                    </div>
                                    <div class="product-card">      
                                        <div id="container1">  
                                            <div class="product-details">
                                                <div class="product-details-title">
                                                    <div class="detail-name">TV LG 55'INCH</div><div class="detail-price">250,000</div>
                                                </div>
                                                <div class="product-details-title1">
                                                    <span class="hint-star star">
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star-o" aria-hidden="true"></i>
                                                    </span>
                                                    <div class="detail-buy">
                                                        <div class="product-buy-section">
                                                            <div class="product-cart"><img src="images/cart/cart.png" alt="alt"/></div>
                                                            <div class="product-buy"><img src="images/cart/bag.png" alt="alt"/><span>MUA NGAY</span></div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            <div><img class="product-image2" src="images/product/tvlg.jpg" alt="alt"/></div>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                    <div class="menu-blog-section">
                        <div class="content-title5">Bài viết xu hướng</div>
                        <div class="card-container">
                            <a href="#">
                                <div class="card card-3">
                                    <div class="card-img"><img src="images/product/lgtv1.png" alt="alt"/></div>
                                    <div class="card-info">
                                        <div class="card-about">
                                            <a class="card-tag tag-deals"><i class="fa-regular fa-comment"></i>190</a>
                                            <div class="card-time"><i style="margin-right: 3px;" class="fa-regular fa-calendar"></i>5/27/2018</div>
                                        </div>
                                        <h1 class="card-title">Apple is having big Sale for the first time</h1>
                                        <div class="card-creator">by <a href="">Timur Mirzoyev</a></div>
                                    </div>
                                </div>
                            </a>
                            <a href="#">
                                <div class="card card-3">
                                    <div class="card-img"><img src="images/product/lgtv1.png" alt="alt"/></div>
                                    <div class="card-info">
                                        <div class="card-about">
                                            <a class="card-tag tag-deals"><i class="fa-regular fa-comment"></i>190</a>
                                            <div class="card-time"><i style="margin-right: 3px;" class="fa-regular fa-calendar"></i>5/27/2018</div>
                                        </div>
                                        <h1 class="card-title">Apple is having big Sale for the first time</h1>
                                        <div class="card-creator">by <a href="">Timur Mirzoyev</a></div>
                                    </div>
                                </div>
                            </a>
                            <a href="#">
                                <div class="card card-3">
                                    <div class="card-img"><img src="images/product/lgtv1.png" alt="alt"/></div>
                                    <div class="card-info">
                                        <div class="card-about">
                                            <a class="card-tag tag-deals"><i class="fa-regular fa-comment"></i>190</a>
                                            <div class="card-time"><i style="margin-right: 3px;" class="fa-regular fa-calendar"></i>5/27/2018</div>
                                        </div>
                                        <h1 class="card-title">Apple is having big Sale for the first time</h1>
                                        <div class="card-creator">by <a href="">Timur Mirzoyev</a></div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
        </section>
    </body>
    <script src="js/script.js"></script>
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
