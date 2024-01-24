<%-- 
    Document   : productList
    Created on : Jan 17, 2024, 2:48:42 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="view.Product"%>
<%@page import="view.ProductImage"%>
<%@page import="model.DAOProduct"%>
<%@page import="model.DAOProductImage"%>
<%@page import="java.util.Vector" %>
<!DOCTYPE html>
<html lang="zxx">

    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Male_Fashion Template">
        <meta name="keywords" content="Male_Fashion, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>San pham</title>

        <!-- Css Styles -->
        <link rel="stylesheet" href="css/css_header/header.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/magnific-popup.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/nice-select.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/style.css" type="text/css">
        <link rel="stylesheet" href="css/css_footer/footer.css" type="text/css">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>

    </head>

    <body>
        <jsp:include page="include/header.jsp"/>
        <%DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);%>
        <!-- Shop Section Begin -->
        <section class="shop spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <div class="shop__sidebar">
                            <div class="shop__sidebar__search">
                                <form action="searchPageURL" method="GET">
                                    <input type="text" name="keyWord" placeholder="Search...">
                                    <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                                </form>
                            </div>
                            <div class="shop__sidebar__accordion">
                                <div class="accordion" id="accordionExample">
                                    <div class="card">
                                        <div class="card-heading">
                                            <a data-toggle="collapse" data-target="#collapseOne">Danh mục</a>
                                        </div>
                                        <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <div class="shop__sidebar__categories">
                                                    <ul class="nice-scroll">
                                                        <%ResultSet rsCategory = (ResultSet)request.getAttribute("CategoryResult");
                                                        while(rsCategory.next()) {%>
                                                        <li><a href="ProductListURL?service=ShowCategory&CategoryID=<%=rsCategory.getInt(1)%>&index=1"><%=rsCategory.getString(2)%></a></li>
                                                            <%}%>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-heading">
                                            <a data-toggle="collapse" data-target="#collapseThree">Lọc theo giá tiền</a>
                                        </div>
                                        <div id="collapseThree" class="collapse show" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <div class="shop__sidebar__price">
                                                    <ul>
                                                        <li><a href="#">$0.00 - $50.00</a></li>
                                                        <li><a href="#">$50.00 - $100.00</a></li>
                                                        <li><a href="#">$100.00 - $150.00</a></li>
                                                        <li><a href="#">$150.00 - $200.00</a></li>
                                                        <li><a href="#">$200.00 - $250.00</a></li>
                                                        <li><a href="#">250.00+</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-heading">
                                            <a data-toggle="collapse" data-target="#collapseSix">Lọc theo đánh giá</a>
                                        </div>
                                        <div id="collapseSix" class="collapse show" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <div class="shop__sidebar__tags">
                                                    <a href="1"><i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star-o" aria-hidden="true"></i>
                                                        <i class="fa fa-star-o" aria-hidden="true"></i>
                                                        <i class="fa fa-star-o" aria-hidden="true"></i>
                                                        <i class="fa fa-star-o" aria-hidden="true"></i>
                                                    </a>
                                                    <a href="2"><i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star-o" aria-hidden="true"></i>
                                                        <i class="fa fa-star-o" aria-hidden="true"></i>
                                                        <i class="fa fa-star-o" aria-hidden="true"></i>
                                                    </a>
                                                    <a href="3"><i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star-o" aria-hidden="true"></i>
                                                        <i class="fa fa-star-o" aria-hidden="true"></i>
                                                    </a>
                                                    <a href="4"><i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star-o" aria-hidden="true"></i>
                                                    </a>
                                                    <a href="5"><i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                        <i class="fa fa-star" aria-hidden="true"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9">
                        <div class="shop__product__option">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <div class="shop__product__option__left">
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <div class="shop__product__option__right">
                                        <p>Bộ lọc</p>
                                        <select>
                                            <option>Giá tăng dần</option>
                                            <option>Giá giảm dần</option>
                                            <option>Mới nhất</option>
                                            <option>Cũ nhất</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="result-found-title">Kết quả tìm kiếm</div>
                        <div class="row">
                            <%
                              DAOProduct dao = new DAOProduct();
                                DAOProductImage daoImage = new DAOProductImage();
                            Vector<Product> listProduct = (Vector<Product>)request.getAttribute("listPage");
                            for(Product list: listProduct){
                                ProductImage proImage = daoImage.getProductImageByProductID(list.getProductID());
                            %>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg">
                                        <img src="<%=proImage.getProductURL()%>" alt="alt"/>
                                        <%if(list.getUnitDiscount()!=0) {%>
                                        <div class="sale-cotification">Sale</div>
                                        <%}%>
                                    </div>
                                    <div class="product__item__text">
                                        <h6><%=list.getProductName()%></h6>
                                        <a href="#" class="add-cart">+ Thêm vào giỏ</a><a style="margin-left: 136px;" href="#">Mua ngay</a>
                                        <div style="display: flex;">
                                            <div class="rating">
                                                <%int star = (int)list.getTotalRate();
                                                Product pro2 = new Product();
                                                  String totalRate = pro2.convertStar(star);
                                                %>
                                                <%=totalRate%>
                                            </div>
                                            <div style="color: #0d0d0d;font-weight: 700;font-size: 15px; flex: 0 0 50%"><%=df.format(list.getUnitPrice())%></div>
                                        </div>
                                        <%if(list.getUnitDiscount()!=0) {%>
                                        <div style="color: #0d0d0d;font-weight: 700;font-size: 18px; flex: 0 0 50%">$67.24</div>
                                        <%}%>
                                    </div>
                                </div>
                            </div>
                            <%}%>
                        </div>
                        <div class="row">
                            <div class="product__pagination" style="margin: 0 auto;">
                                <c:set value="${requestScope.keyWord}" var="key"/>
                                <c:forEach begin="1" end="${endPage}" var="i">
                                    <c:if test="${requestScope.index == i}">
                                        <a class="active" style="border: none;background: #4cdc4c;width: 4%;" href="searchPageURL?keyWord=${key}&index=${i}">${i}</a>
                                    </c:if>
                                    <c:if test="${requestScope.index != i}">
                                        <a class="active" href="searchPageURL?keyWord=${key}&index=${i}">${i}</a>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Shop Section End -->

        <!-- Footer Section Begin -->
        <footer class="footer_1">
            <div class="container_1" style="height: 270px;padding-top: 28px;">
                <div class="row_1">
                    <div class="col_1" id="company">
                        <img style="height: 128px;" src="images/logo/logo.png" alt="" class="logo_1">
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
        <!-- Footer Section End -->

        <!-- Search End -->

        <!-- Js Plugins -->
    </body>

</html>
