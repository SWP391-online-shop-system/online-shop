<%-- 
    Document   : productList
    Created on : Jan 17, 2024, 2:48:42 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="view.User" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.DAOCart, view.Cart,view.User" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
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
<%@page import="java.util.Calendar" %>

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
        <!-- comment start -->
        <div class="header" style="margin-top: 21px;">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <div class="header-title" style="margin-top: -16px;">
                <div class="header-title-left">
                    <ul>
                        <li>
                            <div class="header-email">
                                <i class="fa-regular fa-envelope"></i>
                                <span class="header-email-title">SmartketFPT@gmail.com</span>
                            </div>
                        </li>
                        <li>
                            <div class="header-support">
                                <div><a href="#">Hỗ trợ</a></div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="header-title-right">
                    <div class="header-title-right-social">
                        <div><a href="#" title="Trang Facebook chúng tôi"><i class="fa-brands fa-facebook"></i></a></div>
                        <div><a href="#" title="Trang Twitter của chúng tôi"><i class="fa-brands fa-x-twitter"></i></a></div>
                    </div>
                    <div class="header-title-right-about">
                        <a href="#">Về chúng tôi</a>
                    </div>
                    <div class="header-title-right-login">
                        <!DOCTYPE html>
                        <html lang="en">
                            <head>
                                <meta charset="UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>Smarket</title>
                                <link rel="stylesheet" href="css/login.css"/>
                            </head>
                            <body> 
                                <%
                                    String message1 = (String)request.getAttribute("message");
                                    String messagesu1 = (String)request.getAttribute("messageSignUp");
                                    String msg1 = (String)request.getAttribute("msg1");
                                %>
                                <c:if test="${sessionScope.account.roleID == 5}">
                                    <a href="#"style="margin-right: 50px;">ADMIN</a>

                                </c:if>
                                <c:if test="${sessionScope.account.roleID == 4}">
                                    <a href="#">SALE MANAGER</a>


                                </c:if>
                                <c:if test="${sessionScope.account.roleID == 3}">
                                    <a href="#">SALE</a>


                                </c:if>
                                <c:if test="${sessionScope.account.roleID == 2}">
                                    <a href="#">Marketing</a>
                                </c:if>
                                <c:if test="${sessionScope.account != null}">
                                    <a href="logout">Đăng xuất</a>
                                    <a href="profileUser.jsp"><img style="width: 30px;
                                                                   height: 30px;
                                                                   margin-right: -10px;
                                                                   margin-bottom: -8px;
                                                                   margin-left: 7px;
                                                                   border-radius: 50%;" class="styling1" src="images/user/default_avatar.jpg" alt="Admin Image"></a>
                                    </c:if>
                                    <c:if test="${sessionScope.account == null}">
                                    <button href="#" style="border: none; font-size:16px; font-family: math;" id="show-login">Đăng nhập</button>
                                </c:if>
                                <!-- Login Pop-up Form -->
                                <form action="loginURL" method="post">
                                    <div class="popup ${requestScope.activeLogin}" id="loginPopup">
                                        <div class="close-btn" onclick="togglePopup('loginPopup')">x</div>
                                        <div class="form">
                                            <h2>Đăng nhập</h2>
                                            <p class="text-danger" style="
                                               color: red;
                                               font-size: 20px;
                                               font-weight: 700;
                                               text-align: left;"><%=(message1 == null) ? "" : message1%></p>
                                            <div class="form-element">
                                                <label for="email">Email</label>
                                                <input type="email" id="email" name="email" placeholder="Nhập email" required 
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này và bao gồm @')" 
                                                       oninput="setCustomValidity('')">
                                            </div>
                                            <div class="form-element">
                                                <label for="password">Mật khẩu</label>
                                                <input type="password" id="pass" name="pass" placeholder="Nhập mật khẩu" required 
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                                       oninput="setCustomValidity('')">
                                            </div>
                                            <div class="form-element">
                                                <button type="submit" value="login" >Đăng nhập</button>
                                            </div>
                                            <div class="form-element">
                                                <button id="showSignup" onclick="togglePopup('signupPopup')">Đăng kí</button>
                                            </div>
                                            <div class="form-element">
                                                <a href="#">Quên mật khẩu?</a>
                                            </div>
                                        </div>
                                    </div>
                                </form>

                                <!-- Registration Pop-up Form -->
                                <form action="signupURL" method="post">
                                    <input type="hidden" name="service" value="signupRegister">
                                    <div class="popup ${requestScope.activeSignUp}" id="signupPopup">
                                        <div class="close-btn" onclick="togglePopup('signupPopup')">x</div>
                                        <div class="form">
                                            <h2>Đăng kí</h2>
                                            <%User u = (User)request.getAttribute("lastUser");
                                    if(u == null) {%>
                                            <div class="form-element">
                                                <label for="registerEmail">Họ</label>
                                                <input type="text" name="rFName" placeholder="Nhập họ" required 
                                                       pattern="[A-Za-zÀ-ỹ ]+" oninvalid="this.setCustomValidity('Vui lòng điền thông tin này, Không bao gồm số và kí tự đặc biệt')" 
                                                       oninput="setCustomValidity('')" >
                                            </div>
                                            <div class="form-element">
                                                <label for="registerEmail">Tên</label>
                                                <input type="text" name="rLName" placeholder="Nhập Tên" required
                                                       pattern="[A-Za-zÀ-ỹ ]+" oninvalid="this.setCustomValidity('Vui lòng điền thông tin này, Không bao gồm số và kí tự đặc biệt')" 
                                                       oninput="setCustomValidity('')" >
                                            </div>
                                            <div class="form-element" style="margin-top: 28px;">
                                                <label for="registerEmail">Email</label>
                                                <input type="email" name="remail" placeholder="Nhập email"required
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này và bao gồm @')" 
                                                       oninput="setCustomValidity('')" >
                                            </div>
                                            <div class="form-element">
                                                <label for="registerPassword">Mật khẩu</label>
                                                <input type="password" name="rpass" placeholder="Nhập mật khẩu" required
                                                       minlength="6" title="Mật khẩu phải chứa từ 6 đến 8 ký tự" 
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                                       oninput="setCustomValidity('')">
                                            </div>
                                            <div class="form-element">
                                                <label for="registerPassword">Nhập lại mật khẩu</label>
                                                <input type="password" name="rrepass" placeholder="Nhập lại mật khẩu" required
                                                       title="Mật khẩu phải chứa từ 6 đến 8 ký tự" 
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                                       oninput="setCustomValidity('')">
                                            </div>
                                            <%} else {%>
                                            <div class="form-element">
                                                <label for="registerEmail">Họ</label>
                                                <input type="text" name="rFName" placeholder="Nhập họ" required 
                                                       pattern="[A-Za-zÀ-ỹ ]+" oninvalid="this.setCustomValidity('Vui lòng điền thông tin này, Không bao gồm số và kí tự đặc biệt')" 
                                                       oninput="setCustomValidity('')" value="<%=u.getLastName()%>">
                                            </div>
                                            <div class="form-element">
                                                <label for="registerEmail">Tên</label>
                                                <input type="text" name="rLName" placeholder="Nhập Tên" required
                                                       pattern="[A-Za-zÀ-ỹ ]+" oninvalid="this.setCustomValidity('Vui lòng điền thông tin này, Không bao gồm số và kí tự đặc biệt')" 
                                                       oninput="setCustomValidity('')" value="<%=u.getFirstName()%>">
                                            </div>
                                            <div class="form-element" style="margin-top: 28px;">
                                                <label for="registerEmail">Email</label>
                                                <input type="email" name="remail" placeholder="Nhập email"required
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này và bao gồm @')" 
                                                       oninput="setCustomValidity('')" value="<%=u.getEmail()%>">
                                            </div>
                                            <div class="form-element">
                                                <label for="registerPassword">Mật khẩu</label>
                                                <input type="password" name="rpass" placeholder="Nhập mật khẩu" required
                                                       minlength="6" title="Mật khẩu phải chứa từ 6 đến 8 ký tự" 
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                                       oninput="setCustomValidity('')"value="<%=u.getPassword()%>">
                                            </div>
                                            <div class="form-element">
                                                <label for="registerPassword">Nhập lại mật khẩu</label>
                                                <input type="password" name="rrepass" placeholder="Nhập lại mật khẩu" required
                                                       title="Mật khẩu phải chứa từ 6 đến 8 ký tự" 
                                                       oninvalid="this.setCustomValidity('Vui lòng điền thông tin này')" 
                                                       oninput="setCustomValidity('')"value="<%=u.getRePassword()%>">
                                            </div>
                                            <%}%>
                                            <p class="text-danger" style="
                                               color: red;
                                               font-size: 20px;
                                               font-weight: 700;
                                               text-align: left;"><%=(messagesu1 == null) ? "" : messagesu1%></p>
                                            <div class="form-element">
                                                <button type="submit" >Đăng kí</button>
                                            </div>
                                            Ðã có tài khoản?<a id="loginAfterRegister" href="#">Đăng nhập ngay</a>
                                        </div>
                                    </div>
                                </form>
                            </body>
                            <script src="js/login.js">

                            </script>
                        </html>
                    </div>
                </div>
            </div>  
            <div class="header-content" style="margin-bottom: 20px;">
                <div class="header-content-logo">
                    <a href="HomePageURL"><img src="images/logo/logo.png"alt="404"/></a>
                </div>
                <div class="header-content-menu">
                    <ul>
                        <li class="active"><a href="HomePageURL">Trang chủ</a></li>
                        <li><a href="ProductListURL?service=ShowAllProduct">Mua hàng</a></li>
                        <li>
                            <a href="#">Trang</a>
                            <ul class="header-content-menu-drop-down">
                                <c:if test="${sessionScope.account == null}">
                                    <li><a href="loginURL" onclick="alertOpenCart()">Giỏ hàng của tôi</a></li>
                                    </c:if>
                                    <c:if test="${sessionScope.account != null}">
                                    <li><a href="CartURL">Giỏ hàng của tôi</a></li>
                                    </c:if>
                                <li><a href="#">Đơn hàng của tôi</a></li>
                            </ul>
                        </li>
                        <li><a href="blog">Blog</a></li>
                            <c:if test="${sessionScope.account != null}">
                            <li><a href="profileUser.jsp">Tài khoản</a></li>
                        </c:if>            </ul>
                </div>
                <div class="header-content-right-menu">
                    <ul>
                        <li class="margin-unit"><a href="#" title="Đơn hàng của tôi"><i class="fa-solid fa-file-invoice-dollar"></i></i></a></li>
                            <c:if test="${sessionScope.account == null}">
                            <li><a href="loginURL" onclick="alertOpenCart()"title="Giỏ hàng của tôi"><i class="fa-solid fa-cart-shopping"></i></a></li>
                                </c:if>
                                <c:if test="${sessionScope.account != null}">
                            <li>      
                                <%
                                HttpSession session2 = request.getSession();
                                User user = (User) session2.getAttribute("account");
                                int userID = user.getUserID();
                                DAOCart dao = new DAOCart();
                                ResultSet rs = dao.getData("SELECT count(*) as count FROM Cart AS c JOIN Product AS p ON c.ProductID = p.ProductID where userID = "+userID+"");
                                while(rs.next()){
                                %>
                                <span class="count-cart" id="countCart" style="position: absolute;
                                      margin-left: 17px;
                                      background-color: #ff0000;
                                      color: #ffffff;
                                      border-radius: 50%;
                                      padding: 0px 5px;
                                      font-size: 13px;
                                      z-index: 9;
                                      top: 11px;
                                      left: 3px;"><%=rs.getInt(1)%></span>
                                <%}%>
                                <a href="CartURL" title="Giỏ hàng của tôi"><i class="fa-solid fa-cart-shopping"></i></a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
        <script>
            function alertOpenCart() {
                alert('Đăng nhập để xem giỏ hàng của bạn');
            }
        </script>
        <!-- comment end-->
        <%DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);%>
        <!-- Shop Section Begin -->
        <section class="shop spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3" style="margin-left: -40px;
                         margin-right: 40px;">
                        <div class="shop__sidebar">
                            <div class="shop__sidebar__search">
                                <form action="searchPageURL" method="GET">
                                    <input name="keyWord" type="text" placeholder="Search...">
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
                                                ResultSet rsHotPro = dao.getData("select * from Product as p join ProductImage as pi on p.ProductID = pi.ProductID where p.ProductStatus = 0 and  pi.ProductURL = pi.ProductURLShow \n"
                                               +  "group by p.ProductID having min(p.TotalStock - p.UnitInStock) >0 order by (p.TotalStock - p.UnitInStock) desc limit 1");
                                            if(rsHotPro.next()) {
                                            %>
                                            <div class="product__item" style="border: 1px solid #c1e8c1ba;border-radius: 40px;">
                                                <div class="product__item__pic set-bg" style="height: 201px;">
                                                    <a href="ProductDetailURL?ProductID=<%=rsHotPro.getInt(1)%>">
                                                        <img style="width: 192px;
                                                             height: 174px;
                                                             margin-left: 25px;
                                                             margin-top: 10px;" src="<%=rsHotPro.getString("ProductURL")%>" alt="alt"/>
                                                    </a>
                                                    <%if(rsHotPro.getInt("UnitDiscount")!=0) {%>
                                                    <div class="sale-cotification" style="margin-left: 77px;">Sale</div>
                                                    <%}%>
                                                    <%    ResultSet rsNew2Product = dao.getData("select * from product as p join productImage as pi "
                                                       + "on p.ProductID = pi.ProductID "
                                                       + "where p.ProductStatus = 0 and pi.ProductURL = pi.ProductURLShow "
                                                       + "order by p.CreateDate desc limit 6 ");
                                                         while(rsNew2Product.next()) {
                                                            if(rsHotPro.getString("CreateDate").substring(0,10).equals(rsNew2Product.getString("CreateDate").substring(0,10))){%>
                                                    <div class="sale-cotification">Mới</div>
                                                    <%}}%>
                                                </div>
                                                <div class="product__item__text">
                                                    <h6 style="text-align: center;"><%=rsHotPro.getString("ProductName")%></h6>
                                                    <%
                                                    User testUser = (User)session.getAttribute("account");
                                                    if(testUser == null) {%>
                                                    <a onclick="alertOpenCart();" style="left: 12px;">+ Thêm vào giỏ</a><a style="margin-left: 136px;" href="#">Mua ngay</a>
                                                    <%} else{%>
                                                    <a href="#" onclick="addToCart(<%=rsHotPro.getInt("ProductID")%>)" class="add-cart" style="left: 12px;">+ Thêm vào giỏ</a><a style="margin-left: 136px;" href="#">Mua ngay</a>
                                                    <%}%>
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
                                                        <div style="color: red;font-weight: 700;font-size: 15px; flex: 0 0 50%; text-decoration: line-through;"><%=df.format(rsHotPro.getDouble("UnitPrice"))%>đ</div>
                                                        <div style="color: #0d0d0d;font-weight: 700;font-size: 15px; flex: 0 0 50%"><%=df.format(rsHotPro.getDouble("UnitPrice")*(100-rsHotPro.getInt("UnitDiscount"))/100)%>đ</div>
                                                        <%} else {%>
                                                        <div style="font-weight: 700;
                                                             font-size: 15px;
                                                             flex: -2 0 43%;
                                                             margin-left: 146px;
                                                             margin-top: -26px;"><%=df.format(rsHotPro.getDouble("UnitPrice"))%>đ</div>
                                                        <%}%>
                                                    </div>
                                                </div>
                                            </div>
                                            <%}%>
                                        </div>
                                    </div>
                                    <div class="card" style="margin-top: 85px;">
                                        <div class="card-heading">
                                            <a data-toggle="collapse" data-target="#collapseOne" href="ProductListURL">Danh mục</a>
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
                                        %>
                                        <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <div class="shop__sidebar__categories">
                                                    <ul class="nice-scroll">
                                                        <li><a style="color: #f7a749;" href="ProductListURL">Tất cả sản phẩm</a></li>
                                                            <%String type = (String)request.getAttribute("type");
                                                            if(type==null || type.equals("")) {
                                                            type = "";
                                                                }
                                                            %>
                                                        <li class="unique-li" style="<%=type.equals("showSale")?"background: #0091ff2b; width:190px;":""%>"><a style=" color: #f7a749;" href="ProductListURL?service=filter&TotalRate=<%=TotalRate%>&type=showSale&CategoryID=${categoryID}&filterChoice=${filterChoice}&inputMinPrice=${oldMinPrice}&inputMaxPrice=${oldMaxPrice}&index=1">Đang giảm giá</a></li>
                                                            <%while(rsCategory.next()) {%>
                                                        <li style="<%=CategoryID==rsCategory.getInt(1) ? "background: #0091ff2b; width:190px;":""%>"><a href="ProductListURL?service=filter&type=<%=type%>&CategoryID=<%=rsCategory.getInt(1)%>&TotalRate=<%=TotalRate%>&filterChoice=${filterChoice}&inputMinPrice=${oldMinPrice}&inputMaxPrice=${oldMaxPrice}&index=1"><%=rsCategory.getString(2)%></a></li>
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
                                                        <li style="<%=TotalRate==5?"background: #0091ff2b;":""%>"><a href="ProductListURL?service=filter&type=<%=type%>&CategoryID=${categoryID}&TotalRate=5&filterChoice=${filterChoice}&inputMinPrice=${oldMinPrice}&inputMaxPrice=${oldMaxPrice}&index=1">
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                            </a></li>
                                                        <li style="<%=TotalRate==4?"background: #0091ff2b;":""%>"><a href="ProductListURL?service=filter&type=<%=type%>&CategoryID=${categoryID}&TotalRate=4&filterChoice=${filterChoice}&inputMinPrice=${oldMinPrice}&inputMaxPrice=${oldMaxPrice}&index=1">
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                            </a></li>
                                                        <li style="<%=TotalRate==3 ? "background: #0091ff2b;" : ""%>"><a href="ProductListURL?service=filter&type=<%=type%>&CategoryID=${categoryID}&TotalRate=3&filterChoice=${filterChoice}&inputMinPrice=${oldMinPrice}&inputMaxPrice=${oldMaxPrice}&index=1">
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                            </a></li>
                                                        <li style="<%=TotalRate==2 ? "background: #0091ff2b;" : ""%>"><a href="ProductListURL?service=filter&type=<%=type%>&CategoryID=${categoryID}&TotalRate=2&filterChoice=${filterChoice}&inputMinPrice=${oldMinPrice}&inputMaxPrice=${oldMaxPrice}&index=1">
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                                <i class="fa fa-star-o" aria-hidden="true"></i>
                                                            </a></li>
                                                        <li style="<%=TotalRate==1 ? "background: #0091ff2b;" : ""%>"><a href="ProductListURL?service=filter&type=<%=type%>&CategoryID=${categoryID}&TotalRate=1&filterChoice=${filterChoice}&inputMinPrice=${oldMinPrice}&inputMaxPrice=${oldMaxPrice}&index=1">
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
                                                    <form action="ProductListURL" method="GET">
                                                        <input type="hidden" name="service" value="filter"/>
                                                        <input type="hidden" name="index" value="1"/>
                                                        <c:if test="${categoryID != ''}">
                                                            <input type="hidden" name="CategoryID" value="${categoryID}"/>
                                                            <input type="hidden" name="type" value="${type}"/>
                                                        </c:if>
                                                        <c:if test="${TotalRate != ''}">
                                                            <input type="hidden" name="TotalRate" value="${TotalRate}"/>
                                                            <input type="hidden" name="type" value="${type}"/>
                                                        </c:if>
                                                        <div class="progress1"></div>
                                                        <div class="range-input">
                                                            <input name="inputMinPrice" class="range-min" max="<%=maxPrice%>" min="<%=minPrice%>" type="range" value="<%=(oldMinPrice==null ? minPrice : oldMinPrice)%>">
                                                            <input name="inputMaxPrice" class="range-max" max="<%=maxPrice%>" type="range" value="<%=(oldMaxPrice==null ? maxPrice : oldMaxPrice)%>">
                                                        </div>
                                                        <div class="range-text">
                                                            <div class="text-min"><%=df.format(oldMinPrice==null ? minPrice : oldMinPrice)%>đ</div>
                                                            <div class="text-max"><%=df.format(oldMaxPrice==null ? maxPrice : oldMaxPrice)%>đ</div>
                                                        </div>
                                                        <button class="submit-price-form" type="submit">Lọc</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <form action="ProductListURL" method="GET">
                                            <button class="reset-filter" type="submit">Xóa tất cả</button>
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
                                    <div class="shop__product__option__left">
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <div class="shop__product__option__right">
                                        <p>Bộ lọc</p>
                                        <form action="ProductListURL" method="GET">
                                            <input type="hidden" name="index" value="1"/>
                                            <c:if test="${categoryID == ''}">
                                                <input type="hidden" name="service" value="filter"/>
                                                <input type="hidden" name="type" value="<%=type%>"/>
                                            </c:if>
                                            <c:if test="${categoryID != ''}">
                                                <input type="hidden" name="service" value="filter"/>
                                                <input type="hidden" name="CategoryID" value="${categoryID}"/>
                                                <input type="hidden" name="type" value="<%=type%>"/>
                                            </c:if>
                                            <c:if test="${TotalRate != ''}">
                                                <input type="hidden" name="TotalRate" value="${TotalRate}"/>
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
                                System.out.println("Prepare to getattribute rsPaging!");
                                ResultSet rsPaging = (ResultSet)request.getAttribute("rsPaging");
                                if(!rsPaging.isBeforeFirst()) {%>
                            <div class="notify-empty">Không có sản phẩm nào</div>
                            <%} 
                            while(rsPaging.next()) {
                            %>
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg">
                                        <a href="ProductDetailURL?ProductID=<%=rsPaging.getInt(1)%>">
                                            <img src="<%=rsPaging.getString("ProductURL")%>" alt="alt"/>
                                        </a>
                                        <%if(rsPaging.getInt("UnitDiscount")!=0) {%>
                                        <div class="sale-cotification"style="    margin-left: 77px;">Sale</div>
                                        <%}%>
                                        <%    ResultSet rsNewProduct = dao.getData("select * from product as p join productImage as pi "
                                           + "on p.ProductID = pi.ProductID "
                                           + "where pi.ProductURL = pi.ProductURLShow "
                                           + "order by p.CreateDate desc limit 6 ");
                                             while(rsNewProduct.next()) {
                                                if(rsPaging.getString("CreateDate").substring(0,10).equals(rsNewProduct.getString("CreateDate").substring(0,10))){%>
                                        <div class="sale-cotification">Mới</div>
                                        <%}}%>
                                    </div>
                                    <div class="product__item__text">
                                        <h6><%=rsPaging.getString("ProductName")%></h6>
                                        <%User testUser2 = (User)session.getAttribute("account");
                                           if(testUser2==null) {%>
                                        <a onclick="alertOpenCart()" class="add-cart">+ Thêm vào giỏ</a><a style="margin-left: 136px;" href="#">Mua ngay</a>
                                        <%}else{%>
                                        <a href="#" onclick="addToCart(<%=rsPaging.getInt(1)%>)" class="add-cart">+ Thêm vào giỏ</a><a style="margin-left: 136px;" href="#">Mua ngay</a>

                                        <%}%>
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
                                            <div style="color: red;font-weight: 700;font-size: 15px; flex: 0 0 50%; text-decoration: line-through;"><%=df.format(rsPaging.getDouble("UnitPrice"))%>đ</div>
                                            <div style="color: #0d0d0d;font-weight: 700;font-size: 15px; flex: 0 0 50%"><%=df.format(rsPaging.getDouble("UnitPrice")*(100-rsPaging.getInt("UnitDiscount"))/100)%>đ</div>
                                            <%} else {%>
                                            <div style="font-weight: 700;
                                                 font-size: 15px;
                                                 flex: -2 0 43%;
                                                 margin-left: 116px;
                                                 margin-top: -26px;"><%=df.format(rsPaging.getDouble("UnitPrice"))%>đ</div>
                                            <%}%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%}%>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="product__pagination blog__pagination" style="margin: 0;margin-left: 40px;">
                                    <%int endPage = (int)request.getAttribute("endPage");
                                    %>
                                    <c:set value="${requestScope.categoryID}" var="categoryID"/>
                                    <c:forEach begin="1" end="${endPage}" var="i">
                                        <!-- Price range is different from begin -->
                                        <c:if test="${requestScope.index == i}">
                                            <a class="active"  style="background: #7fad39;border-color: #7fad39;color: #ffffff;" href="ProductListURL?service=filter&CategoryID=${categoryID}&type=<%=type%>&index=${i}&TotalRate=${TotalRate}&filterChoice=<%=filterChoice%>&inputMinPrice=<%=oldMinPrice%>&inputMaxPrice=<%=oldMaxPrice%>">${i}</a>
                                        </c:if>
                                        <c:if test="${requestScope.index != i}">
                                            <a class="active"href="ProductListURL?service=filter&CategoryID=${categoryID}&type=<%=type%>&index=${i}&TotalRate=${TotalRate}&filterChoice=<%=filterChoice%>&inputMinPrice=<%=oldMinPrice%>&inputMaxPrice=<%=oldMaxPrice%>">${i}</a>
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
        <script>
            function alertOpenCart() {
                alert('Đăng nhập để xem giỏ hàng của bạn');
            }
        </script>
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    </body>

</html>