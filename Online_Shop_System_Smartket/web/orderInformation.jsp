<%-- 
    Document   : orderInformation
    Created on : Mar 2, 2024, 6:06:16 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="view.*" %>
<%@page import="model.DAOReceiver" %>
<%@page import="model.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="en">
    <!-- Basic -->

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">

        <!-- Mobile Metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Site Metas -->
        <title>Thông tin đơn </title>
        <meta name="keywords" content="">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Site Icons -->
        <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
        <link rel="apple-touch-icon" href="images/apple-touch-icon.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/css_orderdetail/bootstrap.min.css">
        <!-- Site CSS -->
        <link rel="stylesheet" href="css/css_orderdetail/style.css">
        <!-- Responsive CSS -->
        <link rel="stylesheet" href="css/css_orderdetail/responsive.css">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/css_orderdetail/custom.css">
        <link rel="stylesheet" href="css/css_footer/footer.css" type="text/css">
        <link rel="stylesheet" href="css/css_header/header.css" type="text/css">
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/css_productList/style.css" type="text/css">
        <style>
            .form-control:disabled, .form-control[readonly] {
                background: white;
            }
            #baguetteBox-overlay{
                display:none;
            }
            .btn-rebuy{
                float: right;
                width: 66px;
                font-size: 12px;
                height: 26px;
                background: #59c762;
                border-radius: 2px;
                border: none;
                transition: all 0.5s;
            }
            .btn-rebuy:hover{
                transform: scale(0.95);
                cursor: pointer;
            }
            a{
                color:black;
                text-decoration: none !important;
            }
            a:hover{
                color: black;
            }
            footer{
                font-family: ui-monospace;
            }
            #blocka:hover{
                cursor: not-allowed;
                transform: none;
            }
        </style>
    </head>

    <body>
        <%DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);%>
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
                    <div class="header-title-right-about" style="font-size: 14px;">
                        <a href="#">Về chúng tôi</a>
                    </div>
                    <div class="header-title-right-login" style="font-size: 14px;">
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
                                                                   margin-bottom: -1px;
                                                                   margin-left: 7px;
                                                                   border-radius: 50%;" class="styling1" src="images/user/${sessionScope.account.userImage}" alt="Admin Image"></a>
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
                                int userID = (int)request.getAttribute("UserID");
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
        <!--header end-->
        <div class="cart-box-main">
            <div class="container">
                <div class="row" style="width: 106%;">
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
                                                ResultSet rsHotPro = dao.getData("select * from Product as p join ProductImage as pi on p.ProductID = pi.ProductID where  pi.ProductURL = pi.ProductURLShow \n"
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
                                                       + "where pi.ProductURL like '%_1%' "
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
                                            <div class="card-body" style="box-sizing: unset;
                                                 padding-left: 30px;
                                                 padding-top: 6px;">
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
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        ResultSet rsReceiver = (ResultSet)request.getAttribute("rsReceiver");
                        ResultSet rsOrder = (ResultSet)request.getAttribute("rsOrder");
                        ResultSet rsOrderDetail = (ResultSet)request.getAttribute("rsOrderDetail");
                        DAOProduct daoP = new DAOProduct();
                        
                    %>
                    <div class="col-sm-6 col-lg-6 mb-3" style="flex: 0 0 33%;margin-right: 13px;">
                        <div class="checkout-address">
                            <div class="title-left">
                                <h3>Thông tin đơn hàng</h3>
                            </div>
                            <%if(rsReceiver.next()) {%>
                            <form class="needs-validation" >
                                <div class="row">
                                </div>
                                <div class="mb-3">
                                    <label for="username">Người nhận:</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="username" readonly value="<%=rsReceiver.getString("ReceiverName")%>">
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="email" style="margin-right: 30px;">Giới tính:</label>
                                    <input type="radio" id="email" readonly placeholder="" disabled style="margin-right: 3px;" <%=rsReceiver.getInt("ReceiverGender")==0?"checked":""%> value="Nam">Nam
                                    <input style="margin-left: 30px; margin-right: 3px;" type="radio" disabled <%=rsReceiver.getInt("ReceiverGender")==1?"checked":""%> value="Nữ">Nữ
                                </div>

                                <div class="mb-3">
                                    <label for="address">Email:</label>
                                    <input type="text" class="form-control" id="address" placeholder="" readonly value="<%=rsReceiver.getString("ReceiverEmail")%>">
                                </div>
                                <div class="mb-3">
                                    <label for="address2">Số điện thoại:</label>
                                    <input type="text" class="form-control" id="address2" placeholder="" readonly value="<%=rsReceiver.getString("ReceiverPhoneNumber")%>"> 
                                </div>
                                <div class="mb-3">
                                    <label for="address2">Địa chỉ:</label>
                                    <input type="text" class="form-control" id="" placeholder="" readonly value="<%=rsReceiver.getString("ReceiverAddress")%>"/> 
                                </div>
                                <hr class="mb-4">
                            </form>
                            <%}%>
                        </div>
                        <button class="btn-rebuy" style="margin-top: 14px;width: 70px;float:left;background: #59c762;"><a style="color: white;font-size: 14px;"href="MyOrderURL">Trở về</a></button>

                        <button style="    width: 104px;
                                height: 26px;
                                margin-top: 14px;
                                font-size: 14px;
                                margin-right: -1px;
                                color: white;" type="button" class="btn-rebuy" data-toggle="modal" data-target="#exampleModalLong"
                                id="#modalLong">Mã thanh toán</button>
                    </div>


                    <div class="col-sm-6 col-lg-6 mb-3"style="flex: 0 0 40%">
                        <div class="row">
                            <div class="col-md-12 col-lg-12">
                                <div class="ord-box">
                                    <div class="title-left">
                                        <h3>Đơn hàng của bạn</h3>
                                    </div>
                                    <%
                                    String qr = "";
                                    int orderId = 0;
                                    Order getOrder = new Order();
                                    if(rsOrder.next()) {
                                    orderId = rsOrder.getInt("OrderID");
                                    qr = rsOrder.getString("OrderImage");
                                    getOrder = new Order(
                    //int, int, int, int, double, String, String, int, boolean, String
                    rsOrder.getInt("OrderID"),
                    rsOrder.getInt("UserID"),
                    rsOrder.getInt("SaleID"),
                    rsOrder.getInt("Quantity"),
                    rsOrder.getDouble("TotalPrice"),
                    rsOrder.getString("OrderDate"),
                    rsOrder.getString("ShippedDate"),
                    rsOrder.getInt("StatusID"),
                    rsOrder.getBoolean("OrderStatus"),
                    rsOrder.getString("OrderImage")
            );
                                    String status = "";
                                    switch(rsOrder.getInt("StatusID")){case 1:status = "Chờ xác nhận";break;
                                     case 2:status = "Đang xử lý";break;
                                     case 3:status = "Đang giao hàng";break;
                                     case 4:status = "Đã giao thành công";break;
                                     case 5:status = "Giao hàng không thành công";break;
                                        }
                                    %>
                                    <div class="d-flex">
                                        <div class="font-weight-bold">Mã đơn hàng:</div>
                                        <div class="ml-auto font-weight-bold"><%=rsOrder.getInt("OrderID")%></div>
                                    </div>
                                    <hr class="my-1">
                                    <div class="d-flex">
                                        <h4 style="font-size: 16px;margin-bottom: 6px;margin-top: 9px;">Ngày đặt hàng:</h4>
                                        <div class="ml-auto"><%=rsOrder.getString("OrderDate")%></div>
                                    </div>
                                    <div class="d-flex">
                                        <h4 style="font-size: 16px;margin-bottom: 6px;margin-top: 9px;">Trạng thái đơn hàng:</h4>
                                        <div class="ml-auto font-weight-bold"><%=status%></div>
                                    </div>
                                    <hr class="my-1">
                                    <div class="d-flex gr-total">
                                        <h5 style="font-size: 18px;margin-bottom: 6px;margin-top: 9px;color: #59c762;">Thành tiền</h5>
                                        <div class="ml-auto h5" style="padding-top: 7px;font-size: 18px;"><%=df.format(rsOrder.getDouble("TotalPrice"))%>đ</div>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                            <hr style="">
                            <div class="col-md-12 col-lg-12">
                                <hr>
                                <div class="order-box">
                                    <div class="title-left">
                                        <%  int OrderID = (int)request.getAttribute("OrderID");
                                        ResultSet rsCountProduct = daoP.getData("select count(ProductID) from `OrderDetail` where OrderID = "+OrderID);
                                         if(rsCountProduct.next()) {
                                        %>
                                        <h3>Chi tiết sản phẩm (<%=rsCountProduct.getInt(1)%>)</h3>
                                        <%}%>
                                    </div>
                                    <table>
                                        <tr>
                                            <th style=" width: 246px;padding-left: 17px;">Tên sản phẩm</th>
                                            <th></th>
                                            <th style="padding-left: 32px;">Loại</th>
                                        </tr>
                                    </table>
                                    <div style="overflow-y: scroll;height: auto;max-height: 250px;">
                                        <%DAOCategories daoCate = new DAOCategories();
                                        DAOProductImage daoI = new DAOProductImage();
                                        while(rsOrderDetail.next()){
                                        Product product = daoP.getProductById(rsOrderDetail.getInt("ProductID"));
                                        ProductImage productImage = daoI.getProductImageByProductID(product.getProductID());
                                        Categories categories = daoCate.getCategoriesById(product.getCategoryID());
                                        %>
                                        <div class="rounded p-2 bg-light" style="margin-bottom: 15px;">
                                            <div class="media mb-2 border-bottom" style="display: block;">
                                                <div>
                                                    <table>
                                                        <tr>
                                                            <td><img style="    width: 50px;
                                                                     border: none;
                                                                     height: 50px;
                                                                     border-radius: 4px;
                                                                     margin-right: 12px;" src="<%=productImage.getProductURLShow()%>"/></td>
                                                            <td style="font-size: 14px;width: 160px;"><div class="media-body"> <a href="ProductDetailURL?ProductID=<%=product.getProductID()%>"><%=product.getProductName()%></a></td>
                                                            <td style="font-size: 14px;padding-left: 25px;"><%=categories.getCategoryName()%></td>

                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="small text-muted" style="color: black;">Giá tiền:&nbsp;<%=df.format(rsOrderDetail.getDouble("UnitPrice"))%>đ<span class="mx-2" style="margin-left: 0px !important;margin-right: 0px !important;">|</span> Số lượng:&nbsp;<%=rsOrderDetail.getInt("QuantityPerUnit")%> <span class="mx-2"style="margin-left: -2px !important;margin-right: -2px !important;">|
                                                    </span> Tổng tiền:&nbsp;<%=df.format(rsOrderDetail.getDouble("UnitPrice")*rsOrderDetail.getInt("QuantityPerUnit"))%>đ
                                                    <%if(getOrder.getStatusID() == 4 && rsOrderDetail.getInt("isFeedback") == 0) {%>
                                                    <button class="btn-rebuy" style="width: 88px;margin-top: -6px;">
                                                        <a href="feedback?service=gofeedback&ProductID=<%=product.getProductID()%>&orderID=<%=rsOrderDetail.getInt("orderID")%>" style="color: white">phản hồi</a>
                                                    </button>
                                                    <%}else{%>
                                                    <button id="blocka" class="btn-rebuy" style="width: 88px;margin-top: -6px; background: grey">
                                                        <a  style="color:whitesmoke" title="Phản hồi sẽ được mở khi bạn nhận được hàng">Gửi phản hồi</a>
                                                    </button>
                                                    <%}%>
                                                </div>
                                            </div>
                                        </div>  
                                        <%}%>
                                    </div>
                                    <button class="btn-rebuy" style="width: 70px;height: 26px;margin-top: 17px;font-size: 14px;"><a style="color: white;" href="CartURL?service=rebuy&OrderID=<%=orderId%>">Mua lại</a></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog"
                 aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <img style="width: 300px;height: 300px;margin-left: 142px;" src="<%=qr%>"/>
                </div>
            </div>
        </div>
        <footer class="footer_1">
            <div class="container_1" style="height: 270px;padding-top: 28px;">
                <div class="row_1">
                    <div class="col_1" id="company" style="font-family: ui-monospace;">
                        <img style="width: 176px;
                             margin-bottom: -19px;
                             margin-top: 10px;height: 136px;" src="images/logo/logo.png" alt="" class="logo_1">
                        <p style="font-family: ui-monospace;font-size: 15px;color: white;">
                            công ty Smartket Việt Nam, 54 Liễu Giai, quận Ba Đình, Hà Nội 
                        </p>
                        <div class="social_1">
                            <a href="#"><i class="fab fa-facebook"></i></a>
                            <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
                        </div>
                    </div>


                    <div class="col_1" id="services" style="font-family: ui-monospace;">
                        <h3 class="footer_title_1" style="font-family: ui-monospace;">Dịch vụ</h3>
                        <div class="links_1">
                            <a href="#">Tuyển dụng</a>
                            <a href="#">Quảng cáo</a>
                            <a href="#">Chính sách</a>
                        </div>
                    </div>

                    <div class="col_1" id="useful-links" style="margin-left: 50px;margin-right: 50px;font-family: ui-monospace;">
                        <h3 class="footer_title_1" style="font-family: ui-monospace;">Đường dẫn</h3>
                        <div class="links_1">
                            <a href="#">Về chúng tôi</a>
                            <a href="#">Danh mục</a>
                            <a href="#">Tin tức</a>
                            <a href="#">Hỗ trợ</a>
                        </div>
                    </div>

                    <div class="col_1" id="contact" style="font-family: ui-monospace;">
                        <h3 class="footer_title_1" style="font-family: ui-monospace;">Liên hệ</h3>
                        <div class="contact-details_1">
                            <i class="fa-regular fa-envelope"></i>
                            <p style="color: white;">Smartket@gmail.com</p>
                        </div>
                        <div class="contact-details_1" style="font-family: ui-monospace;">
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
        <!-- End Cart -->
        <!-- ALL JS FILES -->
        <script src="js_orderdetail/jquery-3.2.1.min.js"></script>
        <script src="js_orderdetail/popper.min.js"></script>
        <script src="js_orderdetail/bootstrap.min.js"></script>
        <!-- ALL PLUGINS -->
        <script src="js_orderdetail/jquery.superslides.min.js"></script>
        <script src="js_orderdetail/bootstrap-select.js"></script>
        <script src="js_orderdetail/inewsticker.js"></script>
        <script src="js_orderdetail/bootsnav.js."></script>
        <script src="js_orderdetail/images-loded.min.js"></script>
        <script src="js_orderdetail/isotope.min.js"></script>
        <script src="js_orderdetail/owl.carousel.min.js"></script>
        <script src="js_orderdetail/baguetteBox.min.js"></script>
        <script src="js_orderdetail/form-validator.min.js"></script>
        <script src="js_orderdetail/contact-form-script.js"></script>
        <script src="js_orderdetail/custom.js"></script>
    </body>
</html>