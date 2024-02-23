<%-- 
    Document   : homepage
    Created on : Jan 10, 2024, 9:01:08 PM
    Author     : admin
--%>

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
<html>
    <head>
        <link rel="stylesheet" href="css/login.css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
        <link rel="stylesheet" href="css/css_productList/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/magnific-popup.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/nice-select.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/style.css" type="text/css">
        <link rel="stylesheet" href="css/css_homepage/homestyle.css"/>
        <link rel="stylesheet" href="css/css_footer/footer.css"/>
        <link rel="stylesheet" href="css/css_header/header.css"/>
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
        <style>
            cahtml,
            h1,
            h2,
            h3,
            h4,
            h5,
            h6 {
                margin: 0;
                color: #111111;
                font-weight: 400;
                font-family: none;
            }
            body{
                margin: 5px -5px;
            }
            #styleBtn{
                z-index: 99;
                background: white;
                width: 215px;
                margin-left: -43px;
                height: 430px;
                margin-top: 18px;
            }
            .content-title4:after{
                content: " ";
                position: absolute;
                border: 1px solid #f5f5f5;
                bottom: 11px;
                left: -340px;
                width: 124%;
                height: 0;
                z-index: -2;
            }
            a:hover{
                color:black;
            }
        </style>
    </head>
    <body>
        <jsp:include page="include/header.jsp"/>
        <%DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);%>
        <section class="menu-section">
            <div class="menu-section-title">
                <div class="menu-section-content">
                    <div class="menu-section-content-categories">
                        <div class="menu-section-content-categories-unit" style="box-sizing: unset;">
                            <i class="fa-solid fa-list"></i>
                            <label for="touch" style="margin-bottom: -3px;"><span class="content-title1" style="padding-left: 16px;">DANH MỤC CHÍNH</span>               
                                <i class="fa-solid fa-angle-down" style="float: right;margin-top: -21px;margin-right: -33px;font-size: 19px;"></i></label>  
                            <input type="checkbox" id="touch"> 

                            <ul class="sider-menu" style="box-sizing: unset;
                                font-family: none;
                                margin-top: 9px;">
                                <li onclick="scrollToNew()">Sản phẩm mới nhất</li> 
                                <li onclick="scrollToFeature()">Sản phẩm nổi bật</li> 
                                <li onclick="scrollToBlog()">Bài viết xu hướng</li> 
                            </ul>
                            <span class="menu-section-drop-list"><i></i></span>
                        </div>
                    </div>
                    <div class="menu-section-content-search">
                        <div class="menu-section-content-search-form">
                            <%double inputMinPrice = (double)request.getAttribute("inputMinPrice");
                              double inputMaxPrice = (double)request.getAttribute("inputMaxPrice");
                            %>
                            <form action="searchPageURL" method="GET">
                                <input name="keyWord" type="text" placeholder="Bạn cần tìm gì?"/>
                                <input type="hidden" name="type" value=""/>
                                <input type="hidden" name="TotalRate" value="0"/>
                                <input type="hidden" name="filterChoice" value="createDate desc"/>
                                <input type="hidden" name="inputMinPrice" value="<%=inputMinPrice%>"/>
                                <input type="hidden" name="inputMaxPrice" value="<%=inputMaxPrice%>"/>
                                <button type="submit" class="site-btn">Tìm kiếm</button>
                            </form>
                        </div>
                        <div class="menu-section-content-search-phone"style="font-family: none;">
                            <div class="search-phone-icon">
                                <i style="padding-top: 17px" class="fa-solid fa-phone"></i>
                            </div>
                            <div class="search-phone-content" style="padding-top: 29px;">
                                <div>+84 99.999.999</div>
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
                                    <%ResultSet rsSlider = (ResultSet)request.getAttribute("rsSlider");
                                    int count = 0;
                                    while(rsSlider.next()) {
                                    count++;
                                    if(count == 1) {
                                    %>
                                    <div class="slide first">
                                        <a href="<%=rsSlider.getString(2)%>"><img src="images/slider/<%=rsSlider.getString(1)%>" alt="alt"/></a>
                                    </div>
                                    <%} else {%>
                                    <div class="slide">
                                        <a href="<%=rsSlider.getString(2)%>"><img src="images/slider/<%=rsSlider.getString(1)%>" alt="alt"/></a>
                                    </div>
                                    <%}}%>
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
                            <div class="menu-section-content-categories-unit-1" style="    box-sizing: unset;">
                                <i class="fa-solid fa-list"></i>
                                <label for="touch-1"><span class="content-title-2" style="padding-left: 13px;">TẤT CẢ DANH MỤC</span>
                                    <i class="fa-solid fa-angle-down" style="float: right;margin-top: -21px;margin-right: -33px;font-size: 19px;"></i></label>               
                                <input type="checkbox" id="touch-1" checked> 
                                <ul class="sider-menu-1" style="font-family: none;
                                    margin-top: -3px;
                                    box-sizing: unset;
                                    margin-left: 1px;
                                    height: 475px;
                                    ">
                                    <%
                                    DAOCategories daoCate = new DAOCategories();
                                     DAOProduct dao = new DAOProduct();
                                    Vector<Categories> CateList = daoCate.getCategories("select * from Categories");
                                    for(Categories cate: CateList){%>
                                    <li><a href="ProductListURL?service=ShowCategory&CategoryID=<%=cate.getCategoryID()%>&index=1"><%=cate.getCategoryName()%></a></li> 
                                        <%}%>
                                </ul>
                            </div>
                        </div>
                        <div class="feature-content" id="newProduct">
                            <div class="content-title"style="margin-top: 110px;">SẢN PHẨM MỚI NHẤT</div>
                            <div class="product-card-content">
                                <%
                                ResultSet rsNewProduct = dao.getData("select * from product as p join productImage as pi "
                                        + "on p.ProductID = pi.ProductID "
                                        + "where pi.ProductURL like '%_1%' "
                                        + "order by p.CreateDate desc limit 6 ");
                                
                                while(rsNewProduct.next()) {%>
                                <div class="col-lg-4 col-md-6 col-sm-6">
                                    <div class="product__item">
                                        <div class="product__item__pic set-bg">
                                            <a href="ProductDetailURL?ProductID=<%=rsNewProduct.getInt(1)%>">
                                                <img src="<%=rsNewProduct.getString(13)%>" alt="alt"/>
                                            </a>
                                            <%if(rsNewProduct.getInt("UnitDiscount")!=0) {%>
                                            <div class="sale-cotification">Sale</div>
                                            <%}%>
                                            <%ResultSet rsNewestProduct = dao.getData("select * from product as p join productImage as pi "
                                               + "on p.ProductID = pi.ProductID "
                                               + "where pi.ProductURL like '%_1%' "
                                               + "order by p.CreateDate desc limit 6 ");
                                                 while(rsNewestProduct.next()) {
                                                    if(rsNewProduct.getString("CreateDate").substring(0,10).equals(rsNewProduct.getString("CreateDate").substring(0,10))){%>
                                            <div class="sale-cotification">Mới</div>
                                            <%}}%>
                                        </div>
                                        <div class="product__item__text">
                                            <h6><%=rsNewProduct.getString("ProductName")%></h6>
                                            <a href="#" class="add-cart">+ Thêm vào giỏ</a><a style="margin-left: 136px;" href="#">Mua ngay</a>
                                            <div style="display: flex;">
                                                <div class="rating">
                                                    <%int star = (int)rsNewProduct.getInt("totalRate");
                                                      Product pro2 = new Product();
                                                      String totalRate = pro2.convertStar(star);
                                                    %>
                                                    <%=totalRate%>
                                                </div>
                                            </div>
                                            <div style="display: flex;">
                                                <%if(rsNewProduct.getInt("UnitDiscount")!= 0){%>
                                                <div style="color: red;font-weight: 700;font-size: 15px; flex: 0 0 50%; text-decoration: line-through;"><%=df.format(rsNewProduct.getDouble("UnitPrice"))%>đ</div>
                                                <div style="color: #0d0d0d;font-weight: 700;font-size: 15px; flex: 0 0 50%"><%=df.format(rsNewProduct.getDouble("UnitPrice")*(100-rsNewProduct.getInt("UnitDiscount"))/100)%>đ</div>
                                                <%} else {%>
                                                <div style="font-weight: 700;
                                                     font-size: 15px;
                                                     flex: -2 0 43%;
                                                     margin-left: 116px;
                                                     margin-top: -26px;"><%=df.format(rsNewProduct.getDouble("UnitPrice"))%>đ</div>
                                                <%}%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                        </div>
                        <!--HOTTEST PRODUCT-->
                        <div class="newest-product-section" id="featureProduct">
                            <div class="content-title4" style="margin-left: 424px;margin-bottom: 13px;">SẢN PHẨM NỔI BẬT</div>
                            <section class="product" style="padding: 0;
                                     margin: 0;"> 
                                <button class="pre-btn" id="styleBtn"><img src="images/slider/arrow.png" alt=""style="width: 15px;height: 22px;margin-top: 44px;"></button>
                                <button class="nxt-btn" id="styleBtn"style="margin-right: -40px;"><img src="images/slider/arrow.png" alt="" style="width: 15px;height: 22px;margin-top: -37px;margin-left: -112px;"></button>
                                <div class="product-container"style="height: 380px;">
                                    <%
                                       
                                ResultSet rsFeatureProduct = dao.getData("select * from product as p join productImage as pi "
                                        + "on p.ProductID = pi.ProductID "
                                        + "where pi.ProductURL like '%_1%' "
                                        + "order by p.TotalRate desc limit 6;");
                                while(rsFeatureProduct.next()) {%>
                                    <div class="col-lg-4 col-md-6 col-sm-6">
                                        <div class="product__item">
                                            <div class="product__item__pic set-bg">
                                                <a href="ProductDetailURL?ProductID=<%=rsFeatureProduct.getInt(1)%>">
                                                    <img src="<%=rsFeatureProduct.getString(13)%>" alt="alt"/>
                                                </a>
                                                <%if(rsFeatureProduct.getInt("UnitDiscount")!=0) {%>
                                                <div class="sale-cotification">Sale</div>
                                                <%}%>
                                            </div>
                                            <div class="product__item__text">
                                                <h6><%=rsFeatureProduct.getString("ProductName")%></h6>
                                                <a href="#" class="add-cart">+ Thêm vào giỏ</a><a style="margin-left: 136px;" href="#">Mua ngay</a>
                                                <div style="display: flex;">
                                                    <div class="rating">
                                                        <%int star = (int)rsFeatureProduct.getInt("totalRate");
                                                          Product pro2 = new Product();
                                                          String totalRate = pro2.convertStar(star);
                                                        %>
                                                        <%=totalRate%>
                                                    </div>
                                                </div>
                                                <div style="display: flex;">
                                                    <%if(rsFeatureProduct.getInt("UnitDiscount")!= 0){%>
                                                    <div style="color: red;font-weight: 700;font-size: 15px; flex: 0 0 50%; text-decoration: line-through;"><%=df.format(rsFeatureProduct.getDouble("UnitPrice"))%>đ</div>
                                                    <div style="color: #0d0d0d;font-weight: 700;font-size: 15px; flex: 0 0 50%"><%=df.format(rsFeatureProduct.getDouble("UnitPrice")*(100-rsFeatureProduct.getInt("UnitDiscount"))/100)%>đ</div>
                                                    <%} else {%>
                                                    <div style="font-weight: 700;
                                                         font-size: 15px;
                                                         flex: -2 0 43%;
                                                         margin-left: 116px;
                                                         margin-top: -26px;"><%=df.format(rsFeatureProduct.getDouble("UnitPrice"))%>đ</div>
                                                    <%}%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%}%>
                                </div>
                            </section>
                        </div>
                    </div>
                    <div class="menu-blog-section">
                        <div class="content-title5" style="margin-bottom: 26px;margin-top: 50px;">Bài viết xu hướng</div>
                        <div class="card-container"style="box-sizing: unset;
                             font-family: none;">
                            <div class="side-bar-lastest-post">
                                <div class="content-title6">Bài viết mới</div>
                                <%
                                DAOBlog daoBlog = new DAOBlog();
                                ResultSet rsNewBlog = (ResultSet)request.getAttribute("rsNewBlog");
                                if(rsNewBlog.next()) {
                                %>
                                <div class="card1"style="height: 324px;">
                                    <a href="blogdetail?bid=<%=rsNewBlog.getInt(1)%>">
                                        <div class="card__header1">
                                            <img src="images/blog/<%=rsNewBlog.getString(6)%>" alt="card__image" class="card__image1" width="600">
                                        </div>
                                        <div class="card__body1">
                                            <div><i style="margin-right: 5px;" class="fa-regular fa-calendar"></i><span><%=rsNewBlog.getString(11).substring(0,10)%></span></div>
                                            <h4><%=rsNewBlog.getString(7)%></h4>
                                        </div>
                                        <div class="card__footer1">
                                            <div class="user1">
                                                <img src="images/blog_author/<%=rsNewBlog.getString(5)%>" alt="user__image" class="user__image1">
                                                <div class="user__info1"style="padding-top: 16px;">
                                                    <h5><%=rsNewBlog.getString(3)%></h5>
                                                    <small></small>
                                                </div>
                                            </div>
                                        </div>
                                </div>
                                </a>
                                <%}%>
                            </div>
                            <%
                             ResultSet rsFeatureBlog = (ResultSet)request.getAttribute("rsFeatureBlog");
                             while(rsFeatureBlog.next()) {
                            %>
                            <a href="blogdetail?bid=<%=rsFeatureBlog.getInt(1)%>">
                                <div class="card card-3"style="border: none;">
                                    <div class="card-img"><img src="images/blog/<%=rsFeatureBlog.getString(6)%>" alt="alt"/></div>
                                    <div class="card-info">
                                        <div class="card-about">
                                            <a href="blogdetail?bid=<%=rsFeatureBlog.getInt(1)%>" class="card-tag tag-deals"><i class="fa fa-star" aria-hidden="true"></i><%=rsFeatureBlog.getInt(9)%></a>
                                            <div class="card-time"><i style="margin-right: 3px;" class="fa-regular fa-calendar"></i><%=rsFeatureBlog.getString(11).substring(0,10)%></div>
                                        </div>
                                        <h1 class="card-title" style="height: 93px;"><a href="blogdetail?bid=<%=rsFeatureBlog.getInt(1)%>" style="font-size: 19px;" href="hi"><%=rsFeatureBlog.getString(7)%></a></h1>
                                        <div class="user1">
                                            <img src="images/blog_author/<%=rsFeatureBlog.getString(5)%>" alt="user__image" class="user__image1">
                                            <div class="user__info1"style="padding-top: 16px;">
                                                <h5 style="font-size: 16px;"><%=rsFeatureBlog.getString(3)%></h5>
                                                <small></small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </a>
                            <%}%>
                        </div>
                    </div>
                    <a href="blog"><div class="more-detail_1" style="box-sizing: unset;
                                        font-size: 14px;
                                        border-radius: 5px;
                                        padding-top: 5px;">Xem thêm</div></a>
                </div>
        </section>
        <footer class="footer_1">
            <div class="container_1" style="height: 270px;padding-top: 28px;">
                <div class="row_1">
                    <div class="col_1" id="company">
                        <img style="width: 176px;
                             margin-bottom: -19px;
                             margin-top: 10px;height: 136px;" src="images/logo/logo.png" alt="" class="logo_1">
                        <p style="font-family: poppins;font-size: 15px;color: white;">
                            công ty Smartket Việt Nam, 54 Liễu Giai, quận Ba Đình, Hà Nội 
                        </p>
                        <div class="social_1">
                            <a href="#"><i class="fab fa-facebook"></i></a>
                            <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
                        </div>
                    </div>


                    <div class="col_1" id="services">
                        <h3 class="footer_title_1">Dịch vụ</h3>
                        <div class="links_1">
                            <a href="#">Tuyển dụng</a>
                            <a href="#">Quảng cáo</a>
                            <a href="#">Chính sách</a>
                        </div>
                    </div>

                    <div class="col_1" id="useful-links" style="margin-left: 50px;margin-right: 50px;">
                        <h3 class="footer_title_1">Đường dẫn</h3>
                        <div class="links_1">
                            <a href="#">Về chúng tôi</a>
                            <a href="#">Danh mục</a>
                            <a href="#">Tin tức</a>
                            <a href="#">Hỗ trợ</a>
                        </div>
                    </div>

                    <div class="col_1" id="contact">
                        <h3 class="footer_title_1">Liên hệ</h3>
                        <div class="contact-details_1">
                            <i class="fa-regular fa-envelope"></i>
                            <p style="color: white;">Smartket@gmail.com</p>
                        </div>
                        <div class="contact-details_1">
                            <i class="fa fa-phone"></i>
                            <p style="color: white;">+84 99.999.999</p>
                        </div>
                    </div>
                </div>

                <div class="row_1">
                    <div class="form_1" style="margin-top: -56px;">
                        <form action="">
                            <input class="email-input_1" style="height: 40px;" type="text" placeholder="Email here...">
                            <button class="email-button_1" style="height: 43px;padding-top: 10px;"><i class="fa fa-paper-plane"></i></button>
                        </form>
                    </div>
                </div>
            </div>
        </footer>
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
                                    function alertOpenCart() {
                                        alert('Đăng nhập để xem giỏ hàng của bạn');
                                    }
                                    window.onload = function () {
                                        // Lấy giá trị của tham số section từ URL
                                        var sectionId = '<%=request.getParameter("section") %>';

                                        // Nếu sectionId không rỗng, thì cuộn đến phần có id tương ứng
                                        if (sectionId) {
                                            var targetSection = document.getElementById(sectionId);
                                            if (targetSection) {
                                                targetSection.scrollIntoView({behavior: 'smooth'});
                                            }
                                        }
                                    };

                                    function scrollToNew() {
                                        // Calculate the middle of the page
                                        const middle = window.innerHeight + 90;
                                        // Scroll to the middle of the page
                                        window.scrollTo({
                                            top: middle,
                                            behavior: 'smooth' // Optional: Add smooth scrolling effect
                                        });
                                    }
                                    function scrollToFeature() {
                                        // Calculate the middle of the page
                                        const middle = window.innerHeight * 2.3;

                                        // Scroll to the middle of the page
                                        window.scrollTo({
                                            top: middle,
                                            behavior: 'smooth' // Optional: Add smooth scrolling effect
                                        });
                                    }
                                    function scrollToBlog() {
                                        // Calculate the middle of the page
                                        const middle = window.innerHeight * 3;

                                        // Scroll to the middle of the page
                                        window.scrollTo({
                                            top: middle,
                                            behavior: 'smooth' // Optional: Add smooth scrolling effect
                                        });
                                    }
    </script>
</html>
