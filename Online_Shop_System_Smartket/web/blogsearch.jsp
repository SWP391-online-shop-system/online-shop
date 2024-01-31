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
        <section class="breadcrumb-section set-bg" data-setbg="images/blog/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>Blog</h2>
                        <div class="breadcrumb__option">
                            <a href="HomePageURL">Trang chủ</a>
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
                                <form action="searchblog">
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
                    <div class="col-lg-8 col-md-7">
                        <div class="row">
                            <c:forEach items="${listPB}" var="pb">
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="blog__item">
                                    <div class="blog__item__pic">
                                        <img src="images/blog/${pb.blogImage}" alt="">
                                    </div>
                                    <div class="blog__item__text">
                                        <ul>
                                            <li><i class="fa fa-calendar-o"></i> ${pb.createTime}</li>
<!--                                            <li><i class="fa fa-comment-o"></i> 5</li>-->
                                        </ul>
                                        <h5><a href="blogdetail?bid=${pb.blogID}">${pb.blogTitle}</a></h5>
                                        <p>${pb.blogContent.substring(0, 99)}...</p>
                                        <a href="blogdetail?bid=${pb.blogID}" class="blog__btn">Xem thêm<span class="fa fa-long-arrow-right"></span></a>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                            <div class="col-lg-12">
                                <div class="product__pagination blog__pagination">
                                    <c:if test="${tag>1}">
                                    <a href="searchblog?index=${tag-1}&txtSearch=${txtSearch}"><i class="fa fa-long-arrow-left"></i></a>
                                    </c:if>
                                    <c:forEach begin="1" end="${endP}" var="i">
                                    <a href="searchblog?index=${i}&txtSearch=${txtSearch}">${i}</a>
                                    </c:forEach>
                                    <c:if test="${tag<endP}">
                                    <a href="searchblog?index=${tag+1}&txtSearch=${txtSearch}"><i class="fa fa-long-arrow-right"></i></a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Blog Section End -->
    </body>
</html>