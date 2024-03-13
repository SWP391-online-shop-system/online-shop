<!DOCTYPE html> 
<html lang="en"> 
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8"%>
    <%@page import="java.sql.ResultSet"%>
    <%@page import="java.text.DecimalFormat" %>
    <%@page import="view.*" %>
    <%@page import="model.*" %>
    <head> 
        <meta charset="UTF-8"> 
        <meta name="viewport"
              content="width=device-width,initial-scale=1.0"> 
        <title>Responsive Form Card</title> 
        <link rel="stylesheet" href= 
              "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"> 
        <link rel="stylesheet" href="index.css"> 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="css/css_productList/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/magnific-popup.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/nice-select.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_productList/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/css_productDetail/style.css"/>
        <link rel="stylesheet" href="css/css_header/header.css"/>
        <link rel="stylesheet" href="css/css_footer/footer.css"/>
        <link rel="stylesheet" href="css/css_productList/style.css"/>
        <script src="https://kit.fontawesome.com/ac74b86ade.js" crossorigin="anonymous"></script>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/css_marketing_dashboard/marketing_dashboard_style.css" rel="stylesheet">
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link rel="shortcut icon" href="images/logo/logo.png" type="image/png">

    </head> 
    <style>
        /*style.css */

        a{
            color:black;
            text-decoration: none !important;
        }
        a:hover{
            color:black;
        }
        .rate {
            float: left;
            height: 46px;
            padding: 0 10px;
        }
        .rate:not(:checked) > input {
            position:absolute;
            top:-9999px;
        }
        .rate:not(:checked) > label {
            float:right;
            width:1em;
            overflow:hidden;
            white-space:nowrap;
            cursor:pointer;
            font-size:30px;
            color:#ccc;
        }
        .rate:not(:checked) > label:before {
            content: '★ ';
        }
        .rate > input:checked ~ label {
            color: #ffc700;
        }
        .rate:not(:checked) > label:hover,
        .rate:not(:checked) > label:hover ~ label {
            color: #deb217;
        }
        .rate > input:checked + label:hover,
        .rate > input:checked + label:hover ~ label,
        .rate > input:checked ~ label:hover,
        .rate > input:checked ~ label:hover ~ label,
        .rate > label:hover ~ input:checked ~ label {
            color: #c59b08;
        }

        body {
        }

        .textup {
            text-align: center;
            color: black;
            font-weight: 700;
        }

        i {
            margin-right: 3px;
        }

        .form-box {
            background-color: #fff;
            box-shadow: 0 0 5px rgba(36, 67, 40, 0.8);
            padding: 15px;
            border-radius: 3px;
            width: 487px;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
        }

        .radio-group {
            display: flex;
            margin-bottom: 16px;
        }

        input[type="radio"] {
            margin-right: 8px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-size: 17px;
            color: #378237;
        }

        input,
        textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 12px;
            box-sizing: border-box;
            border-radius: 10px;

        }

        button {
            background-color: #368b44;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            width: 100%;
            font-size: 15px;
            transition: .2s linear;
        }

        button:hover {
            background-color: #0a6808;
            border: none;
            transform: scale(1.1);
        }

        h1 {
            color: green;
        }
    </style>
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
        <div>
            <div class="mainPage">
                <div>
                    <div class="shop__sidebar__search">
                        <form action="searchPageURL" method="GET">
                            <input name="keyWord" type="text" placeholder="Search...">
                            <button type="submit"><i style="    float: right;
                                                     margin-top: -10px;" class="fa-solid fa-magnifying-glass"></i></button>
                        </form>
                    </div>
                    <div class="hottest-pro"style="margin-left: 23px;">
                        <div class="hottest-pro-title">Bán chạy nhất</div>
                        <div class="row" style="display: contents">
                            <%
                                DAOProduct dao = new DAOProduct();
                                ResultSet rsHotPro = dao.getData("select * from Product as p join ProductImage as pi on p.ProductID = pi.ProductID where  pi.ProductURL = pi.ProductURLShow \n"
                                                   +  "group by p.ProductID having min(p.TotalStock - p.UnitInStock) >0 order by (p.TotalStock - p.UnitInStock) desc limit 1");
                            if(rsHotPro.next()) {
                            %>
                            <div class="product__item" style="border: 1px solid #c1e8c1ba;
                                 border-radius: 40px;
                                 padding: 1px;
                                 width: 241px;">
                                <div class="product__item__pic set-bg" style="height: 201px;">
                                    <a href="ProductDetailURL?ProductID=<%=rsHotPro.getInt(1)%>">
                                        <img style="width: 192px;
                                             height: 174px;
                                             margin-left: 25px;
                                             margin-top: 10px;
                                             padding: 0px;" src="<%=rsHotPro.getString("ProductURL")%>" alt="alt"/>
                                    </a>
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
                                    <h6 style="text-align: center;"><%=rsHotPro.getString("ProductName")%></h6>
                                    <a href="cartDetailURL?serivce=addcart" class="add-cart" style="left: 12px;">+ Thêm vào giỏ</a><a style="margin-left: 136px;" href="#">Mua ngay</a>
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
                    <div class="card" style="margin-top: 85px;
                         margin-left: 23px;
                         border: none;
                         background: none;
                         box-shadow: none !important;">
                        <div class="card-heading">
                            <a data-toggle="collapse" data-target="#collapseOne" href="ProductListURL" style="    color: #111111;
                               font-size: 16px;
                               font-weight: 700;
                               text-transform: uppercase;
                               display: block;
                               margin-bottom:20px;">Danh mục</a>
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
                            <div class="card-body" style="padding:0">
                                <div class="shop__sidebar__categories">
                                    <ul class="nice-scroll">
                                        <li><a style="color: #f7a749;" href="ProductListURL">Tất cả sản phẩm</a></li>
                                            <%String type = (String)request.getAttribute("type");
                                            if(type==null || type.equals("")) {
                                            type = "";
                                                }
                                                double maxP = dao.getMaxUnitPrice();
                                                double minP =dao.getMinUnitPrice();
                                            %>
                                        <li class="unique-li" style="<%=type.equals("showSale")?"background: #0091ff2b; width:190px;":""%>"><a style=" color: #f7a749;" href="ProductListURL?service=filter&TotalRate=<%=TotalRate%>&type=showSale&CategoryID=${categoryID}&filterChoice=p.CreateDate%20desc&inputMinPrice=<%=minP%>&inputMaxPrice=<%=maxP%>&index=1">Đang giảm giá</a></li>
                                            <%while(rsCategory.next()) {%>
                                        <li><a href="ProductListURL?service=filter&type=<%=type%>&CategoryID=<%=rsCategory.getInt(1)%>&TotalRate=<%=TotalRate%>&filterChoice=p.CreateDate%20desc&inputMinPrice=<%=minP%>&inputMaxPrice=<%=maxP%>&index=1"><%=rsCategory.getString(2)%></a></li>
                                            <%}%>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                              Product pro = new Product();
                              DAOProduct daoPro = new DAOProduct();
                              ResultSet rsProduct = (ResultSet)request.getAttribute("rsProduct");
                              if(rsProduct.next()){
                %>
                <div style="display: flex;
                     margin-left: 75px;
                     margin-top: 17px;">
                    <div class="form-box" style="height: 307px !important; width: 332px;margin-right: 30px;"> 
                        <div style="margin-bottom: 0px;
                             font-size: 20px;" class="textup"> 
                            <i  class="fa fa-solid "></i> 
                            <%=rsProduct.getString("ProductName")%>
                        </div> 
                        <div class="form-group">
                            <img style="width: 217px;
                                 height: 212px !important;
                                 margin-left: 35px;
                                 margin-top: -3px;" src="<%=rsProduct.getString("ProductURL")%>" alt="">
                        </div>
                        <div style="margin-bottom: 25px;
                             font-size: 17px;" class="textup"> 
                            <i  class="fa fa-solid "></i> 
                            Giá bán: <%=df.format(rsProduct.getDouble("UnitPrice")*(100-rsProduct.getInt("UnitDiscount"))/100)%>đ
                        </div>
                        <form action="HomePageURL" method="get">
                            <button style="margin-top: 22px;
                                    border-radius: 3px;
                                    width: 100px;
                                    height: 34px;
                                    padding: 0px;
                                    background: #50a950;
                                    float: right;
                                    margin-right: -15px;" type="submit">Quay lại</button>
                        </form>
                    </div> 
                    <script>
                    </script>
                    <div class="form-box" style="height: 605px;"> 
                        <div style="    margin-bottom: 25px;
                             font-size: 20px;" class="textup"> 
                            <i  class="fa fa-solid fa-clock"></i> 
                            Chỉ mất 2 phút, hãy để lại phản hồi của bạn!
                        </div> 
                        <form id="myForm" action="feedback" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="service" value="upload"/>
                            <input type="hidden" name="ProductID" value="<%=rsProduct.getInt("ProductID")%>"/>
                            <div class="form-group">
                                <label>Ảnh đính kèm</label>
                                <div style="height: 169px;
                                     width: 282px;
                                     border: 1px solid;
                                     margin-bottom: 10px;">
                                    <img id="feedback-image" style="width: 282px;
                                         height: 169px !important;" src="images/feedback/">
                                </div>
                                <input value=""  type="file" 
                                       class="form-control" name="feedbackImg" placeholder="Enter photo" id="feedback-img-input">
                            </div>
                            <div class="form-group">
                                <div style="display: flex; align-items: center">
                                    <label for="rating">Đánh giá:</label>
                                    <div style="margin-bottom: 4px;" class="rate">
                                        <input type="radio" id="star5" name="rate" value="5" />
                                        <label style="font-size: 25px;" for="star5" title="text">5 stars</label>
                                        <input type="radio" id="star4" name="rate" value="4" />
                                        <label style="font-size: 25px;" for="star4" title="text">4 stars</label>
                                        <input type="radio" id="star3" name="rate" value="3" />
                                        <label style="font-size: 25px;" for="star3" title="text">3 stars</label>
                                        <input type="radio" id="star2" name="rate" value="2" />
                                        <label style="font-size: 25px;" for="star2" title="text">2 stars</label>
                                        <input type="radio" id="star1" name="rate" value="1" />
                                        <label style="font-size: 25px;" for="star1" title="text">1 star</label>
                                    </div>
                                </div>                  
                                <label for="msg"> 
                                    <i class="fa-solid fa-comments" 
                                       style="margin-right: 3px;"></i> 
                                    Thêm nhận xét của bạn tại đây: 
                                </label> 
                                <textarea id="msg" name="msg" style="height: 100px;"
                                          required> 
                                </textarea> 
                                <button type="submit" style="border-radius: 4px;width: 200px;text-align: center;background: #50a950;"> 
                                    Tạo đánh giá 
                                </button> 
                            </div>
                            <%}%>
                        </form> 
                    </div> 
                </div>
            </div>
        </div>
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
    </body> 

    <script>
        document.getElementById('feedback-img-input').addEventListener('change', function (e) {
            var reader = new FileReader();
            reader.onload = function (event) {
                document.getElementById('feedback-image').src = event.target.result;
            };
            reader.readAsDataURL(e.target.files[0]);
        });
        var form = document.getElementById("myForm");
        form.addEventListener("submit", function (event) {
            event.preventDefault(); // Ngăn chặn hành vi mặc định của biểu mẫu

            var textarea = form.querySelector('textarea[name="msg"]');
            var content = textarea.value.trim(); // Lấy nội dung và xóa khoảng trắng đầu và cuối chuỗi

            if (content === "") {
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi',
                    text: 'Hãy điền nội dung'
                });
            } else if (content.length > 250) {
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi',
                    text: 'Nội dung phải có ít hơn 250 ký tự.'
                });
            } else {
                // Gửi biểu mẫu nếu điều kiện hợp lệ
                form.submit();
            }
        });
    </script>
    <script src="js/manager.js" type="text/javascript"></script>
</html>
