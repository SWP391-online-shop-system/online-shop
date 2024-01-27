<%-- 
    Document   : productList
    Created on : Jan 17, 2024, 2:48:42 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="view.Product"%>
<%@page import="view.ProductImage"%>
<%@page import="model.DAOProduct"%>
<%@page import="model.DAOProductImage"%>
<%@page import="java.util.Vector" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
                                    <input name="keyWord" type="text" placeholder="Search...">
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
                                            <a data-toggle="collapse" data-target="#collapseThree">Lọc sản phẩm nhanh</a>
                                        </div>
                                        <div id="collapseThree" class="collapse show" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <div class="shop__sidebar__price">
                                                    <ul>
                                                        <li><a href="#">Được đánh giá cao</a></li>
                                                        <li><a href="#">Mới ra mắt</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-heading">
                                            <a data-toggle="collapse" data-target="#collapseSix">Lọc theo giá tiền</a>
                                        </div>
                                        <div id="collapseSix" class="collapse show" data-parent="#accordionExample">
                                            <%
                                            DAOProduct dao = new DAOProduct();
                                            DAOProductImage daoImage = new DAOProductImage();
                                            Double oldMinPrice=(Double)request.getAttribute("oldMinPrice");
                                            Double oldMaxPrice=(Double)request.getAttribute("oldMaxPrice");
                                            System.out.println("in jsp: oldMaxPrice = "+oldMaxPrice+" and oldMinPrice = "+oldMinPrice);
                                            Double maxPrice =(Double)request.getAttribute("maxPrice");
                                            Double minPrice = (Double)request.getAttribute("minPrice");
                                            System.out.println("in jsp: maxPrice = "+maxPrice+" and minPrice = "+minPrice);
                                            %>
                                            <div class="card-body">
                                                <div class="group">
                                                    <form action="ProductListURL" method="GET">
                                                        <input type="hidden" name="service" value="price"/>
                                                        <c:if test="${categoryID != ''}">
                                                            <input type="hidden" name="CategoryID" value="${categoryID}"/>
                                                        </c:if>
                                                        <div class="progress1"></div>
                                                        <div class="range-input">
                                                            <input name="inputMinPrice" class="range-min" max="<%=maxPrice%>" min="<%=minPrice%>" type="range" value="<%=(oldMinPrice==null ? minPrice : oldMinPrice)%>">
                                                            <input name="inputMaxPrice" class="range-max" max="<%=maxPrice%>" type="range" value="<%=(oldMaxPrice==null ? maxPrice : oldMaxPrice)%>">
                                                        </div>
                                                        <div class="range-text">
                                                            <div class="text-min"><%=df.format(oldMinPrice==null ? minPrice : oldMinPrice)%></div>
                                                            <div class="text-max"><%=df.format(oldMaxPrice==null ? maxPrice : oldMaxPrice)%></div>
                                                        </div>
                                                        <button class="submit-price-form" type="submit">Lọc</button>
                                                    </form>
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
                                        <form action="ProductListURL" method="GET">
                                            <c:if test="${categoryID == ''}">
                                                <input type="hidden" name="service" value="filter"/>
                                            </c:if>
                                            <c:if test="${categoryID != ''}">
                                                <input type="hidden" name="service" value="filter"/>
                                                <input type="hidden" name="CategoryID" value="${categoryID}"/>
                                            </c:if>
                                            <c:if test="${((requestScope.maxPrice != requestScope.oldMaxPrice)||(requestScope.minPrice != requestScope.oldMinPrice)) && (requestScope.oldMaxPrice != null && requestScope.oldMinPrice != null)}">
                                                <input name="inputMinPrice" type="hidden" value="<%=(oldMinPrice==null ? minPrice : oldMinPrice)%>">
                                                <input name="inputMaxPrice" type="hidden" value="<%=(oldMaxPrice==null ? maxPrice : oldMaxPrice)%>">
                                            </c:if>
                                            <select name="filterChoice" onchange="this.form.submit()">
                                                <%String filterChoice = (String)request.getAttribute("filterChoice");
                                                if(filterChoice == null){
                                                filterChoice = "createDate desc";
                                                }
                                                %>
                                                <option value="createDate desc"<%=(filterChoice.equals("createDate desc")||filterChoice.equals("p.CreateDate desc"))? "selected":""%>>Mới nhất</option>
                                                <option value="createDate asc"<%=(filterChoice.equals("createDate asc")||filterChoice.equals("p.CreateDate asc"))? "selected":""%>>Cũ nhất</option>
                                                <option value="priceasc"<%=(filterChoice.equals("priceasc")||filterChoice.equals("(UnitPrice*(100-UnitDiscount)/100) asc"))? "selected":""%>>Giá tăng dần</option>
                                                <option value="pricedesc"<%=(filterChoice.equals("pricedesc")||filterChoice.equals("(UnitPrice*(100-UnitDiscount)/100) desc"))? "selected":""%>>Giá giảm dần</option>
                                            </select>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <%
                                ResultSet rsPaging = (ResultSet)request.getAttribute("rsPaging");
                                
                            while(rsPaging.next()) {
                            %>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg">
                                        <img src="<%=rsPaging.getString("ProductURL")%>" alt="alt"/>
                                        <%if(rsPaging.getInt("UnitDiscount")!=0) {%>
                                        <div class="sale-cotification">Sale</div>
                                        <%}%>
                                        <%  DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                            Date date = new Date();
                                            if(rsPaging.getString("CreateDate").substring(0,10).equals(dateFormat.format(date))){%>
                                        <div class="sale-cotification">Mới</div>
                                        <%}%>
                                    </div>
                                    <div class="product__item__text">
                                        <h6><%=rsPaging.getString("ProductName")%></h6>
                                        <a href="#" class="add-cart">+ Thêm vào giỏ</a><a style="margin-left: 136px;" href="#">Mua ngay</a>
                                        <div style="display: flex;">
                                            <div class="rating">
                                                <%int star = (int)rsPaging.getInt("totalRate");
                                                  Product pro2 = new Product();
                                                  String totalRate = pro2.convertStar(star);
                                                %>
                                                <%=totalRate%>
                                            </div>
                                        </div>
                                        <div style="display: flex;">
                                            <%if(rsPaging.getInt("UnitDiscount")!= 0){%>
                                            <div style="color: red;font-weight: 700;font-size: 15px; flex: 0 0 50%; text-decoration: line-through;"><%=df.format(rsPaging.getDouble("UnitPrice"))%></div>
                                            <div style="color: #0d0d0d;font-weight: 700;font-size: 15px; flex: 0 0 50%"><%=df.format(rsPaging.getDouble("UnitPrice")*(100-rsPaging.getInt("UnitDiscount"))/100)%></div>
                                            <%} else {%>
                                            <div style="font-weight: 700;
                                                 font-size: 15px;
                                                 flex: -2 0 43%;
                                                 margin-left: 116px;
                                                 margin-top: -26px;"><%=df.format(rsPaging.getDouble("UnitPrice"))%></div>
                                            <%}%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%}%>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="product__pagination">
                                    <c:set value="${requestScope.categoryID}" var="categoryID"/>
                                    <c:forEach begin="1" end="${endPage}" var="i">
                                        <c:if test="${categoryID == ''}">
                                            <!-- Price range is different from begin -->
                                            <c:if test="${((requestScope.maxPrice != requestScope.oldMaxPrice)||(requestScope.minPrice != requestScope.oldMinPrice)) && (requestScope.oldMaxPrice != null && requestScope.oldMinPrice != null)}">
                                                <c:if test="${requestScope.index == i}">
                                                    <a class="active"  style="border: none;background: #4cdc4c;width: 4%;" href="ProductListURL?service=price&index=${i}&filterChoice=<%=filterChoice%>&inputMinPrice=<%=oldMinPrice%>&inputMaxPrice=<%=oldMaxPrice%>">${i}</a>
                                                </c:if>
                                                <c:if test="${requestScope.index != i}">
                                                    <a class="active" href="ProductListURL?service=price&index=${i}&filterChoice=<%=filterChoice%>&inputMinPrice=<%=oldMinPrice%>&inputMaxPrice=<%=oldMaxPrice%>">${i}</a>
                                                </c:if>
                                            </c:if>

                                            <c:if test="${((requestScope.maxPrice == requestScope.oldMaxPrice) &&(requestScope.minPrice == requestScope.oldMinPrice))|| (requestScope.oldMinPrice==null && requestScope.oldMaxPrice==null)}">
                                                <c:if test="${requestScope.index == i}">
                                                    <a class="active"  style="border: none;background: #4cdc4c;width: 4%;" href="ProductListURL?service=filter&index=${i}&filterChoice=<%=filterChoice%>&inputMinPrice=<%=oldMinPrice%>&inputMaxPrice=<%=oldMaxPrice%>">${i}</a>
                                                </c:if>
                                                <c:if test="${requestScope.index != i}">                                                    <a class="active" href="ProductListURL?service=filter&index=${i}&filterChoice=<%=filterChoice%>&inputMinPrice=<%=oldMinPrice%>&inputMaxPrice=<%=oldMaxPrice%>">${i}</a>

                                                </c:if>
                                            </c:if>
                                        </c:if>
                                        <c:if test="${categoryID != ''}">
                                            <c:if test="${requestScope.index == i}">
                                                <a class="active"  style="border: none;background: #4cdc4c;width: 4%;" href="ProductListURL?CategoryID=${categoryID}&index=${i}&filterChoice=<%=filterChoice%>&inputMinPrice=<%=oldMinPrice%>&inputMaxPrice=<%=oldMaxPrice%>">${i}</a>
                                            </c:if>
                                            <c:if test="${requestScope.index != i}">
                                                <a class="active" href="ProductListURL?CategoryID=${categoryID}&index=${i}&filterChoice=<%=filterChoice%>&inputMinPrice=<%=oldMinPrice%>&inputMaxPrice=<%=oldMaxPrice%>">${i}</a>
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                </div>
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
        <!-- Footer Section End -->

        <!-- Search Begin -->
        <div class="search-model">
            <div class="h-100 d-flex align-items-center justify-content-center">
                <div class="search-close-switch">+</div>
                <form class="search-model-form">
                    <input type="text" id="search-input" placeholder="Search here.....">
                </form>
            </div>
        </div>
        <script src="js/price.js"></script>
    </body>

</html>