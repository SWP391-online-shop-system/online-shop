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
                                    <%String oldKey = (String)request.getAttribute("keyWord");%>
                                    <input name="keyWord" type="text" placeholder="Search..." value="<%=(oldKey==null||oldKey.equals(""))?"":oldKey%>">
                                    <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                                </form>
                            </div>
                            <div class="shop__sidebar__accordion">
                                <div class="accordion" id="accordionExample">
                                    <div class="hottest-pro">
                                        <div class="hottest-pro-title">Bán chạy nhất</div>
                                        <div class="row" style="display: contents">
                                            <%
                                                DAOProduct dao = new DAOProduct();
                                                ResultSet rsHotPro = dao.getData("select * from Product as p join ProductImage as pi on p.ProductID = pi.ProductID where  pi.ProductURL like '%_1%'\n"
                                                +"group by p.ProductID having min(p.TotalStock - p.UnitInStock) > 0");
                                            while(rsHotPro.next()) {
                                            %>
                                            <div class="product__item" style="border: 1px solid #c1e8c1ba;
                                                 border-radius: 40px;">
                                                <div class="product__item__pic set-bg" style="height: 201px;">
                                                    <img style="width: 192px;
                                                         height: 174px;
                                                         margin-left: 25px;
                                                         margin-top: 10px;" src="<%=rsHotPro.getString("ProductURL")%>" alt="alt"/>
                                                    <%if(rsHotPro.getInt("UnitDiscount")!=0) {%>
                                                    <div class="sale-cotification">Sale</div>
                                                    <%}%>
                                                    <%    ResultSet rsNew2Product = dao.getData("select * from product as p join productImage as pi "
                                                       + "on p.ProductID = pi.ProductID "
                                                       + "where pi.ProductURL like '%_1%' "
                                                       + "order by p.CreateDate desc limit 6 ");
                                                         while(rsNew2Product.next()) {
                                                            if(rsHotPro.getString("CreateDate").substring(0,10).equals(rsNew2Product.getString("CreateDate").substring(0,10))){%>
                                                    <div class="sale-cotification">Mới</div>
                                                    <%}}%>
                                                </div>
                                                <div class="product__item__text">
                                                    <h6 style="margin-left: 34px;"><%=rsHotPro.getString("ProductName")%></h6>
                                                    <a href="#" class="add-cart" style="left: 12px;">+ Thêm vào giỏ</a><a style="margin-left: 136px;" href="#">Mua ngay</a>
                                                    <div style="display: flex;">
                                                        <div class="rating" style="margin-left: 30px;">
                                                            <%int star = (int)rsHotPro.getInt("totalRate");
                                                              Product pro2 = new Product();
                                                              String totalRate = pro2.convertStar(star);
                                                            %>
                                                            <%=totalRate%>
                                                        </div>
                                                    </div>
                                                    <div style="display: flex;flex-direction: row;justify-content: space-between;">
                                                        <%if(rsHotPro.getInt("UnitDiscount")!= 0){%>
                                                        <div style="color: red;font-weight: 700;font-size: 15px; flex: 0 0 50%; text-decoration: line-through;"><%=df.format(rsHotPro.getDouble("UnitPrice"))%></div>
                                                        <div style="color: #0d0d0d;font-weight: 700;font-size: 15px; flex: 0 0 50%"><%=df.format(rsHotPro.getDouble("UnitPrice")*(100-rsHotPro.getInt("UnitDiscount"))/100)%></div>
                                                        <%} else {%>
                                                        <div style="font-weight: 700;
                                                             font-size: 15px;
                                                             flex: -2 0 43%;
                                                             margin-left: 146px;
                                                             margin-top: -26px;"><%=df.format(rsHotPro.getDouble("UnitPrice"))%></div>
                                                        <%}%>
                                                    </div>
                                                </div>
                                            </div>

                                            <%}%>
                                        </div>
                                    </div>
                                    <div class="card"style="margin-top: 85px;">
                                        <div class="card-heading">
                                            <a data-toggle="collapse" data-target="#collapseOne">Danh mục</a>
                                        </div>
                                        <%String TotalRate_raw = (String)request.getAttribute("TotalRate");
                                       int TotalRate=0;
                                       if(TotalRate_raw==null || TotalRate_raw.equals("")) {
                                           TotalRate = 0;
                                          } else {
                                          TotalRate = Integer.parseInt(TotalRate_raw);
                                           }
                                       int CategoryID = 0;
                                           String CategoryID_raw = (String)request.getAttribute("categoryID");
                                           if(CategoryID_raw == null || CategoryID_raw.equals("")) {
                                           CategoryID = 0;
                                           } else {
                                           CategoryID = Integer.parseInt(CategoryID_raw);
                                           }
                                           ResultSet rsCategory = (ResultSet)request.getAttribute("CategoryResult");
                                           String keyWord = (String)request.getAttribute("keyWord");
                                        %>
                                        <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <div class="shop__sidebar__categories">
                                                    <ul class="nice-scroll">
                                                        <li><a style="color: #f7a749;" href="<%=(keyWord==null||keyWord.equals(""))?"ProductListURL":"searchPageURL?keyWord="+keyWord%>">Tất cả sản phẩm</a></li>
                                                            <%String type = (String)request.getAttribute("type");
                                                            if(type==null || type.equals("")) {
                                                            type = "";
                                                                }
                                                            %>
                                                        <li class="unique-li" style="<%=type.equals("showSale")?"background: #0091ff2b; width:190px;":""%>"><a style=" color: #f7a749;" href="ProductListURL?keyWord=${keyWord}&TotalRate=<%=TotalRate%>&type=showSale&CategoryID=${categoryID}&filterChoice=${filterChoice}&inputMinPrice=${oldMinPrice}&inputMaxPrice=${oldMaxPrice}">Đang giảm giá</a></li>
                                                            <%while(rsCategory.next()) {%>
                                                        <li style="<%=CategoryID==rsCategory.getInt(1) ? "background: #0091ff2b; width:190px;":""%>"><a href="ProductListURL?keyWord=${keyWord}&type=<%=type%>&CategoryID=<%=rsCategory.getInt(1)%>&index=1"><%=rsCategory.getString(2)%></a></li>
                                                            <%}%>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-heading">
                                            <a data-toggle="collapse" data-target="#collapseThree">Lọc theo đánh giá</a>
                                        </div>
                                        <div id="collapseThree" class="collapse show" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <div class="shop__sidebar__price">
                                                    <ul>
                                                        <li style="<%=TotalRate==5?"background: #0091ff2b;":""%>"><a href="searchPageURL?keyWord=${keyWord}&type=<%=type%>&CategoryID=${categoryID}&TotalRate=5&filterChoice=${filterChoice}&inputMinPrice=${oldMinPrice}&inputMaxPrice=${oldMaxPrice}">
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                            </a></li>
                                                        <li style="<%=TotalRate==4?"background: #0091ff2b;":""%>"><a href="searchPageURL?keyWord=${keyWord}&type=<%=type%>&CategoryID=${categoryID}&TotalRate=4&filterChoice=${filterChoice}&inputMinPrice=${oldMinPrice}&inputMaxPrice=${oldMaxPrice}">
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                            </a></li>
                                                        <li style="<%=TotalRate==3 ? "background: #0091ff2b;" : ""%>"><a href="searchPageURL?type=<%=type%>&keyWord=${keyWord}&CategoryID=${categoryID}&TotalRate=3&filterChoice=${filterChoice}&inputMinPrice=${oldMinPrice}&inputMaxPrice=${oldMaxPrice}">
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                            </a></li>
                                                        <li style="<%=TotalRate==2 ? "background: #0091ff2b;" : ""%>"><a href="searchPageURL?type=<%=type%>&keyWord=${keyWord}&CategoryID=${categoryID}&TotalRate=2&filterChoice=${filterChoice}&inputMinPrice=${oldMinPrice}&inputMaxPrice=${oldMaxPrice}">
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                            </a></li>
                                                        <li style="<%=TotalRate==1 ? "background: #0091ff2b;" : ""%>"><a href="searchPageURL?type=<%=type%>&keyWord=${keyWord}&CategoryID=${categoryID}&TotalRate=1&filterChoice=${filterChoice}&inputMinPrice=${oldMinPrice}&inputMaxPrice=${oldMaxPrice}">
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                            </a></li>
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
                                            DAOProductImage daoImage = new DAOProductImage();
                                            Double oldMinPrice=(Double)request.getAttribute("oldMinPrice");
                                            Double oldMaxPrice=(Double)request.getAttribute("oldMaxPrice");
                                            Double maxPrice =(Double)request.getAttribute("maxPrice");
                                            Double minPrice = (Double)request.getAttribute("minPrice");
                                            %>
                                            <div class="card-body">
                                                <div class="group">
                                                    <form action="searchPageURL" method="GET">
                                                        <input type="hidden" name="keyWord" value="${keyWord}"/>
                                                        <input type="hidden" name="type" value="${type}"/>
                                                        <input type="hidden" name="TotalRate" value="${TotalRate}"/>
                                                        <div class="progress1"></div>
                                                        <div class="range-input">
                                                            <input name="inputMinPrice" class="range-min" max="<%=maxPrice%>" min="<%=minPrice%>" type="range" value="<%=(oldMinPrice==null ? minPrice : oldMinPrice)%>">
                                                            <input name="inputMaxPrice" class="range-max" max="${maxPrice}" type="range" value="<%=(oldMaxPrice==null ? maxPrice : oldMaxPrice)%>">
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
                                        <a href="<%=(keyWord==null||keyWord.equals("")) ? "ProductListURL" : "searchPageURL?keyWord="+keyWord%>"><button class="reset-filter" type="submit">Xóa tất cả</button></a>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9">
                        <div class="shop__product__option">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <%String key = (String)request.getAttribute("keyWord");
                                    if(key.equals("")) {%>
                                    <div style="font-size: 22px; letter-spacing: 1px;">Kết quả tìm kiếm</div>
                                    <%}else{%>
                                    <div style="font-size: 22px; letter-spacing: 1px;">Kết quả tìm kiếm cho '${requestScope.keyWord}'</div>
                                    <%}%>
                                    <div class="shop__product__option__left">
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <div class="shop__product__option__right">
                                        <p>Bộ lọc</p>
                                        <form action="searchPageURL" method="GET">
                                            <input type="hidden" name="keyWord" value="${requestScope.keyWord}"/>
                                            <input type="hidden" name="type" value="<%=type%>"/>
                                            <input type="hidden" name="TotalRate" value="${TotalRate}"/>
                                            <input name="inputMinPrice" type="hidden" value="<%=(oldMinPrice==null ? minPrice : oldMinPrice)%>">
                                            <input name="inputMaxPrice" type="hidden" value="<%=(oldMaxPrice==null ? maxPrice : oldMaxPrice)%>">
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
                                if(!rsPaging.isBeforeFirst()) {%>
                            <div class="notify-empty">Không có sản phẩm nào</div>
                            <%}
                            while(rsPaging.next()) {
                            %>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg">
                                        <img src="<%=rsPaging.getString("ProductURL")%>" alt="alt"/>
                                        <%if(rsPaging.getInt("UnitDiscount")!=0) {%>
                                        <div class="sale-cotification">Sale</div>
                                        <%}%>
                                        <%    ResultSet rsNewProduct = dao.getData("select * from product as p join productImage as pi "
                                        + "on p.ProductID = pi.ProductID "
                                        + "where pi.ProductURL like '%_1%' "
                                        + "order by p.CreateDate desc limit 6 ");
                                        while(rsNewProduct.next()) {
                                             if(rsPaging.getString("CreateDate").substring(0,10).equals(rsNewProduct.getString("CreateDate").substring(0,10))){%>
                                        <div class="sale-cotification">Mới</div>
                                        <%}}%>
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
                                    <c:set value="${requestScope.keyWord}" var="keyWord"/>
                                    <c:forEach begin="1" end="${endPage}" var="i">
                                        <c:if test="${requestScope.index == i}">
                                            <a class="active" style="background: #7fad39;border-color: #7fad39;color: #ffffff;" href="searchPageURL?keyWord=${keyWord}&type=<%=type%>&TotalRate=<%=TotalRate%>&index=${i}&filterChoice=<%=filterChoice%>&inputMinPrice=<%=oldMinPrice%>&inputMaxPrice=<%=oldMaxPrice%>">${i}</a>
                                        </c:if>
                                        <c:if test="${requestScope.index != i}">
                                            <a class="active"                                                      href="searchPageURL?keyWord=${keyWord}&type=<%=type%>&TotalRate=<%=TotalRate%>&index=${i}&filterChoice=<%=filterChoice%>&inputMinPrice=<%=oldMinPrice%>&inputMaxPrice=<%=oldMaxPrice%>">${i}</a>
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
        <!-- Js Plugins -->
        <script src="js/searchPrice.js"></script>
    </body>

</html>