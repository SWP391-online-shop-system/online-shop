<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html> 
<html>
    <head>
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
        <link rel="stylesheet" href="css/css_homepage/homestyle.css"/>
        <link rel="stylesheet" href="css/css_footer/footer.css"/>
        <link rel="stylesheet" href="css/css_header/header.css"/>
        <link rel="stylesheet" href="css/css_blog/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_blog/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_blog/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/css_blog/nice-select.css" type="text/css">
        <link rel="stylesheet" href="css/css_blog/jquery-ui.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_blog/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_blog/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_blog/style.css" type="text/css">

    </head>
    <body>
        <jsp:include page="include/header.jsp"/>
        <!-- Breadcrumb Section Begin -->
        <section class="breadcrumb-section set-bg" data-setbg="images/breadcrumb.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="breadcrumb__text">
                            <h2>Blog</h2>
                            <div class="breadcrumb__option">
                                <a href="./index.html">Home</a>
                                <span>Blog</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Breadcrumb Section End -->

        <!-- Blog Section Begin -->
        <section class="blog spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-5">
                        <div class="blog__sidebar">
                            <div class="blog__sidebar__search">
                                <form action="#">
                                    <input type="text" placeholder="Search...">
                                    <button type="submit"><span class="icon_search"></span></button>
                                </form>
                            </div>

                            <div class="blog__sidebar__item">
                                <h4>Recent News</h4>
                                <div class="blog__sidebar__recent">
                                    <a href="#" class="blog__sidebar__recent__item">
                                        <div class="blog__sidebar__recent__item__pic">
                                            <img src="images/blog/sidebar/sr-1.jpg" alt="">
                                        </div>
                                        <div class="blog__sidebar__recent__item__text">
                                            <h6>09 Kinds Of Vegetables<br /> Protect The Liver</h6>
                                            <span>MAR 05, 2019</span>
                                        </div>
                                    </a>
                                    <a href="#" class="blog__sidebar__recent__item">
                                        <div class="blog__sidebar__recent__item__pic">
                                            <img src="images/blog/sidebar/sr-2.jpg" alt="">
                                        </div>
                                        <div class="blog__sidebar__recent__item__text">
                                            <h6>Tips You To Balance<br /> Nutrition Meal Day</h6>
                                            <span>MAR 05, 2019</span>
                                        </div>
                                    </a>
                                    <a href="#" class="blog__sidebar__recent__item">
                                        <div class="blog__sidebar__recent__item__pic">
                                            <img src="images/blog/sidebar/sr-3.jpg" alt="">
                                        </div>
                                        <div class="blog__sidebar__recent__item__text">
                                            <h6>4 Principles Help You Lose <br />Weight With Vegetables</h6>
                                            <span>MAR 05, 2019</span>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8 col-md-7">
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="blog__item">
                                    <div class="blog__item__pic">
                                        <img src="images/blog/blog-2.jpg" alt="">
                                    </div>
                                    <div class="blog__item__text">
                                        <ul>
                                            <li><i class="fa fa-calendar-o"></i> May 4,2019</li>
                                            <li><i class="fa fa-comment-o"></i> 5</li>
                                        </ul>
                                        <h5><a href="#">6 ways to prepare breakfast for 30</a></h5>
                                        <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam aliquam
                                            quaerat </p>
                                        <a href="#" class="blog__btn">READ MORE <span class="arrow_right"></span></a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="blog__item">
                                    <div class="blog__item__pic">
                                        <img src="images/blog/blog-3.jpg" alt="">
                                    </div>
                                    <div class="blog__item__text">
                                        <ul>
                                            <li><i class="fa fa-calendar-o"></i> May 4,2019</li>
                                            <li><i class="fa fa-comment-o"></i> 5</li>
                                        </ul>
                                        <h5><a href="#">Visit the clean farm in the US</a></h5>
                                        <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam aliquam
                                            quaerat </p>
                                        <a href="#" class="blog__btn">READ MORE <span class="arrow_right"></span></a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="blog__item">
                                    <div class="blog__item__pic">
                                        <img src="images/blog/blog-1.jpg" alt="">
                                    </div>
                                    <div class="blog__item__text">
                                        <ul>
                                            <li><i class="fa fa-calendar-o"></i> May 4,2019</li>
                                            <li><i class="fa fa-comment-o"></i> 5</li>
                                        </ul>
                                        <h5><a href="#">Cooking tips make cooking simple</a></h5>
                                        <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam aliquam
                                            quaerat </p>
                                        <a href="#" class="blog__btn">READ MORE <span class="arrow_right"></span></a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="blog__item">
                                    <div class="blog__item__pic">
                                        <img src="img/blog/blog-4.jpg" alt="">
                                    </div>
                                    <div class="blog__item__text">
                                        <ul>
                                            <li><i class="fa fa-calendar-o"></i> May 4,2019</li>
                                            <li><i class="fa fa-comment-o"></i> 5</li>
                                        </ul>
                                        <h5><a href="#">Cooking tips make cooking simple</a></h5>
                                        <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam aliquam
                                            quaerat </p>
                                        <a href="#" class="blog__btn">READ MORE <span class="arrow_right"></span></a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="blog__item">
                                    <div class="blog__item__pic">
                                        <img src="images/blog/blog-4.jpg" alt="">
                                    </div>
                                    <div class="blog__item__text">
                                        <ul>
                                            <li><i class="fa fa-calendar-o"></i> May 4,2019</li>
                                            <li><i class="fa fa-comment-o"></i> 5</li>
                                        </ul>
                                        <h5><a href="#">The Moment You Need To Remove Garlic From The Menu</a></h5>
                                        <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam aliquam
                                            quaerat </p>
                                        <a href="#" class="blog__btn">READ MORE <span class="arrow_right"></span></a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="blog__item">
                                    <div class="blog__item__pic">
                                        <img src="images/blog/blog-6.jpg" alt="">
                                    </div>
                                    <div class="blog__item__text">
                                        <ul>
                                            <li><i class="fa fa-calendar-o"></i> May 4,2019</li>
                                            <li><i class="fa fa-comment-o"></i> 5</li>
                                        </ul>
                                        <h5><a href="#">Cooking tips make cooking simple</a></h5>
                                        <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam aliquam
                                            quaerat </p>
                                        <a href="#" class="blog__btn">READ MORE <span class="arrow_right"></span></a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="product__pagination blog__pagination">
                                    <a href="#">1</a>
                                    <a href="#">2</a>
                                    <a href="#">3</a>
                                    <a href="#"><i class="fa fa-long-arrow-right"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Blog Section End -->
        <jsp:include page="include/footer.jsp"/>


    </body>
</html>