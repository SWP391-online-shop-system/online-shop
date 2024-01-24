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
        <link rel="stylesheet" href="css/css_homepage/homestyle.css"/>
        <link rel="stylesheet" href="css/css_footer/footer.css"/>
        <link rel="stylesheet" href="css/css_header/header.css"/>
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">
    </head>
    <body>
        <jsp:include page="include/header.jsp"/>
        <%DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);%>
        <section class="menu-section">
            <div class="menu-section-title">
                <div class="menu-section-content">
                    <div class="menu-section-content-categories">
                        <div class="menu-section-content-categories-unit">
                            <i class="fa-solid fa-list"></i>
                            <label for="touch"><span class="content-title1">DANH MỤC NỔI BẬT</span></label>               
                            <input type="checkbox" id="touch"> 

                            <ul class="sider-menu">
                                <%
                                    DAOProduct dao = new DAOProduct();
                                ResultSet rs = dao.getData("SELECT c.CategoryID, c.CategoryName, AVG(p.TotalRate) FROM Product AS p JOIN Categories AS c ON c.CategoryID = p.CategoryID GROUP BY c.CategoryID ORDER BY AVG(p.TotalRate) DESC LIMIT 3;");
                                while(rs.next()) {%>
                                <li><a class="change-hover" href="ProductListURL?service=ShowCategory&CategoryID=<%=rs.getInt(1)%>&index=1"><%=rs.getString(2)%></a></li> 
                                    <%}%>
                            </ul>
                            <span class="menu-section-drop-list"><i></i></span>
                        </div>
                    </div>
                    <div class="menu-section-content-search">
                        <div class="menu-section-content-search-form">
                            <form action="searchPageURL" method="GET">
                                <input name="keyWord" type="text" placeholder="Bạn cần tìm gì?"/>
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
                            <div class="menu-section-content-categories-unit-1">
                                <i class="fa-solid fa-list"></i>
                                <label for="touch-1"><span class="content-title-2">TẤT CẢ DANH MỤC</span>
                                    <i class="fa-solid fa-angle-down" style="float: right;margin-top: -18px;margin-right: 6px;font-size: 19px;"></i></label>               
                                <input type="checkbox" id="touch-1"> 
                                <ul class="sider-menu-1">
                                    <%
                                    DAOCategories daoCate = new DAOCategories();
                                    Vector<Categories> CateList = daoCate.getCategories("select * from Categories");
                                    for(Categories cate: CateList){%>
                                    <li><a href="ProductListURL?service=ShowCategory&CategoryID=<%=cate.getCategoryID()%>&index=1"><%=cate.getCategoryName()%></a></li> 
                                        <%}%>
                                </ul>
                            </div>
                        </div>
                        <div class="feature-content" id="newProduct">
                            <div class="content-title">SẢN PHẨM MỚI NHẤT</div>
                            <div class="product-card-content">
                                <%
                                ResultSet rsNewProduct = dao.getData("select * from product as p join productImage as pi "
                                        + "on p.ProductID = pi.ProductID "
                                        + "where pi.ProductURL like '%_1%' "
                                        + "order by p.CreateDate desc limit 6 ");
                                
                                while(rsNewProduct.next()) {%>
                                <div class="nft">
                                    <div class="brand-info">new</div>
                                    <div class='main'>
                                        <a href="#"><img class='tokenImage' src="<%=rsNewProduct.getString(12)%>" alt="Not found" />
                                            <div class="product-content-name"><%=rsNewProduct.getString(2)%></div></a>
                                            <%if(rsNewProduct.getInt(7) != 0) {%>
                                        <div class="price-product "><img style="width: 21px; height: 20px;" src="images/logo/sale.jpg"/><%=df.format(rsNewProduct.getDouble(6)*(100-rsNewProduct.getInt(7))/100)%>đ</div>
                                        <%} else {%>
                                        <div class="price-product"><%=df.format(rsNewProduct.getDouble(6))%><span>đ</span></div>
                                        <%}%>
                                        <div class="product-buy-section">
                                            <c:if test="${sessionScope.account == null}">
                                                <div class="product-cart"><a href="loginURL" onclick="alertOpenCart()"><img src="images/cart/cart.png" alt="alt"/></a></div>
                                                    </c:if>
                                                    <c:if test="${sessionScope.account != null}">
                                                <div class="product-cart"><a href="CartURL?service=addcart&quan=1&pid=<%=rsNewProduct.getInt("ProductID")%>"><img src="images/cart/cart.png" alt="alt"/></a></div>
                                                    </c:if>
                                            <div class="product-buy"><a href="#"><img src="images/cart/bag.png" alt="alt"/><span>MUA NGAY</span></div></a>
                                        </div>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                        </div>
                        <!--HOTTEST PRODUCT-->
                        <div class="newest-product-section" id="featureProduct">
                            <div class="content-title4">SẢN PHẨM NỔI BẬT</div>
                            <section class="product"> 
                                <button class="pre-btn"><img src="images/slider/arrow.png" alt=""></button>
                                <button class="nxt-btn"><img src="images/slider/arrow.png" alt=""></button>
                                <div class="product-container">
                                    <%
                                ResultSet rsFeatureProduct = dao.getData("select * from product as p join productImage as pi "
                                        + "on p.ProductID = pi.ProductID "
                                        + "where pi.ProductURL like '%_1%' "
                                        + "order by p.TotalRate desc limit 6;");
                                while(rsFeatureProduct.next()) {%>
                                    <div class="product-card">    
                                        <div id="container1">  
                                            <div class="product-details">
                                                <div class="product-details-title">
                                                    <div class="detail-name"><%=rsFeatureProduct.getString(2)%></div>
                                                    <%if(rsFeatureProduct.getInt(7) != 0) {%>
                                                    <div class="detail-price1"><img style="width: 21px; height: 20px;" src="images/logo/sale.jpg"/><%=df.format(rsFeatureProduct.getDouble(6)*(100-rsFeatureProduct.getInt(7))/100)%>đ</div>
                                                        <%} else {%>
                                                    <div class="detail-price"><%=df.format(rsFeatureProduct.getDouble(6))%>đ</div>
                                                    <%}%>
                                                </div>
                                                <div class="product-details-title1">
                                                    <span class="hint-star star">
                                                        <%int totalRate = (int)rsFeatureProduct.getInt(9);
                                                          Product product = new Product();
                                                          String result = product.convertStar(totalRate);
                                                        %>
                                                        <%=result%>
                                                    </span>
                                                    <div class="detail-buy">
                                                        <div class="product-buy-section">
                                                            <c:if test="${sessionScope.account == null}">
                                                                <a href="loginURL" onclick="alertOpenCart()"><div class="product-cart"><img src="images/cart/cart.png" alt="alt"/></div></a>
                                                                    </c:if>
                                                                    <c:if test="${sessionScope.account != null}">
                                                                <a href="CartURL?service=addcart&quan=1&pid=<%=rsFeatureProduct.getInt("ProductID")%>"><div class="product-cart"><img src="images/cart/cart.png" alt="alt"/></div></a>
                                                                    </c:if>


                                                            <a href="#"><div class="product-buy"><img src="images/cart/bag.png" alt="alt"/><span>MUA NGAY</span></div></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <a href="#"><div><img class="product-image2" src="<%=rsFeatureProduct.getString(12)%>" alt="alt"/></div></a>
                                        </div>
                                    </div>
                                    <%}%>
                                </div>
                            </section>
                        </div>
                    </div>
                    <div class="menu-blog-section">
                        <div class="content-title5">Bài viết xu hướng</div>
                        <div class="card-container">
                            <div class="side-bar-lastest-post">
                                <div class="content-title6">Bài viết mới</div>
                                <%
                                DAOBlog daoBlog = new DAOBlog();
                                ResultSet rsNewBlog = (ResultSet)request.getAttribute("rsNewBlog");
                                if(rsNewBlog.next()) {
                                %>
                                <div class="card1">
                                    <a href="blog">
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
                                                <div class="user__info1">
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
                            <a href="hi">
                                <div class="card card-3">
                                    <div class="card-img"><img src="images/blog/<%=rsFeatureBlog.getString(6)%>" alt="alt"/></div>
                                    <div class="card-info">
                                        <div class="card-about">
                                            <a class="card-tag tag-deals"><i class="fa-regular fa-eye"></i></i><%=rsFeatureBlog.getInt(9)%></a>
                                            <div class="card-time"><i style="margin-right: 3px;" class="fa-regular fa-calendar"></i><%=rsFeatureBlog.getString(11).substring(0,10)%></div>
                                        </div>
                                        <h1 class="card-title"><a style="font-size: 19px;" href="hi"><%=rsFeatureBlog.getString(7)%></a></h1>
                                        <div class="card-creator">by <a href=""><%=rsFeatureBlog.getString(3)%></a></div>
                                    </div>
                                </div>
                            </a>
                            <%}%>
                        </div>
                    </div>
                    <a href="blog"><div class="more-detail_1">Xem thêm</div></a>
                </div>
        </section>
        <jsp:include page="include/footer.jsp"/>
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
    </script>
</html>
