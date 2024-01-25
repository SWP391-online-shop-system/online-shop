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
         <!-- Blog Details Hero Begin -->
    <section class="blog-details-hero set-bg" data-setbg="img/blog/details/details-hero.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="blog__details__hero__text">
                        <h2>${Bdetail.blogTitle}</h2>
                        <ul>
                            <li>${Bdetail.blogAuthor}</li>
                            <li>${Bdetail.createTime}</li>
<!--                            <li>8 Comments</li>-->
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Details Hero End -->

    <!-- Blog Details Section Begin -->
    <section class="blog-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-5 order-md-1 order-2">
                    <div class="blog__sidebar">
                        <div class="blog__sidebar__search">
                            <form action="searchblog" method="post">
                                 <input name="txtSearch" type="text" placeholder="Search...">
                                 <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                            </form>
                        </div>
                         <div class="blog__sidebar__item">
                                <h4>Blog mới gần đây</h4>
                                <c:forEach items="${listNB}" var="nb">
                                <div class="blog__sidebar__recent">
                                    <a href="blogdetail?bid=${nb.blogID}" class="blog__sidebar__recent__item">
                                        <div class="blog__sidebar__recent__item__pic">
                                            <img src="images/blog/${nb.blogImage}" alt="">
                                        </div>
                                        <div class="blog__sidebar__recent__item__text">
                                            <h6>${nb.blogTitle}</h6>
                                            <span>${nb.createTime}</span>
                                        </div>
                                    </a>
                                </div>
                                </c:forEach>
                            </div>
                    </div>
                </div>
                <div class="col-lg-8 col-md-7 order-md-1 order-1">
                    <div class="blog__details__text">
                        <img src="images/blog/${Bdetail.blogImage}" alt="">
                        <p>${Bdetail.blogContent.replace("]","<br/>")}</p>
                    </div>
                    <div class="blog__details__content">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="blog__details__author">
                                    <div class="blog__details__author__pic">
                                        <img src="images/blog_author/${Bdetail.authorImage}" alt="">
                                    </div>
                                    <div class="blog__details__author__text">
                                        <h6>${Bdetail.blogAuthor}</h6>
                                        <span>tác giả</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="blog__details__widget">
<!--                                    <ul>
                                        <li><span>Categories:</span> Food</li>
                                        <li><span>Tags:</span> All, Trending, Cooking, Healthy Food, Life Style</li>
                                    </ul>-->
                                    <div class="blog__details__social">
                                        <a href="#"><i class="fa fa-facebook"></i></a>
                                        <a href="#"><i class="fa fa-twitter"></i></a>
                                        <a href="#"><i class="fa fa-google-plus"></i></a>
                                        <a href="#"><i class="fa fa-linkedin"></i></a>
                                        <a href="#"><i class="fa fa-envelope"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Details Section End -->

    <!-- Related Blog Section Begin -->
    <section class="related-blog spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title related-blog-title">
                        <h2>Bạn có thể thích</h2>
                    </div>
                </div>
            </div>
            <div class="row">
               <c:forEach items="${listGB}" var="gb">
                <div class="col-lg-4 col-md-4 col-sm-6">
                    <div class="blog__item">
                        <div class="blog__item__pic">
                            <img src="images/blog/${gb.blogImage}" alt="">
                        </div>
                        <div class="blog__item__text">
                            <ul>
                                <li><i class="fa fa-calendar-o"></i>${gb.createTime}</li>
                                <li><i class="fa fa-comment-o"></i> 5</li>
                            </ul>
                            <h5><a href="blogdetail?bid=${gb.blogID}">${gb.blogTitle}</a></h5>
                            <p>${gb.blogContent.substring(0, 99)}...</p>
                        </div>
                    </div>
                </div>
                 </c:forEach>
            </div>
        </div>
    </section>
    <!-- Related Blog Section End -->


    </body>
</html>